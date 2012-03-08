

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!

To run this I start R, set the working directory to match where this file is, then run the following in R:

  > library(knitr)  
  > knit("stats_knit_.md")  # has underscores around the knit but md displays badly





# Data availability citation boost consistent with observed rates of data reuse


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there evidence any increase in citations is related to data reuse?

## Abstract

### Background
Attribution upon reuse of scientific data is important to reward data creators and document the provenance of research findings.  In many fields, data attribution commonly takes the form of citation to the paper that described the primary data collection.  Several prior analyses have found that studies with publicly available datasets do indeed receive a higher number of citations than similar studies without available data, suggesting citations in the context of data reuse.  In this analysis we look at citation rates while controlling for many known citation predictors, and investigate whether the estimated citation boost is consistent with evidence of data reuse.

### Methods and Results
In a multivariate linear regression on 10589 studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 12% (95% confidence interval: 8% to 16%) more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 6% (95% CI: 3% to 11%) of citations to those studies were in the context of data reuse attribution.

### Discussion
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.


## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis[1]. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection.” [Piwowar, Sharing] 

When research data is made publicly available, is there a demonstrable benefit to scientific progress and the study investigators?  

Citations are often used as a proxy for the scientific contribution of a paper.  Citations are also used in research funding and promotion decisions; Boosting citation rate is thus is a potentially important motivator for publication authors.

Previous studies have explored the relationship between the citation rate of a publication and whether its data was made publicly available.  The first study we know about..... In 2007, co-authors and I published a report that found … .  Others have also found correlations between citation rate and data availability.

Here, we report an analysis based on a large cohort of relatively homogenious studies.  The size our cohort has facilitated controlling for many more variables than previous studies, allowing us to make further progress in isolating the citation rate relationship with data archiving itself.

Clinical microarray data provides a useful environment for the investigation: despite being valuable for reuse valuable for reuse [butte] and well-supported by data sharing standards and infrastructure [], fewer than half of the studies that collect this data make it publicly available [Ochsner, Piwowar]

## Methods

### Identification of relevant studies

### Assessment of data availability

### Study attributes

### Citation data

### Statistical methods

### Data and script availability

### Efficient article writing through the power of Open Access
Rewriting text for the sake of variation is a poor use of resources.  Quoted text in this paper comes verbatim from an article that licenced under CC-BY, eliminating concerns about fair use.

## Results

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

Get the data:





Load the data and get going:



```r

# Load

setwd("~/Documents/Projects/citation benefit in 11k study/citation11k/analysis")
load("dfCitations.RData")
load("dfAnnotations.RData")
load("dfCitationsAnnotated.RData")
load("dfAttributes.RData")
load("dfCitationsAttributes.RData")
```





# How big is the dataset?



```r
dim(dfCitationsAttributes)
```



```
## [1] 10694   197
```





# Citations patterns











```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     1.0     7.0    16.0    32.2    35.0  2640.0   173.0 
```



```
## [1] 10694   197
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     1.0     7.0    16.0    32.2    35.0  2640.0   173.0 
```




### Raw histogram of citations


```r
qplot(nCitedBy, data = dfCitationsAttributes)
```



```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

<img src="http://i.imgur.com/BO9lJ.png" class="plot" />



### Histogram of citations, log scale


```r
qplot(nCitedBy, data = dfCitationsAttributes, 
    log = "y")
```



```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```



```
## Warning message: Stacking not well defined when ymin != 0
```

<img src="http://i.imgur.com/66ASO.png" class="plot" />



## Other variables that correlate with citations
### Year of publication


```r
with(dfCitationsAttributes, table(pubmed_year_published))
```



```
## pubmed_year_published
## 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 
##   35  213  491  818 1126 1332 1315 1746 1888 1626  104 
```



```r
with(dfCitationsAttributes, summary(log(1 + nCitedBy) ~ 
    pubmed_year_published))
