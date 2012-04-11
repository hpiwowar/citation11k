





# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on `Wed Apr 11 07:25:45 2012`

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("statsmall_knit_.md")

or, from the command line

    R -e "library(knitr); knit('statsmall_knit_.md')"
    pandoc -r markdown -w html -H header.html statsmall.md > temp.html
    file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/test.html









# Data availability citation boost consistent with observed rates of data reuse

## Methods

### Assemble citation dataset

PLoS papers, as identified in PLoS ONE study:

- Piwowar HA (2011) Who shares? Who doesn’t? Factors associated with openly archiving raw research data. PLoS ONE 6(7): e18657. doi:10.1371/journal.pone.0018657
- Piwowar HA (2011) Data from: Who shares? Who doesn’t? Factors associated with openly archiving raw research data. Dryad Digital Repository. doi:10.5061/dryad.mf1sd



```r
dfAttributes = read.csv("data/PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)
```




Got the citations from Scopus:



```r
dfCitations = read.csv("data/scopus_all.csv", header=TRUE, stringsAsFactors=F)
```




Now merge together attributes with citation information.



```r
dfCitationsAttributesRaw = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")
```




The dataset has `1.0694 &times; 10<sup>4</sup>` rows and `196`  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

### Statistical analysis



####Preprocessing


Limit to just those published after 2001 and before 2010.



```r
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published > 2000)
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published < 2010)
dim(dfCitationsAttributesRaw)
```



```
## [1] 10555   196
```




Get citations into the right format



```r
dfCitationsAttributesRaw$nCitedBy = as.numeric(dfCitationsAttributesRaw$Cited.by)
dfCitationsAttributesRaw[which(is.na(dfCitationsAttributesRaw$nCitedBy)),]$nCitedBy=0
dim(dfCitationsAttributesRaw)
```



```
## [1] 10555   197
```



```r
 
source("helpers.R")
source("preprocess_raw_data.R")
 
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
dim(dfCitationsAttributes)
```



```
## [1] 10555    86
```



```r
options(scipen=8)
```





The dataset has `1.0555 &times; 10<sup>4</sup>` rows and `86`  columns. 


## Results


### Analysis of 11k PLoS articles based on automated determination of data availability

#### Description of cohort

The PLoS study had `1.1603 &times; 10<sup>4</sup>` rows.  For this study we exclude extreme years.

The dataset has `1.0555 &times; 10<sup>4</sup>` rows and `86`  columns.  


Distribution by journal


```r
a = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:10]
gfm_table(cbind(names(a), round(a, 2)))
```



```
## | Cancer Res               | 0.04 |
## | Proc Natl Acad Sci U S A | 0.04 |
## | J Biol Chem              | 0.04 |
## | BMC Genomics             | 0.03 |
## | Physiol Genomics         | 0.03 |
## | PLoS One                 | 0.02 |
## | J Bacteriol              | 0.02 |
## | J Immunol                | 0.02 |
## | Blood                    | 0.02 |
## | Clin Cancer Res          | 0.02 |
```




Distribution by year


```r
gfm_table(table(dfCitationsAttributesRaw$pubmed_year)/nrow(dfCitationsAttributesRaw))
```



```
## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
```




Distribution by data availability


```r
gfm_table(table(dfCitationsAttributesRaw$in_ae_or_geo)/nrow(dfCitationsAttributesRaw))
```



```
## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
```




Distribution by citation

The dataset has `1.0555 &times; 10<sup>4</sup>` rows and `86`  columns.  




```r
qplot(nCitedBy.log, data=dfCitationsAttributes)
```

<img src="http://i.imgur.com/fptHb.png" class="plot" />





```r
summary(dfCitationsAttributes$nCitedBy)
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    29.5    34.0  2560.0 
```




#### Univariate



```r
dat = dfCitationsAttributes

# Number of papers vs Data availability
tapply(dat$nCitedBy>=0,
       dat$dataset.in.geo.or.ae.int,
       sum)
```



```
##    0    1 
## 7938 2617 
```



```r

# Number of citations vs Data availability
tapply(dat$nCitedBy,
       dat$dataset.in.geo.or.ae.int,
       sum)
```



```
##      0      1 
## 250620  81892 
```



```r

# Number of citations vs Data availability
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, summary))
```



```
## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
```



```r

table(dat$dataset.in.geo.or.ae.int)
```



```
## 
##    0    1 
## 7938 2617 
```



