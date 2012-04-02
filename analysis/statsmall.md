





# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on `Mon Apr  2 04:14:09 2012`

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("statsmall_knit_.md")

or, from the command line

    R -e "library(knitr); knit('statsmall_knit_.md')"
    pandoc -r markdown -w html statsmall.md > test.html
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
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published > 2001)
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published < 2010)
dim(dfCitationsAttributesRaw)
```



```
## [1] 10342   196
```




Get citations into the right format



```r
dfCitationsAttributesRaw$nCitedBy = as.numeric(dfCitationsAttributesRaw$Cited.by)
dfCitationsAttributesRaw[which(is.na(dfCitationsAttributesRaw$nCitedBy)),]$nCitedBy=0
dim(dfCitationsAttributesRaw)
```



```
## [1] 10342   197
```



```r
 
source("helpers.R")
source("preprocess_raw_data.R")
 
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
dim(dfCitationsAttributes)
```



```
## [1] 10342    86
```



```r
options(scipen=8)
```





The dataset has `1.0342 &times; 10<sup>4</sup>` rows and `86`  columns. 


## Results


### Analysis of 11k PLoS articles based on automated determination of data availability

#### Description of cohort

The PLoS study had `1.1603 &times; 10<sup>4</sup>` rows.  For this study we exclude extreme years.

The dataset has `1.0342 &times; 10<sup>4</sup>` rows and `86`  columns.  


Distribution by journal


```r
library(ascii)
a = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:10]
gfm_table(cbind(names(a), round(a, 2)))
```



```
## | Cancer Res               | 0.04 |
## | Proc Natl Acad Sci U S A | 0.04 |
## | J Biol Chem              | 0.03 |
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
library(ascii)
gfm_table(table(dfCitationsAttributesRaw$pubmed_year)/nrow(dfCitationsAttributesRaw))
```



```
## |   | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|
## | 1 | 0.05 | 0.08 | 0.11 | 0.13 | 0.13 | 0.17 | 0.18 | 0.16 |
```




Distribution by data availability


```r
library(ascii)
gfm_table(table(dfCitationsAttributesRaw$in_ae_or_geo)/nrow(dfCitationsAttributesRaw))
```



```
## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
```




Distribution by citation

The dataset has `1.0342 &times; 10<sup>4</sup>` rows and `86`  columns.  




```r
library(ggplot2)
qplot(nCitedBy.log, data=dfCitationsAttributes)
```

<img src="libraryggplot2.png" class="plot" />





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
## 7734 2608 
```



```r

# Number of citations vs Data availability
tapply(dat$nCitedBy,
       dat$dataset.in.geo.or.ae.int,
       sum)
```



```
##      0      1 
## 226673  78071 
```



```r

# Number of citations vs Data availability
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, summary))
```



```
## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    29.3    34.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    29.9    34.0   852.0 
## 
```



```r

table(dat$dataset.in.geo.or.ae.int)
```



```
## 
##    0    1 
## 7734 2608 
```



```r
boxplot(nCitedBy+1 ~ dataset.in.geo.or.ae.int,
        data = dat,
        boxwex = 0.5, 
        names=c("Data Not Shared", "Data Shared"), 
        ylab = "Number of Citations", outline=T, notch=F, log="y")
```

<img src="unnamed-chunk-10.png" class="plot" />


    