```



```
## log(1 + nCitedBy)    N=10521, 173 Missing
## 
## +---------------------+-----------+-----+-----------------+
## |                     |           |N    |log(1 + nCitedBy)|
## +---------------------+-----------+-----+-----------------+
## |pubmed_year_published|[2000,2005)| 2674|3.709            |
## |                     |[2005,2007)| 2636|3.098            |
## |                     |[2007,2009)| 3577|2.546            |
## |                     |[2009,2010]| 1634|1.912            |
## +---------------------+-----------+-----+-----------------+
## |Overall              |           |10521|2.881            |
## +---------------------+-----------+-----+-----------------+
```



```r
qplot(Year, nCitedBy, data = dfCitationsAttributes, 
    geom = "boxplot", log = "y") + geom_jitter(color = "blue", 
    alpha = 0.1)
```



```
## Warning message: Removed 173 rows containing missing values (stat_boxplot).
```



```
## Warning message: Removed 173 rows containing missing values (geom_point).
```

<img src="http://i.imgur.com/HvzVk.png" class="plot" />



### Number of authors


```r
qplot(pubmed_number_authors, data = dfCitationsAttributes, 
    log = "y")
```



```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```



```
## Warning message: Stacking not well defined when ymin != 0
```

<img src="http://i.imgur.com/pSCwR.png" class="plot" />


```r
qplot(log(pubmed_number_authors), log(1 + nCitedBy), 
    data = dfCitationsAttributes) + geom_smooth()
```



```
## Warning message: Removed 173 rows containing missing values (stat_smooth).
```



```
## Warning message: Removed 173 rows containing missing values (geom_point).
```

<img src="http://i.imgur.com/EYseT.png" class="plot" />




Some more looks



```r

# A quick summary of the data
print("Number of papers")
```



```
## [1] "Number of papers"
```



```r
print("Data not available, Data available")
```



```
## [1] "Data not available, Data available"
```



```r
tapply(dat$nCitedBy >= 0, dat$dataset.in.geo.or.ae.int, 
    sum)
```



```
##    0    1 
## 7597 2582 
```



```r

print("Number of citations")
```



```
## [1] "Number of citations"
```



```r
print("Data not available, Data available")
```



```
## [1] "Data not available, Data available"
```



```r
tapply(dat$nCitedBy, dat$dataset.in.geo.or.ae.int, 
    sum)
```



```
##      0      1 
## 226673  78071 
```



```r

table(dat$dataset.in.geo.or.ae.int)
```



```
## 
##    0    1 
## 7597 2582 
```



```r
boxplot(nCitedBy ~ dataset.in.geo.or.ae.int, data = dat, 
    boxwex = 0.5, names = c("Data Not Shared", "Data Shared"), 
    ylab = "Number of Citations", outline = T, notch = F, 
    log = "y")
```

<img src="http://i.imgur.com/itfJ4.png" class="plot" />


```r

with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, 
    mean))
```



```
##     0     1 
## 29.84 30.24 
```



```r
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, 
    median))
```



```
##  0  1 
## 16 16 
```



```r
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, 
    summary))
```



```
## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1.0     7.0    16.0    29.8    34.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1.0     8.0    16.0    30.2    34.0   852.0 
## 
```



```r


library(polycor)
myhetcorr = hetcor.modified(dat.subset, use = "pairwise.complete.obs", 
    std.err = FALSE, pd = FALSE)