```r
boxplot(nCitedBy+1 ~ dataset.in.geo.or.ae.int,
        data = dat,
        boxwex = 0.5, 
        names=c("Data Not Shared", "Data Shared"), 
        ylab = "Number of Citations", outline=T, notch=F, log="y")
```

<img src="http://i.imgur.com/X9kD2.png" class="plot" />


    


```r
source("helpers.R")

dat = dfCitationsAttributes
myhetcorr = hetcor.modified(dat, use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycor = myhetcorr$correlations
colnames(mycor) = colnames(myhetcorr$correlations)    
rownames(mycor) = rownames(myhetcorr$correlations)    

a = sort(mycor[,"nCitedBy.log"], dec=T)
gfm_table(cbind(names(a), round(a, 2)))
```



```
## | nCitedBy.log                                  | 1     |
## | pubmed.num.cites.from.pmc.tr                  | 0.76  |
## | years.ago.tr                                  | 0.59  |
## | pubmed.num.cites.from.pmc.per.year            | 0.59  |
## | nCitedBy                                      | 0.58  |
## | journal.impact.factor.log                     | 0.47  |
## | journal.impact.factor.tr                      | 0.45  |
## | journal.5yr.impact.factor.log                 | 0.45  |
## | journal.immediacy.index.log                   | 0.44  |
## | last.author.num.prev.pmc.cites.tr             | 0.3   |
## | journal.num.articles.2008.tr                  | 0.25  |
## | last.author.year.first.pub.ago.tr             | 0.24  |
## | institution.mean.norm.citation.score          | 0.24  |
## | first.author.num.prev.pmc.cites.tr            | 0.24  |
## | journal.microarray.creating.count.tr          | 0.23  |
## | institution.harvard                           | 0.22  |
## | first.author.year.first.pub.ago.tr            | 0.22  |
## | institution.stanford                          | 0.21  |
## | country.usa                                   | 0.18  |
## | institution.mean.norm.impact.factor           | 0.18  |
## | num.authors.tr                                | 0.17  |
## | pubmed.is.core.clinical.journal               | 0.17  |
## | last.author.num.prev.pubs.tr                  | 0.15  |
## | nih.first.year.ago.tr                         | 0.15  |
## | institution.nci                               | 0.14  |
## | journal.cited.halflife                        | 0.14  |
## | pubmed.is.shared.other                        | 0.12  |
## | institution.research.output.tr                | 0.1   |
## | has.T.funding                                 | 0.1   |
## | num.grant.numbers.tr                          | 0.09  |
## | pubmed.is.prognosis                           | 0.09  |
## | has.R01.funding                               | 0.09  |
## | pubmed.is.humans                              | 0.08  |
## | max.grant.duration.tr                         | 0.08  |
## | pubmed.is.funded.nih                          | 0.07  |
## | has.R.funding                                 | 0.07  |
## | pubmed.is.plants                              | 0.07  |
## | pubmed.is.comparative.study                   | 0.06  |
## | first.author.num.prev.pubs.tr                 | 0.06  |
## | pubmed.is.cancer                              | 0.06  |
## | has.P.funding                                 | 0.06  |
## | nih.max.max.dollars.tr                        | 0.06  |
## | institution.international.collaboration       | 0.05  |
## | pubmed.is.diagnosis                           | 0.04  |
## | nih.cumulative.years.tr                       | 0.03  |
## | country.uk                                    | 0.03  |
## | has.U.funding                                 | 0.03  |
## | pubmed.is.effectiveness                       | 0.02  |
## | nih.sum.sum.dollars.tr                        | 0.02  |
## | num.grants.via.nih.tr                         | 0.02  |
## | nih.sum.avg.dollars.tr                        | 0.01  |
## | pubmed.is.bacteria                            | 0.01  |
## | last.author.num.prev.microarray.creations.tr  | 0.01  |
## | dataset.in.geo.or.ae                          | 0.01  |
## | pubmed.is.funded.non.us.govt                  | 0.01  |
## | dataset.in.geo.or.ae.int                      | 0     |
## | institution.is.medical                        | 0     |
## | country.france                                | 0     |
## | pubmed.is.fungi                               | 0     |
## | first.author.gender.not.found                 | -0.01 |
## | pubmed.is.cultured.cells                      | -0.01 |
## | institution.is.govnt                          | -0.01 |
## | first.author.num.prev.microarray.creations.tr | -0.01 |
## | pubmed.is.geo.reuse                           | -0.01 |
## | pubmed.is.mice                                | -0.02 |
## | pubmed.is.viruses                             | -0.02 |
## | dataset.in.geo                                | -0.02 |
## | country.germany                               | -0.02 |
## | country.australia                             | -0.02 |
## | pubmed.is.funded.nih.intramural               | -0.03 |
## | nih.last.year.ago.tr                          | -0.04 |
## | has.K.funding                                 | -0.04 |
## | last.author.gender.not.found                  | -0.04 |
## | country.canada                                | -0.05 |
## | institution.rank                              | -0.06 |
## | last.author.female                            | -0.07 |
## | institution.is.higher.ed                      | -0.07 |
## | first.author.female                           | -0.08 |
## | country.japan                                 | -0.1  |
## | pubmed.is.animals                             | -0.11 |
## | country.china                                 | -0.19 |
## | country.korea                                 | -0.26 |
## | pubmed.is.open.access                         | -0.3  |
## | pmid                                          | -0.58 |
## | pubmed.year.published                         | -0.58 |
## | pubmed.date.in.pubmed                         | -0.59 |
```