```r
library(polycor)
library(Hmisc)
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
## | nCitedBy                                      | 0.59  |
## | pubmed.num.cites.from.pmc.per.year            | 0.58  |
## | years.ago.tr                                  | 0.57  |
## | journal.impact.factor.log                     | 0.47  |
## | journal.impact.factor.tr                      | 0.45  |
## | journal.5yr.impact.factor.log                 | 0.45  |
## | journal.immediacy.index.log                   | 0.43  |
## | last.author.num.prev.pmc.cites.tr             | 0.29  |
## | journal.num.articles.2008.tr                  | 0.24  |
## | first.author.num.prev.pmc.cites.tr            | 0.24  |
## | last.author.year.first.pub.ago.tr             | 0.24  |
## | institution.mean.norm.citation.score          | 0.23  |
## | journal.microarray.creating.count.tr          | 0.22  |
## | institution.stanford                          | 0.22  |
## | first.author.year.first.pub.ago.tr            | 0.22  |
## | institution.harvard                           | 0.2   |
## | pubmed.is.core.clinical.journal               | 0.17  |
## | country.usa                                   | 0.17  |
## | institution.mean.norm.impact.factor           | 0.17  |
## | num.authors.tr                                | 0.17  |
## | last.author.num.prev.pubs.tr                  | 0.15  |
## | nih.first.year.ago.tr                         | 0.14  |
## | journal.cited.halflife                        | 0.13  |
## | institution.nci                               | 0.12  |
## | pubmed.is.shared.other                        | 0.11  |
## | has.T.funding                                 | 0.1   |
## | institution.research.output.tr                | 0.1   |
## | num.grant.numbers.tr                          | 0.1   |
## | has.R01.funding                               | 0.1   |
## | max.grant.duration.tr                         | 0.09  |
## | pubmed.is.prognosis                           | 0.08  |
## | pubmed.is.funded.nih                          | 0.08  |
## | pubmed.is.humans                              | 0.08  |
## | pubmed.is.plants                              | 0.08  |
## | has.R.funding                                 | 0.08  |
## | first.author.num.prev.pubs.tr                 | 0.07  |
## | has.P.funding                                 | 0.06  |
## | pubmed.is.comparative.study                   | 0.06  |
## | nih.max.max.dollars.tr                        | 0.06  |
## | pubmed.is.cancer                              | 0.06  |
## | institution.international.collaboration       | 0.06  |
## | nih.cumulative.years.tr                       | 0.04  |
## | country.uk                                    | 0.04  |
## | pubmed.is.effectiveness                       | 0.04  |
## | pubmed.is.diagnosis                           | 0.03  |
## | num.grants.via.nih.tr                         | 0.02  |
## | dataset.in.geo.or.ae                          | 0.02  |
## | nih.sum.sum.dollars.tr                        | 0.02  |
## | last.author.num.prev.microarray.creations.tr  | 0.02  |
## | nih.sum.avg.dollars.tr                        | 0.02  |
## | has.U.funding                                 | 0.02  |
## | dataset.in.geo.or.ae.int                      | 0.02  |
## | pubmed.is.funded.non.us.govt                  | 0.01  |
## | first.author.num.prev.microarray.creations.tr | 0     |
## | dataset.in.geo                                | 0     |
## | country.france                                | 0     |
## | pubmed.is.geo.reuse                           | 0     |
## | institution.is.medical                        | 0     |
## | pubmed.is.bacteria                            | 0     |
## | pubmed.is.fungi                               | -0.01 |
## | institution.is.govnt                          | -0.01 |
## | pubmed.is.cultured.cells                      | -0.01 |
## | pubmed.is.mice                                | -0.01 |
## | country.germany                               | -0.01 |
## | pubmed.is.funded.nih.intramural               | -0.02 |
## | country.australia                             | -0.02 |
## | pubmed.is.viruses                             | -0.02 |
## | has.K.funding                                 | -0.03 |
## | nih.last.year.ago.tr                          | -0.04 |
## | country.canada                                | -0.04 |
## | first.author.gender.not.found                 | -0.04 |
## | institution.rank                              | -0.06 |
## | institution.is.higher.ed                      | -0.07 |
## | last.author.female                            | -0.08 |
## | first.author.female                           | -0.09 |
## | last.author.gender.not.found                  | -0.1  |
## | country.japan                                 | -0.1  |
## | pubmed.is.animals                             | -0.11 |
## | country.china                                 | -0.19 |
## | country.korea                                 | -0.25 |
## | pubmed.is.open.access                         | -0.3  |
## | pmid                                          | -0.56 |
## | pubmed.year.published                         | -0.57 |
## | pubmed.date.in.pubmed                         | -0.58 |
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


library(gplots)

heatmap.2(topcor, col=bluered(16), cexRow=1, cexCol = 1, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)
```

<img src="univariatecorrnowarnings.png" class="plot" />


```
## Error: figure margins too large
```



```r

```



    


```r
 
library(ggplot2)

dat.subset = dfCitationsAttributes
with(dat.subset, tapply(nCitedBy, pubmed.year.published, median, na.rm=T))
```



```
## 2002 2003 2004 2005 2006 2007 2008 2009 
## 54.0 40.0 30.0 24.0 18.0 14.0  9.5  5.0 
```



```r


num_authors_breaks = c(1, 5, 10, 20, 40)
citation_breaks = c(1, 10, 40, 100, 400, 1000)

with(dat.subset, tapply(nCitedBy, cut(num.authors.tr, num_authors_breaks), median, na.rm=T))
```



```
##   (1,5]  (5,10] (10,20] (20,40] 
##      16      37      53      NA 
```



```r


qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots1.png" class="plot" />


```r

qplot(pubmed.date.in.pubmed, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots2.png" class="plot" />


```r


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots3.png" class="plot" />


```r

qplot(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots4.png" class="plot" />


```r

qplot(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots5.png" class="plot" />


```r

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots6.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots7.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)
qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots8.png" class="plot" />


```r

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)
```

<img src="univariateqplots9.png" class="plot" />


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
  return(list(param = param,
              est = round(exp(x), 2), 
        CI = c(round(exp(x - 1.96*stderr), 2),
                     round(exp(x + 1.96*stderr), 2)), 
          p = round(p, 3)))
}

