





# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on `Thu Apr 12 08:40:25 2012`

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line

    R -e "library(knitr); knit('stats_knit_.md')"
    pandoc -r markdown -w html -H header.html stats.md > stats.html
    file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/stats.html

to see just the R code in a separate .R file called stats_knit_.R, run 
    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"











# Data availability citation boost consistent with observed rates of data reuse


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there evidence any increase in citations is related to data reuse?

## Abstract

see the bottom of this document.

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis[1]. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection.” [Piwowar, Sharing] 

When research data is made publicly available, is there a demonstrable benefit to scientific progress and the study investigators?  

Citations are often used as a proxy for the scientific contribution of a paper.  Citations are also used in research funding and promotion decisions; Boosting citation rate is thus is a potentially important motivator for publication authors.

Previous studies have explored the relationship between the citation rate of a publication and whether its data was made publicly available.  The first study we know about..... In 2007, co-authors and I published a report that found … .  Others have also found correlations between citation rate and data availability.

Here, we report an analysis based on a large cohort of relatively homogenious studies.  The size our cohort has facilitated controlling for many more variables than previous studies, allowing us to make further progress in isolating the citation rate relationship with data archiving itself.

Clinical microarray data provides a useful environment for the investigation: despite being valuable for reuse valuable for reuse [butte] and well-supported by data sharing standards and infrastructure [], fewer than half of the studies that collect this data make it publicly available [Ochsner, Piwowar]

## Methods

Analysis run on `Thu Apr 12 08:40:30 2012`.

### Identification of relevant studies

### Assessment of data availability

### Study attributes

### Citation data

### Statistical methods

### Data and script availability

### Efficient article writing through the power of Open Access
Rewriting text for the sake of variation is a poor use of resources.  Quoted text in this paper comes verbatim from an article that licenced under CC-BY, eliminating concerns about fair use.


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


## Results

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
gfm_table(table(dfCitationsAttributesRaw$pubmed_year_published)/nrow(dfCitationsAttributesRaw))
```



```
## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
```



```r

library(ggplot2)
qplot(factor(pubmed_year_published), nCitedBy, data=dfCitationsAttributesRaw, geom="boxplot", log="y") + geom_jitter(color="blue", alpha=0.1) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/k3ySA.png" class="plot" />



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
qplot(nCitedBy.log, data=dfCitationsAttributes) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/3b6Yz.png" class="plot" />





```r
summary(dfCitationsAttributes$nCitedBy)
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.5    35.0  2640.0 
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

<img src="http://i.imgur.com/vr55s.png" class="plot" />


    


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


qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/Incq4.png" class="plot" />


```r