```r

    
univarate.citation.predictors = which(abs(mycor[,"nCitedBy.log"]) > 0.1)
#univarate.citation.predictors
length(univarate.citation.predictors)    
```



```
## [1] 36
```



```r
topcor = mycor[univarate.citation.predictors, univarate.citation.predictors]



heatmap.2(topcor, col=bluered(16), cexRow=1, cexCol = 1, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)
```

<img src="http://i.imgur.com/qnsFx.png" class="plot" />


```
## Error: figure margins too large
```



```r

```



    


```r
 

dat.subset = dfCitationsAttributes
with(dat.subset, tapply(nCitedBy, pubmed.year.published, median, na.rm=T))
```



```
## 2001 2002 2003 2004 2005 2006 2007 2008 2009 
## 76.0 54.0 40.0 30.0 24.0 18.0 14.0  9.5  5.0 
```



```r


num_authors_breaks = c(1, 5, 10, 20, 40)
citation_breaks = c(1, 10, 40, 100, 400, 1000)

with(dat.subset, tapply(nCitedBy, cut(num.authors.tr, num_authors_breaks), median, na.rm=T))
```



```
##   (1,5]  (5,10] (10,20] (20,40] 
##      16      38      53      NA 
```



```r


qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/REDbU.png" class="plot" />


```r

qplot(pubmed.date.in.pubmed, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/URkGh.png" class="plot" />


```r


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/l4DZq.png" class="plot" />


```r

qplot(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/99TCy.png" class="plot" />


```r

qplot(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/RV9zp.png" class="plot" />


```r

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/ApqeP.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/a29c7.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)
qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/zod1N.png" class="plot" />


```r

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="http://i.imgur.com/IRwpS.png" class="plot" />


```r


```




#### Multivariate



##### All years



```r

###### ANALYSIS
  
# Some helper functions
calcCI.exp= function(res, param) {
  coefs = summary(res)$coeff
  coeff = coefs[param,]
  x = coeff[1]
  stderr = coeff[2]
  p = coeff[4]
  return(data.frame(param = param,
              est = round(exp(x), 2), 
              ciLow = round(exp(x - 1.96*stderr), 2),
              ciHigh = round(exp(x + 1.96*stderr), 2), 
              p = round(p, 3)))
}

calcCI.noexp= function(res, param) {
  coefs = summary(res)$coeff
  coeff = coefs[param,]
  x = coeff[1]
  stderr = coeff[2]
  p = coeff[4]
  return(data.frame(param = param,
              est = round(x, 2), 
              ciLow = round(x - 1.96*stderr, 2),
              ciHigh = round(x + 1.96*stderr, 2), 
              p = round(p, 3)))
}

      

#### Looks like this is the analysis
fit = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) +
rcs(first.author.num.prev.pubs.tr, 3) +           
rcs(first.author.num.prev.pmc.cites.tr, 3) +     
rcs(first.author.year.first.pub.ago.tr, 3) +     
rcs(last.author.num.prev.pubs.tr, 3) +           
rcs(last.author.num.prev.pmc.cites.tr, 3) +      
rcs(last.author.year.first.pub.ago.tr, 3) +
country.usa +              
pubmed.is.open.access +              
rcs(institution.mean.norm.citation.score, 3) +
rcs(journal.num.articles.2008.tr, 3) +           
rcs(journal.cited.halflife, 3) +                 
rcs(journal.impact.factor.tr, 3) +               
factor(pubmed.is.cancer) +
factor(pubmed.is.animals) +
factor(pubmed.is.plants) +
factor(pubmed.is.core.clinical.journal) +
factor(dataset.in.geo.or.ae)
           , dfCitationsAttributes)