```



```
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
```



```
## Warning message: 1 row with zero marginal removed
```



```
## Warning message: the table has fewer than 2 rows
```



```
## [1] 8
## [1] 9
## [1] 10
## [1] 11
## [1] 12
## [1] 13
```



```
## Warning message: 1 row with zero marginal removed
```



```
## Warning message: the table has fewer than 2 rows
```



```
## [1] 14
## [1] 15
## [1] 16
## [1] 17
## [1] 18
## [1] 19
## [1] 20
## [1] 21
## [1] 22
## [1] 23
## [1] 24
## [1] 25
## [1] 26
## [1] 27
## [1] 28
## [1] 29
## [1] 30
## [1] 31
## [1] 32
## [1] 33
## [1] 34
## [1] 35
## [1] 36
## [1] 37
## [1] 38
## [1] 39
## [1] 40
## [1] 41
## [1] 42
## [1] 43
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 44
## [1] 45
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 46
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 47
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 48
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 49
## [1] 50
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 51
## [1] 52
## [1] 53
## [1] 54
## [1] 55
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 56
## [1] 57
```



```
## Warning message: inadmissible correlation set to 1
```



```
## [1] 58
## [1] 59
## [1] 60
## [1] 61
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 62
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 63
## [1] 64
## [1] 65
## [1] 66
## [1] 67
## [1] 68
## [1] 69
## [1] 70
## [1] 71
```



```
## Warning message: inadmissible correlation set to 1
```



```
## [1] 72
```



```
## Warning message: y has fewer than 2 levels with data
```



```
## [1] 73
```



```
## Warning message: y has fewer than 2 levels with data
```



```
## [1] 74
## [1] 75
## [1] 76
## [1] 77
## [1] 78
## [1] 79
```



```
## Warning message: inadmissible correlation set to 1
```



```
## [1] 80
## [1] 81
## [1] 82
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: inadmissible correlation set to 1
```



```
## [1] 83
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## Warning message: NaNs produced
```



```
## Warning message: NA/Inf replaced by maximum positive value
```



```
## [1] 84
```



```
## Warning message: inadmissible correlation set to 1
```



```
## Warning message: inadmissible correlation set to 1
```



```
## [1] 85
## [1] 86
```



```r
mycor = myhetcorr$correlations
colnames(mycor) = colnames(myhetcorr$correlations)
rownames(mycor) = rownames(myhetcorr$correlations)