calcCI.noexp= function(res, param) {
  coefs = summary(res)$coeff
  coeff = coefs[param,]
  x = coeff[1]
  stderr = coeff[2]
  p = coeff[4]
  return(list(param = param,
              est = round(x, 2), 
        CI = c(round(x - 1.96*stderr, 2),
                     round(x + 1.96*stderr, 2)), 
          p = round(p, 3)))
}

      
library(rms)

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
           , dat.subset)


library(ascii)
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
##     factor(dataset.in.geo.or.ae), data = dat.subset)
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
## $param
## [1] "factor(dataset.in.geo.or.ae).L"
## 
## $est
## Estimate 
##     1.13 
## 
## $CI
## Estimate Estimate 
##     1.09     1.17 
## 
## $p
## Pr(>|t|) 
##        0 
## 
```



```r

```




##### Now for just those published in 2007



```r

dat.subset.2007 = subset(dat.subset, pubmed.year.published==2007)

#### Looks like this is the analysis
fit.2007 = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
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
           , dat.subset.2007)


library(ascii)
gfm_table(anova(fit.2007))
```



```
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
```



```r

fit.2007
```



```
## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(num.authors.tr, 3) + rcs(pubmed.date.in.pubmed, 
##     3) + rcs(first.author.num.prev.pmc.cites.tr, 3) + rcs(last.author.num.prev.pmc.cites.tr, 
##     3) + pubmed.is.open.access + rcs(institution.mean.norm.citation.score, 
##     3) + rcs(journal.num.articles.2008.tr, 3) + rcs(journal.impact.factor.tr, 
##     3) + factor(pubmed.is.cancer) + factor(pubmed.is.animals) + 
##     factor(dataset.in.geo.or.ae), data = dat.subset.2007)
## 
## Coefficients:
##                                                                       (Intercept)  
##                                                                         23.712188  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.174961  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                         -0.000348  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.000630  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                          0.000122  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.010718  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                         -0.001795  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                         -0.003931  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                          0.007599  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.047440  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.164025  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.161652  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.007571  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.010150  
##                          rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                          0.974877  
##                         rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                         -0.693618  
##                                                        factor(pubmed.is.cancer).L  
##                                                                         -0.050286  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.047061  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.080848  
## 
```



```r

print(calcCI.exp(fit.2007, "factor(dataset.in.geo.or.ae).L"))   
```



```
## $param
## [1] "factor(dataset.in.geo.or.ae).L"
## 
## $est
## Estimate 
##     1.08 
## 
## $CI
## Estimate Estimate 
##     1.00     1.17 
## 
## $p
## Pr(>|t|) 
##    0.045 
## 
```



```r

```




##### Now for just those published in 2008



```r

dat.subset.2008 = subset(dat.subset, pubmed.year.published==2008)

#### Looks like this is the analysis
fit.2008 = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
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
           , dat.subset.2008)


library(ascii)
gfm_table(anova(fit.2008))
```



```
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
```



```r

fit.2008
```



```
## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(num.authors.tr, 3) + rcs(pubmed.date.in.pubmed, 
##     3) + rcs(first.author.num.prev.pmc.cites.tr, 3) + rcs(last.author.num.prev.pmc.cites.tr, 
##     3) + pubmed.is.open.access + rcs(institution.mean.norm.citation.score, 
##     3) + rcs(journal.num.articles.2008.tr, 3) + rcs(journal.impact.factor.tr, 
##     3) + factor(pubmed.is.cancer) + factor(pubmed.is.animals) + 
##     factor(dataset.in.geo.or.ae), data = dat.subset.2008)
## 
## Coefficients:
##                                                                       (Intercept)  
##                                                                         49.207435  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.207273  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                         -0.012847  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.001311  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                          0.000616  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.002312  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                          0.000572  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                          0.003834  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                         -0.001687  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.081573  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.177104  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.170950  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.008635  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.013777  
##                          rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                          1.082618  
##                         rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                         -0.877505  
##                                                        factor(pubmed.is.cancer).L  
##                                                                         -0.091871  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.143821  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.080480  
## 
```



```r

print(calcCI.exp(fit.2008, "factor(dataset.in.geo.or.ae).L"))   
```



```
## $param
## [1] "factor(dataset.in.geo.or.ae).L"
## 
## $est
## Estimate 
##     1.08 
## 
## $CI
## Estimate Estimate 
##     0.99     1.18 
## 
## $p
## Pr(>|t|) 
##    0.072 
## 
```



```r

```





### Subset, manual classification of data availability 

#### Description

#### Univariate



### Independent analysis, reuse frequency

#### Description

#### Univariate