gfm_table(anova(fit))
```



```
## |                                              | Df      | Sum Sq  | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|---------|---------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00    | 157.47  | 78.74   | 148.18  | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1625.79 | 812.90  | 1529.82 | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 6.63    | 3.32    | 6.24    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 185.61  | 92.80   | 174.65  | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 3.42    | 1.71    | 3.22    | 0.04   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 6.14    | 3.07    | 5.78    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 113.18  | 56.59   | 106.50  | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 2.95    | 1.48    | 2.78    | 0.06   |
## | country.usa                                  | 1.00    | 4.37    | 4.37    | 8.22    | 0.00   |
## | pubmed.is.open.access                        | 1.00    | 4.52    | 4.52    | 8.50    | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 11.08   | 5.54    | 10.43   | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00    | 40.96   | 20.48   | 38.54   | 0.00   |
## | rcs(journal.cited.halflife, 3)               | 2.00    | 5.25    | 2.63    | 4.94    | 0.01   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00    | 351.48  | 175.74  | 330.73  | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00    | 14.15   | 14.15   | 26.64   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00    | 12.49   | 12.49   | 23.51   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 15.35   | 15.35   | 28.89   | 0.00   |
## | factor(pubmed.is.core.clinical.journal)      | 1.00    | 3.89    | 3.89    | 7.32    | 0.01   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 21.69   | 21.69   | 40.82   | 0.00   |
## | Residuals                                    | 4240.00 | 2253.00 | 0.53    |         |        |
```



```r

fit
```



```
## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(num.authors.tr, 3) + rcs(pubmed.date.in.pubmed, 
##     3) + rcs(first.author.num.prev.pubs.tr, 3) + rcs(first.author.num.prev.pmc.cites.tr, 
##     3) + rcs(first.author.year.first.pub.ago.tr, 3) + rcs(last.author.num.prev.pubs.tr, 
##     3) + rcs(last.author.num.prev.pmc.cites.tr, 3) + rcs(last.author.year.first.pub.ago.tr, 
##     3) + country.usa + pubmed.is.open.access + rcs(institution.mean.norm.citation.score, 
##     3) + rcs(journal.num.articles.2008.tr, 3) + rcs(journal.cited.halflife, 
##     3) + rcs(journal.impact.factor.tr, 3) + factor(pubmed.is.cancer) + 
##     factor(pubmed.is.animals) + factor(pubmed.is.plants) + factor(pubmed.is.core.clinical.journal) + 
##     factor(dataset.in.geo.or.ae), data = dfCitationsAttributes)
## 
## Coefficients:
##                                                                       (Intercept)  
##                                                                         21.293330  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.221304  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                         -0.000298  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.000564  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                         -0.000247  
##                rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr  
##                                                                         -0.025108  
##               rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr'  
##                                                                          0.000182  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.044084  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                         -0.040443  
##      rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr  
##                                                                         -0.071372  
##     rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr'  
##                                                                          0.033941  
##                  rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr  
##                                                                         -0.023844  
##                 rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr'  
##                                                                          0.023037  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                          0.008025  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                         -0.005013  
##        rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr  
##                                                                          0.027816  
##       rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr'  
##                                                                         -0.050297  
##                                                                     country.usa.L  
##                                                                          0.034654  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.073598  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.095489  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.083236  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.002671  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.005990  
##                              rcs(journal.cited.halflife, 3)journal.cited.halflife  
##                                                                          0.003874  
##                             rcs(journal.cited.halflife, 3)journal.cited.halflife'  
##                                                                          0.007259  
##                          rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                          0.938648  
##                         rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                         -0.519853  
##                                                        factor(pubmed.is.cancer).L  
##                                                                         -0.061754  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.053626  
##                                                        factor(pubmed.is.plants).L  
##                                                                          0.170622  
##                                         factor(pubmed.is.core.clinical.journal).L  
##                                                                         -0.077720  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.119718  
## 
```



```r