sort(mycor[, "nCitedBy.log"])
```



```
##                         pubmed.date.in.pubmed 
##                                    -5.761e-01 
##                         pubmed.year.published 
##                                    -5.674e-01 
##                                          pmid 
##                                    -5.641e-01 
##                         pubmed.is.open.access 
##                                    -3.038e-01 
##                                 country.korea 
##                                    -2.444e-01 
##                                 country.china 
##                                    -1.890e-01 
##                             pubmed.is.animals 
##                                    -1.118e-01 
##                                 country.japan 
##                                    -1.016e-01 
##                  last.author.gender.not.found 
##                                    -1.014e-01 
##                           first.author.female 
##                                    -8.093e-02 
##                            last.author.female 
##                                    -7.820e-02 
##                      institution.is.higher.ed 
##                                    -7.343e-02 
##                              institution.rank 
##                                    -5.727e-02 
##                                country.canada 
##                                    -5.688e-02 
##                 first.author.gender.not.found 
##                                    -4.152e-02 
##               pubmed.is.funded.nih.intramural 
##                                    -3.772e-02 
##                             country.australia 
##                                    -3.487e-02 
##                          nih.last.year.ago.tr 
##                                    -3.048e-02 
##                                 has.K.funding 
##                                    -2.568e-02 
##                             pubmed.is.viruses 
##                                    -2.162e-02 
##                               country.germany 
##                                    -1.948e-02 
##                           pubmed.is.geo.reuse 
##                                    -1.780e-02 
##                                dataset.in.geo 
##                                    -1.377e-02 
##                                pubmed.is.mice 
##                                    -1.090e-02 
##                            pubmed.is.bacteria 
##                                    -1.042e-02 
##                      pubmed.is.cultured.cells 
##                                    -1.020e-02 
##                               pubmed.is.fungi 
##                                    -8.413e-03 
##                                country.france 
##                                    -6.985e-03 
## first.author.num.prev.microarray.creations.tr 
##                                    -5.264e-03 
##                          institution.is.govnt 
##                                    -3.538e-03 
##                        institution.is.medical 
##                                    -5.236e-04 
##                  pubmed.is.funded.non.us.govt 
##                                     8.577e-05 
##                      dataset.in.geo.or.ae.int 
##                                     9.013e-03 
##                          dataset.in.geo.or.ae 
##                                     1.225e-02 
##  last.author.num.prev.microarray.creations.tr 
##                                     1.228e-02 
##                        nih.sum.avg.dollars.tr 
##                                     1.725e-02 
##                        nih.sum.sum.dollars.tr 
##                                     2.016e-02 
##                         num.grants.via.nih.tr 
##                                     2.030e-02 
##                                 has.U.funding 
##                                     3.025e-02 
##                                    country.uk 
##                                     3.307e-02 
##                           pubmed.is.diagnosis 
##                                     3.640e-02 
##                       nih.cumulative.years.tr 
##                                     3.657e-02 
##                       pubmed.is.effectiveness 
##                                     3.961e-02 
##       institution.international.collaboration 
##                                     5.207e-02 
##                   pubmed.is.comparative.study 
##                                     5.427e-02 
##                              pubmed.is.cancer 
##                                     5.740e-02 
##                        nih.max.max.dollars.tr 
##                                     6.076e-02 
##                                 has.P.funding 
##                                     6.485e-02 
##                 first.author.num.prev.pubs.tr 
##                                     6.786e-02 
##                                 has.R.funding 
##                                     7.466e-02 
##                          pubmed.is.funded.nih 
##                                     7.709e-02 
##                              pubmed.is.plants 
##                                     8.250e-02 
##                         max.grant.duration.tr 
##                                     8.376e-02 
##                              pubmed.is.humans 
##                                     8.473e-02 
##                           pubmed.is.prognosis 
##                                     8.791e-02 
##                                 has.T.funding 
##                                     9.156e-02 
##                               has.R01.funding 
##                                     9.215e-02 
##                          num.grant.numbers.tr 
##                                     9.291e-02 
##                institution.research.output.tr 
##                                     1.002e-01 
##                        pubmed.is.shared.other 
##                                     1.061e-01 
##                        journal.cited.halflife 
##                                     1.280e-01 
##                               institution.nci 
##                                     1.304e-01 
##                         nih.first.year.ago.tr 
##                                     1.359e-01 
##                  last.author.num.prev.pubs.tr 
##                                     1.363e-01 
##               pubmed.is.core.clinical.journal 
##                                     1.621e-01 
##                                num.authors.tr 
##                                     1.653e-01 
##           institution.mean.norm.impact.factor 
##                                     1.701e-01 
##                                   country.usa 
##                                     1.725e-01 
##            first.author.year.first.pub.ago.tr 
##                                     2.091e-01 
##                           institution.harvard 
##                                     2.131e-01 
##                          institution.stanford 
##                                     2.132e-01 
##             last.author.year.first.pub.ago.tr 
##                                     2.167e-01 
##          journal.microarray.creating.count.tr 
##                                     2.195e-01 
##          institution.mean.norm.citation.score 
##                                     2.277e-01 
##                  journal.num.articles.2008.tr 
##                                     2.350e-01 
##            first.author.num.prev.pmc.cites.tr 
##                                     2.389e-01 
##             last.author.num.prev.pmc.cites.tr 
##                                     2.851e-01 
##                   journal.immediacy.index.log 
##                                     4.339e-01 
##                 journal.5yr.impact.factor.log 
##                                     4.472e-01 
##                      journal.impact.factor.tr 
##                                     4.497e-01 
##                     journal.impact.factor.log 
##                                     4.638e-01 
##                                  years.ago.tr 
##                                     5.711e-01 
##            pubmed.num.cites.from.pmc.per.year 
##                                     5.954e-01 
##                                      nCitedBy 
##                                     6.073e-01 
##                  pubmed.num.cites.from.pmc.tr 
##                                     7.745e-01 
##                                  nCitedBy.log 
##                                     1.000e+00 
```



```r

univarate.citation.predictors = which(abs(mycor[, 
    "nCitedBy.log"]) > 0.1)