qplot(pubmed.date.in.pubmed, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/Wdlzd.png" class="plot" />


```r


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/TK1p9.png" class="plot" />


```r

qplot(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/Fdbyc.png" class="plot" />


```r

qplot(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/M2Z57.png" class="plot" />


```r

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/7OIuM.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/ZCDiy.png" class="plot" />


```r

x_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)
qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/zbF7B.png" class="plot" />


```r

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
```

<img src="http://i.imgur.com/1MkoQ.png" class="plot" />


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
## | rcs(num.authors.tr, 3)                       | 2.00    | 165.11  | 82.56   | 154.71  | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1833.50 | 916.75  | 1717.97 | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 6.08    | 3.04    | 5.70    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 186.36  | 93.18   | 174.61  | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 3.22    | 1.61    | 3.02    | 0.05   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 7.51    | 3.76    | 7.04    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 122.47  | 61.24   | 114.76  | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 3.29    | 1.64    | 3.08    | 0.05   |
## | country.usa                                  | 1.00    | 4.13    | 4.13    | 7.74    | 0.01   |
## | pubmed.is.open.access                        | 1.00    | 4.45    | 4.45    | 8.34    | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 10.68   | 5.34    | 10.00   | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00    | 41.15   | 20.57   | 38.55   | 0.00   |
## | rcs(journal.cited.halflife, 3)               | 2.00    | 4.25    | 2.13    | 3.98    | 0.02   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00    | 354.74  | 177.37  | 332.39  | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00    | 13.70   | 13.70   | 25.68   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00    | 13.38   | 13.38   | 25.08   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 15.19   | 15.19   | 28.46   | 0.00   |
## | factor(pubmed.is.core.clinical.journal)      | 1.00    | 4.48    | 4.48    | 8.39    | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 22.79   | 22.79   | 42.71   | 0.00   |
## | Residuals                                    | 4341.00 | 2316.46 | 0.53    |         |        |
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
##                                                                         21.615597  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.231614  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                         -0.004523  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.000572  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                         -0.000229  
##                rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr  
##                                                                         -0.025957  
##               rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr'  
##                                                                          0.002993  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.040807  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                         -0.036931  
##      rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr  
##                                                                         -0.064497  
##     rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr'  
##                                                                          0.027324  
##                  rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr  
##                                                                         -0.025988  
##                 rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr'  
##                                                                          0.024304  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                          0.008248  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                         -0.004732  
##        rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr  
##                                                                          0.033737  
##       rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr'  
##                                                                         -0.055195  
##                                                                     country.usa.L  
##                                                                          0.034038  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.071783  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.085859  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.070439  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.002509  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.005606  
##                              rcs(journal.cited.halflife, 3)journal.cited.halflife  
##                                                                          0.003019  
##                             rcs(journal.cited.halflife, 3)journal.cited.halflife'  
##                                                                          0.009822  
##                          rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                          0.923689  
##                         rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                         -0.489480  
##                                                        factor(pubmed.is.cancer).L  
##                                                                         -0.060094  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.056189  
##                                                        factor(pubmed.is.plants).L  
##                                                                          0.168610  
##                                         factor(pubmed.is.core.clinical.journal).L  
##                                                                         -0.082508  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.122251  
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

<img src="http://i.imgur.com/xQOIe.png" class="plot" />



##### Now by year



```r

# Using analysis method of splines, consistent with current study

  dat.subset.previous.study = subset(dfCitationsAttributes, (pubmed.year.published<2003) & (pubmed.is.cancer==1) & (pubmed.is.humans==1))

  dim(dat.subset.previous.study)
```



```
## [1] 308  86
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
## | rcs(pubmed.date.in.pubmed, 3)    | 2.00   | 5.33   | 2.67    | 3.27    | 0.04   |
## | country.usa                      | 1.00   | 0.00   | 0.00    | 0.01    | 0.94   |
## | rcs(journal.impact.factor.tr, 3) | 2.00   | 68.86  | 34.43   | 42.26   | 0.00   |
## | factor(dataset.in.geo.or.ae)     | 1.00   | 4.35   | 4.35    | 5.34    | 0.02   |
## | Residuals                        | 294.00 | 239.53 | 0.81    |         |        |
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
##                                                 26.970315  
##        rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                 -0.000699  
##       rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                  0.000211  
##                                             country.usa.L  
##                                                  0.015396  
##  rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                  0.908247  
## rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                 -0.080694  
##                            factor(dataset.in.geo.or.ae).L  
##                                                  0.383500  
## 
```



```r

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")
```



```
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.47  1.06   2.03 0.021
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
## | pubmed.date.in.pubmed        | 1.00   | 4.87   | 4.87    | 6.01    | 0.01   |
## | country.usa                  | 1.00   | 0.00   | 0.00    | 0.01    | 0.94   |
## | journal.impact.factor.tr     | 1.00   | 68.74  | 68.74   | 84.83   | 0.00   |
## | factor(dataset.in.geo.or.ae) | 1.00   | 4.60   | 4.60    | 5.67    | 0.02   |
## | Residuals                    | 296.00 | 239.87 | 0.81    |         |        |
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
##                      20.818070                       -0.000519  
##                  country.usa.L        journal.impact.factor.tr  
##                       0.016077                        0.800118  
## factor(dataset.in.geo.or.ae).L  
##                       0.392178  
## 
```



```r

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")
```



```
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.48  1.07   2.04 0.018
```





### Subset, manual classification of data availability 



```r

dfAnnotations = read.csv("data/Mendeley_annotated_250_of_11k.csv", header=TRUE, stringsAsFactors=F)

# Get subset that has been annotated
dfAnnotationsAnnotated = subset(dfAnnotations, TAG.annotated == "11k-subset-reviewed")

# Merge together annotations with citation information
dfCitationsAnnotated = merge(dfAnnotationsAnnotated, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAnnotated$isCreated = factor(dfCitationsAnnotated$TAG.created)
dfCitationsAnnotated$nCitedBy = as.numeric(dfCitationsAnnotated$Cited.by)

```







```r

# Dig in to looking at annotated subset

dim(dfCitationsAnnotated)
```



```
## [1] 230  62
```



```r
with(dfCitationsAnnotated, table(isCreated))
```



```
## isCreated
##     created-microarray-data created-microarray-data-not 
##                         210                          20 
```



```r
with(dfCitationsAnnotated, summary(nCitedBy~isCreated))
```



```
## nCitedBy    N=226, 4 Missing
## 
## +---------+---------------------------+---+--------+
## |         |                           |  N|nCitedBy|
## +---------+---------------------------+---+--------+
## |isCreated|    created-microarray-data|206|   31.86|
## |         |created-microarray-data-not| 20|   26.30|
## +---------+---------------------------+---+--------+
## |  Overall|                           |226|   31.37|
## +---------+---------------------------+---+--------+
```



```r
with(dfCitationsAnnotated, summary(log(1+nCitedBy)~isCreated))
```



```
## log(1 + nCitedBy)    N=226, 4 Missing
## 
## +---------+---------------------------+---+-----------------+
## |         |                           |  N|log(1 + nCitedBy)|
## +---------+---------------------------+---+-----------------+
## |isCreated|    created-microarray-data|206|            2.991|
## |         |created-microarray-data-not| 20|            2.632|
## +---------+---------------------------+---+-----------------+
## |  Overall|                           |226|            2.959|
## +---------+---------------------------+---+-----------------+
```



```r

library(ggplot2)

rm(.Random.seed) 
set.seed(42)
```



```
## Error: .Random.seed is not an integer vector but of type 'promise'
```



```r

# Do they look different
qplot(nCitedBy, data=dfCitationsAnnotated)
```

<img src="http://i.imgur.com/AGvQY.png" class="plot" />


```r
qplot(nCitedBy, data=dfCitationsAnnotated, color=isCreated, geom="density", binwidth=25)
```

<img src="http://i.imgur.com/r4F1y.png" class="plot" />


```r
qplot(isCreated, log(1+nCitedBy), data=dfCitationsAnnotated, geom="boxplot") + 
  geom_jitter(position=position_jitter(width=.1), color="blue")
```



```
## Error: .Random.seed is not an integer vector but of type 'promise'
```



```r
  
# Do they have different distributions
with(dfCitationsAnnotated, print(t.test(nCitedBy~isCreated)))
```



```
## 
## 	Welch Two Sample t-test
## 
## data:  nCitedBy by isCreated 
## t = 0.5747, df = 22.61, p-value = 0.5712
## alternative hypothesis: true difference in means is not equal to 0 
## 95 percent confidence interval:
##  -14.47  25.59 
## sample estimates:
##     mean in group created-microarray-data 
##                                     31.86 
## mean in group created-microarray-data-not 
##                                     26.30 
## 
```



```r
with(dfCitationsAnnotated, print(t.test(log(1+nCitedBy)~isCreated)))
```



```
## 
## 	Welch Two Sample t-test
## 
## data:  log(1 + nCitedBy) by isCreated 
## t = 1.331, df = 21.77, p-value = 0.1968
## alternative hypothesis: true difference in means is not equal to 0 
## 95 percent confidence interval:
##  -0.2003  0.9175 
## sample estimates:
##     mean in group created-microarray-data 
##                                     2.991 
## mean in group created-microarray-data-not 
##                                     2.632 
## 
```



```r
with(dfCitationsAnnotated, print(wilcox.test(nCitedBy~isCreated)))
```



```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  nCitedBy by isCreated 
## W = 2440, p-value = 0.1733
## alternative hypothesis: true location shift is not equal to 0 
## 
```



```r

# Now look if just created has the same pattern 

dat.annotated.merged = merge(dfCitationsAnnotated, dfCitationsAttributes, by="pmid")
dat.annotated.merged.created = subset(dat.annotated.merged, isCreated==levels(isCreated)[1])

library(rms)

fit.annotated.merged = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) + 
rcs(journal.impact.factor.tr, 3) +   
 dataset.in.geo.or.ae
           , dat.annotated.merged.created)
anova(fit.annotated.merged)
```



```
## Analysis of Variance Table
## 
## Response: nCitedBy.log
##                                   Df Sum Sq Mean Sq F value  Pr(>F)    
## rcs(num.authors.tr, 3)             2   11.1     5.6    9.62 0.00011 ***
## rcs(pubmed.date.in.pubmed, 3)      2   82.3    41.1   71.00 < 2e-16 ***
## rcs(journal.impact.factor.tr, 3)   2   13.6     6.8   11.76 1.6e-05 ***
## dataset.in.geo.or.ae               1    5.5     5.5    9.51 0.00235 ** 
## Residuals                        186  107.7     0.6                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
```



```r
print(calcCI.exp(fit.annotated.merged, "dataset.in.geo.or.ae.L")) 
```



```
##                           param  est ciLow ciHigh     p
## Estimate dataset.in.geo.or.ae.L 1.31   1.1   1.55 0.002
```



```r
dim(dat.annotated.merged.created)
```



```
## [1] 210 147
```




#### Description

#### Univariate



### Independent analysis, reuse frequency

#### Description

#### Univariate

## Discussion

### Limitations
- Underestimate of total reuse (not indexed, attributed in citations in SI, by accession number)
- Citations are not the main reason to make data available
- Other metrics of reuse.  practicioners, educational use
- These don’t just increase its impact by 10%, opens it up to whole new avenues of use.  It would be interesting to understand the impact these papers made in the papers that cited them; my guess would be that it is higher for the incremental citations for papers whose data is avail.

## References

### Other studies of citation benefit:

- Gleditsch, Nils Petter & Håvard Strand, 2003. 'Posting Your Data: Will You Be Scooped or Will You Be Famous?', International Studies Perspectives 4(1): 89–97.
- Henneken, Edwin A and Accomazzi, Alberto.  Linking to Data - Effect on Citation Rates in Astronomy. eprint arXiv:1111.3618 11/2011
- Ioannidis et al. Repeatability of published microarray gene expression analyses  Nature Genetics 41, 149 - 155 (2009) .  doi:10.1038/ng.295
- Pienta et al The Research Data Life Cycle and the Probability of Secondary Use in Re-Analysis 
The Research Data Life Cycle and the Probability of Secondary Use in Re-Analysis 
- Amy M. Pienta, George Alter, Jared Lyle.  The Enduring Value of Social Science Research: The Use and Reuse of Primary Research Data.  http://hdl.handle.net/2027.42/78307 
- Piwowar HA, Day RS, Fridsma DB (2007) Sharing Detailed Research Data Is Associated with Increased Citation Rate. PLoS ONE 2(3): e308. doi:10.1371/journal.pone.0000308

### Used in this analysis

- Piwowar HA (2011) Who shares? Who doesn’t? Factors associated with openly archiving raw research data. PLoS ONE 6(7): e18657. doi:10.1371/journal.pone.0018657
- Piwowar HA (2011) Data from: Who shares? Who doesn’t? Factors associated with openly archiving raw research data. Dryad Digital Repository. doi:10.5061/dryad.mf1sd
- Heather A Piwowar, Wendy W Chapman (2010)  Recall and bias of retrieving gene expression microarray datasets through PubMed identifiers  Journal of Biomedical Discovery and Collaboration.  J Biomed Discov Collab. 2010; 5: 7–20.
- Heather A. Piwowar; Jonathan D. Carlson; and Todd J. Vision. Beginning to Track 1000 Datasets from Public Repositories into the Published Literature.  ASIS&T 2011.

### Also relevant:

- (Data Usage Index):  Chavan, V. S., & Ingwersen, P. (2009). Towards a data publishing framework for primary biodiversity data: challenges and potentials for the biodiversity informatics community. BMC Bioinformatics, 10(Suppl 14), S2. Retrieved from http://www.biomedcentral.com/1471-2105/10/S14/S2
- Piwowar, H. A., Vision, T. J., & Whitlock, M. C. (2011). Data archiving is a good investment. Nature, 473(7347), 285-285. Nature Publishing Group, a division of Macmillan Publishers Limited. All Rights Reserved. Retrieved from http://dx.doi.org/10.1038/473285a
- Bollen J, Van de Sompel H, Hagberg A, Chute R (2009) A Principal Component Analysis of 39 Scientific Impact Measures. PLoS ONE 4(6): e6022. doi:10.1371/journal.pone.0006022
- Ochsner, S. A., Steffen, D. L., Stoeckert, C. J., & McKenna, N. J. (2008). Much room for improvement in deposition rates of expression microarray datasets. Nature Methods. Retrieved from http://dx.doi.org/10.1038/nmeth1208-991
- Definitely some things about move to citation of datasets themselves
- altmetrics on CV, away from impact factor

### Other studies of correlation with citations:

- Bioinformatics, 25, 3303-3309 (2009). "Predicting citation count of Bioinformatics papers within four years of publication. Ibanez, A., Larrañaga, P. and Bielza, C.  http://bioinformatics.oxfordjournals.org/content/25/24/3303.full

## Acknowledgements

- CISTI for Scopus access
- British Library
- Angus, Todd, Jonathan, Estephanie
- my funding, Jonathan + Estephanie’s funding


## Abstract

### Background
Attribution upon reuse of scientific data is important to reward data creators and document the provenance of research findings.  In many fields, data attribution commonly takes the form of citation to the paper that described the primary data collection.  Several prior analyses have found that studies with publicly available datasets do indeed receive a higher number of citations than similar studies without available data, suggesting citations in the context of data reuse.  In this analysis we look at citation rates while controlling for many known citation predictors, and investigate whether the estimated citation boost is consistent with evidence of data reuse.

### Methods and Results
In a multivariate linear regression on 10589 studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 12% (95% confidence interval: 8% to 16%) more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 6% (95% CI: 3% to 11%) of citations to those studies were in the context of data reuse attribution.

### Discussion
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.