print(calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L"))   
```



```
##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.13  1.09   1.17 0
```



```r

```




##### Now by year



```r

do_analysis = function(mydat) {
  myfit = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
  rcs(pubmed.date.in.pubmed, 3) +
  #rcs(first.author.num.prev.pubs.tr, 3) +           
  rcs(first.author.num.prev.pmc.cites.tr, 3) +     
  #rcs(first.author.year.first.pub.ago.tr, 3) +     
  #rcs(last.author.num.prev.pubs.tr, 3) +           
  rcs(last.author.num.prev.pmc.cites.tr, 3) +      
  #rcs(last.author.year.first.pub.ago.tr, 3) +
  #country.usa +              
  pubmed.is.open.access +              
  rcs(institution.mean.norm.citation.score, 3) +
  rcs(journal.num.articles.2008.tr, 3) +           
  #rcs(journal.cited.halflife, 3) +                 
  rcs(journal.impact.factor.tr, 3) +               
  factor(pubmed.is.cancer) +
  factor(pubmed.is.animals) +
  #factor(pubmed.is.plants) +
  #factor(pubmed.is.core.clinical.journal) +
  factor(dataset.in.geo.or.ae)
             , mydat)

  gfm_table(anova(myfit))

  myfit

  calcCI.exp(myfit, "factor(dataset.in.geo.or.ae).L")
}