univarate.citation.predictors
```



```
##                                 pmid                pubmed.year.published 
##                                    1                                    2 
##                         years.ago.tr                pubmed.date.in.pubmed 
##                                    3                                    4 
##                       num.authors.tr   first.author.num.prev.pmc.cites.tr 
##                                    5                                    9 
##   first.author.year.first.pub.ago.tr         last.author.gender.not.found 
##                                   10                                   13 
##         last.author.num.prev.pubs.tr    last.author.num.prev.pmc.cites.tr 
##                                   14                                   15 
##    last.author.year.first.pub.ago.tr                    pubmed.is.animals 
##                                   16                                   20 
##                pubmed.is.open.access      pubmed.is.core.clinical.journal 
##                                   28                                   32 
##               pubmed.is.shared.other         pubmed.num.cites.from.pmc.tr 
##                                   37                                   39 
##   pubmed.num.cites.from.pmc.per.year                        country.china 
##                                   40                                   45 
##                        country.japan                        country.korea 
##                                   48                                   49 
##                          country.usa       institution.research.output.tr 
##                                   51                                   56 
##  institution.mean.norm.impact.factor institution.mean.norm.citation.score 
##                                   58                                   59 
##                  institution.harvard                      institution.nci 
##                                   60                                   61 
##                 institution.stanford             journal.impact.factor.tr 
##                                   62                                   63 
##            journal.impact.factor.log        journal.5yr.impact.factor.log 
##                                   64                                   65 
##          journal.immediacy.index.log         journal.num.articles.2008.tr 
##                                   66                                   67 
##               journal.cited.halflife journal.microarray.creating.count.tr 
##                                   68                                   69 
##                nih.first.year.ago.tr                             nCitedBy 
##                                   72                                   85 
##                         nCitedBy.log 
##                                   86 
```



```r
length(univarate.citation.predictors)
```



```
## [1] 37
```



```r
topcor = mycor[univarate.citation.predictors, 
    univarate.citation.predictors]
heatmap.2(topcor, col = bluered(16), cexRow = 0.5, 
    cexCol = 0.8, symm = TRUE, dend = "row", trace = "none", 
    main = "Thesis Data", margins = c(15, 15), key = FALSE, 
    keysize = 0.1)
```

<img src="http://i.imgur.com/oflKk.png" class="plot" />


```
## Error: figure margins too large
```



```r

dat.uni = dat.subset[, univarate.citation.predictors]

# From ?pairs
panel.cor <- function(x, y, digits = 2, prefix = "", 
    cex.cor, ...) {
    usr <- par("usr")
    on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y, use = "pairwise.complete.obs"))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste(prefix, txt, sep = "")
    if (missing(cex.cor)) 
        cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor)
}

# pairs(dat.uni[1:1000,20:34],
#   lower.panel=panel.smooth, upper.panel=panel.cor)

#mycor.uni = mycor[univarate.citation.predictors,
#   univarate.citation.predictors]
#heatmap.2(mycor.uni, col=bluered(16), cexRow=0.5,
#   cexCol = .8, symm = TRUE, dend = 'row', trace =
#   'none', main = 'Thesis Data', margins=c(15,15),
#   key=FALSE, keysize=0.1)



library(gplots)
heatmap.2(mycor, col = bluered(16), cexRow = 0.5, 
    cexCol = 0.8, symm = TRUE, dend = "row", trace = "none", 
    main = "Thesis Data", margins = c(15, 15), key = FALSE, 
    keysize = 0.1)
```

<img src="http://i.imgur.com/XtBk5.png" class="plot" />


```
## Error: figure margins too large
```



```r

#heatmap.3(mycor)
#heatmap.3(mycor, col=bluered(16), cexRow=0.5, cexCol =
#   .8, symm = TRUE, dend = 'row', trace = 'none', main
#   = 'Thesis Data', margins=c(15,15), key=FALSE,
#   keysize=0.1)
```





Some more looks