estimates_by_year = data.frame()
for (year in seq(2001, 2009)) {
  dat.subset.year = subset(dfCitationsAttributes, pubmed.year.published==year)
  results = do_analysis(dat.subset.year)
  print(results)
  estimates_by_year = rbind(estimates_by_year, cbind(year=year, results))
}
```



```
## |                                              | Df    | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|-------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00  | 10.07  | 5.03    | 9.18    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00  | 0.49   | 0.24    | 0.44    | 0.64   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00  | 2.52   | 1.26    | 2.30    | 0.11   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00  | 14.09  | 7.04    | 12.84   | 0.00   |
## | pubmed.is.open.access                        | 1.00  | 0.02   | 0.02    | 0.03    | 0.86   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00  | 5.78   | 2.89    | 5.27    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00  | 0.96   | 0.48    | 0.87    | 0.42   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00  | 3.99   | 1.99    | 3.63    | 0.03   |
## | factor(pubmed.is.cancer)                     | 1.00  | 0.07   | 0.07    | 0.12    | 0.73   |
## | factor(pubmed.is.animals)                    | 1.00  | 0.77   | 0.77    | 1.41    | 0.24   |
## | factor(dataset.in.geo.or.ae)                 | 1.00  | 0.85   | 0.85    | 1.54    | 0.22   |
## | Residuals                                    | 82.00 | 44.98  | 0.55    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.37  0.83   2.25 0.218
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 7.65   | 3.83    | 5.71    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.87   | 1.43    | 2.14    | 0.12   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 1.88   | 0.94    | 1.40    | 0.25   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.88  | 6.94    | 10.35   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.54   | 2.54    | 3.79    | 0.05   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.35   | 2.67    | 3.99    | 0.02   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 3.21   | 1.60    | 2.39    | 0.09   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 32.42  | 16.21   | 24.19   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.38   | 0.38    | 0.57    | 0.45   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.14   | 0.14    | 0.21    | 0.65   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.75   | 0.75    | 1.11    | 0.29   |
## | Residuals                                    | 231.00 | 154.78 | 0.67    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.15  0.89   1.49 0.292
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 11.90  | 5.95    | 10.92   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 11.65  | 5.83    | 10.70   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 9.87   | 4.93    | 9.06    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.57  | 6.78    | 12.46   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.11   | 0.11    | 0.20    | 0.65   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.46   | 1.23    | 2.26    | 0.11   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 4.79   | 2.39    | 4.39    | 0.01   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 26.20  | 13.10   | 24.05   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.57   | 1.57    | 2.88    | 0.09   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.34   | 0.34    | 0.62    | 0.43   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 2.22   | 2.22    | 4.08    | 0.04   |
## | Residuals                                    | 355.00 | 193.32 | 0.54    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.19  1.01   1.41 0.044
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.77  | 12.39   | 20.71   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.73   | 2.87    | 4.79    | 0.01   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 22.94  | 11.47   | 19.18   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 23.95  | 11.97   | 20.03   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 6.66   | 6.66    | 11.14   | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.72   | 1.36    | 2.28    | 0.10   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 9.60   | 4.80    | 8.03    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 43.34  | 21.67   | 36.24   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 4.04   | 4.04    | 6.75    | 0.01   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.14   | 0.14    | 0.23    | 0.63   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 9.82   | 9.82    | 16.43   | 0.00   |
## | Residuals                                    | 492.00 | 294.18 | 0.60    |         |        |
##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.29  1.14   1.45 0
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 25.81  | 12.90   | 27.77   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 0.60   | 0.30    | 0.65    | 0.52   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 23.89  | 11.94   | 25.70   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 12.34  | 6.17    | 13.28   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.04   | 0.04    | 0.10    | 0.76   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 7.80   | 3.90    | 8.39    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 15.58  | 7.79    | 16.76   | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 51.76  | 25.88   | 55.70   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 11.58  | 11.58   | 24.93   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.03   | 2.03    | 4.36    | 0.04   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 13.58  | 13.58   | 29.22   | 0.00   |
## | Residuals                                    | 568.00 | 263.90 | 0.46    |         |        |
##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.33   1.2   1.47 0
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 35.85  | 17.92   | 33.66   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.45   | 1.23    | 2.30    | 0.10   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 19.51  | 9.75    | 18.32   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 17.65  | 8.83    | 16.58   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.23   | 0.23    | 0.43    | 0.51   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.80   | 1.40    | 2.63    | 0.07   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 8.04   | 4.02    | 7.55    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 64.29  | 32.14   | 60.37   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 9.53   | 9.53    | 17.90   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00   | 7.44   | 7.44    | 13.97   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 4.96   | 4.96    | 9.31    | 0.00   |
## | Residuals                                    | 562.00 | 299.25 | 0.53    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.16  1.06   1.28 0.002
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.19  | 12.10   | 23.96   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.35   | 2.67    | 5.30    | 0.01   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 11.75  | 5.88    | 11.64   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 11.00  | 5.50    | 10.90   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.01   | 0.01    | 0.01    | 0.91   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.76   | 1.38    | 2.74    | 0.07   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 5.52   | 2.76    | 5.47    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 56.28  | 28.14   | 55.76   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.27   | 1.27    | 2.51    | 0.11   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.85   | 0.85    | 1.69    | 0.19   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 2.03   | 2.03    | 4.02    | 0.05   |
## | Residuals                                    | 712.00 | 359.35 | 0.50    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.08     1   1.17 0.045
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 40.91  | 20.46   | 36.33   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.79    | 13.83   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 6.76   | 3.38    | 6.00    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 16.74  | 8.37    | 14.87   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.13   | 2.13    | 3.79    | 0.05   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.44   | 2.72    | 4.83    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 10.35  | 5.18    | 9.20    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 59.59  | 29.80   | 52.92   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 3.16   | 3.16    | 5.61    | 0.02   |
## | factor(pubmed.is.animals)                    | 1.00   | 6.81   | 6.81    | 12.10   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 1.83   | 1.83    | 3.25    | 0.07   |
## | Residuals                                    | 667.00 | 375.50 | 0.56    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.08  0.99   1.18 0.072
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 43.96  | 21.98   | 43.45   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.78    | 15.39   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 7.31   | 3.65    | 7.22    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 10.94  | 5.47    | 10.82   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.57   | 0.57    | 1.12    | 0.29   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 8.23   | 4.11    | 8.13    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 7.82   | 3.91    | 7.73    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 58.49  | 29.24   | 57.81   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.09   | 0.09    | 0.19    | 0.67   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.48   | 2.48    | 4.90    | 0.03   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.02   | 0.02    | 0.04    | 0.84   |
## | Residuals                                    | 533.00 | 269.64 | 0.51    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.01  0.92   1.11 0.838
```



```r

estimates_by_year
```



```
##           year                          param  est ciLow ciHigh     p
## Estimate  2001 factor(dataset.in.geo.or.ae).L 1.37  0.83   2.25 0.218
## Estimate1 2002 factor(dataset.in.geo.or.ae).L 1.15  0.89   1.49 0.292
## Estimate2 2003 factor(dataset.in.geo.or.ae).L 1.19  1.01   1.41 0.044
## Estimate3 2004 factor(dataset.in.geo.or.ae).L 1.29  1.14   1.45 0.000
## Estimate4 2005 factor(dataset.in.geo.or.ae).L 1.33  1.20   1.47 0.000
## Estimate5 2006 factor(dataset.in.geo.or.ae).L 1.16  1.06   1.28 0.002
## Estimate6 2007 factor(dataset.in.geo.or.ae).L 1.08  1.00   1.17 0.045
## Estimate7 2008 factor(dataset.in.geo.or.ae).L 1.08  0.99   1.18 0.072
## Estimate8 2009 factor(dataset.in.geo.or.ae).L 1.01  0.92   1.11 0.838
```



```r

ggplot(estimates_by_year, aes(x=year, y=est)) + geom_line() + 
  geom_errorbar(width=.1, aes(ymin=ciLow, ymax=ciHigh)) +
  scale_x_continuous(name='year of publication') +
  scale_y_continuous(limits=c(0, 2.5), name='citations proportion for \n(papers with available data)/(those without)')
```

<img src="http://i.imgur.com/Y4TSC.png" class="plot" />



##### Now by year



```r

# Using analysis method of splines, consistent with current study

  dat.subset.previous.study = subset(dfCitationsAttributes, (pubmed.year.published<2003) & (pubmed.is.cancer==1) & (pubmed.is.humans==1))

  dim(dat.subset.previous.study)
```



```
## [1] 209  86
```



```r

  myfitprev = lm(nCitedBy.log ~ 
    rcs(pubmed.date.in.pubmed, 3) +
    country.usa +              
    rcs(journal.impact.factor.tr, 3) +               
    factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)

  gfm_table(anova(myfitprev))
```



```
## |                                  | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)    | 2.00   | 0.86   | 0.43    | 0.56    | 0.57   |
## | country.usa                      | 1.00   | 0.14   | 0.14    | 0.18    | 0.67   |
## | rcs(journal.impact.factor.tr, 3) | 2.00   | 49.59  | 24.80   | 32.18   | 0.00   |
## | factor(dataset.in.geo.or.ae)     | 1.00   | 1.74   | 1.74    | 2.26    | 0.13   |
## | Residuals                        | 196.00 | 151.03 | 0.77    |         |        |
```



```r

  myfitprev
```



```
## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(pubmed.date.in.pubmed, 3) + country.usa + 
##     rcs(journal.impact.factor.tr, 3) + factor(dataset.in.geo.or.ae), 
##     data = dat.subset.previous.study)
## 
## Coefficients:
##                                               (Intercept)  
##                                                  42.12347  
##        rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                  -0.00113  
##       rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                   0.00141  
##                                             country.usa.L  
##                                                  -0.00261  
##  rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                   0.98676  
## rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                  -0.13818  
##                            factor(dataset.in.geo.or.ae).L  
##                                                   0.27128  
## 
```



```r

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")
```



```
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.31  0.92   1.87 0.134
```



```r

# Using analysis method of linear fit, consistent with previous study

  myfitprev = lm(nCitedBy.log ~ 
    pubmed.date.in.pubmed +
    country.usa +              
    journal.impact.factor.tr +               
    factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)

  gfm_table(anova(myfitprev))
```



```
## |                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |------------------------------|--------|--------|---------|---------|--------|
## | pubmed.date.in.pubmed        | 1.00   | 0.42   | 0.42    | 0.55    | 0.46   |
## | country.usa                  | 1.00   | 0.12   | 0.12    | 0.16    | 0.69   |
## | journal.impact.factor.tr     | 1.00   | 48.17  | 48.17   | 62.53   | 0.00   |
## | factor(dataset.in.geo.or.ae) | 1.00   | 2.09   | 2.09    | 2.72    | 0.10   |
## | Residuals                    | 198.00 | 152.55 | 0.77    |         |        |
```



```r

  myfitprev
```



```
## 
## Call:
## lm(formula = nCitedBy.log ~ pubmed.date.in.pubmed + country.usa + 
##     journal.impact.factor.tr + factor(dataset.in.geo.or.ae), 
##     data = dat.subset.previous.study)
## 
## Coefficients:
##                    (Intercept)           pubmed.date.in.pubmed  
##                      -7.13e-01                        7.64e-05  
##                  country.usa.L        journal.impact.factor.tr  
##                       1.23e-05                        7.93e-01  
## factor(dataset.in.geo.or.ae).L  
##                       2.95e-01  
## 
```



```r

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")
```



```
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.34  0.95   1.91 0.101
```





### Subset, manual classification of data availability 

#### Description

#### Univariate



### Independent analysis, reuse frequency

#### Description

#### Univariate

