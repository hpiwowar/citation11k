





# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on `Sat Mar 31 01:09:34 2012`

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("statsmall_knit_.md")





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
dfCitationsAttributes = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")
```




The dataset has `10694` rows and `196`  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

*FIXME: The PLoS study had `11603` rows.  Where are the rest?  Missing Scopus data.  Go recollect.*

## Results

## Citations patterns




Preprocessing



```r
dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)
dfCitationsAttributes[which(is.na(dfCitationsAttributes$nCitedBy)),]$nCitedBy=0
```






```r
dat = preprocess.raw.data(dfCitationsAttributes)
```





Limit to just those published after 2001 and before 2010.



```r
dat = subset(dat, dat$pubmed.year.published > 2001)
dat = subset(dat, dat$pubmed.year.published < 2010)
dfCitationsAttributes = dat
```




The dataset has `10342` rows and `85`  columns.  


`163, 268, 355, 394, 387, 363, 373, 422, 338, 352, 348, 339, 258, 260, 252, 233, 242, 217, 211, 171, 174, 165, 158, 166, 153, 140, 117, 107, 110, 117, 99, 100, 96, 94, 86, 95, 84, 90, 62, 72, 81, 72, 62, 58, 52, 61, 53, 44, 39, 44, 47, 46, 44, 36, 38, 44, 38, 27, 32, 32, 23, 29, 21, 21, 31, 24, 22, 24, 26, 26, 27, 24, 25, 19, 19, 16, 18, 12, 21, 10, 26, 8, 7, 11, 21, 8, 10, 18, 15, 13, 17, 15, 7, 13, 8, 11, 13, 11, 9, 4, 11, 3, 10, 12, 8, 7, 8, 7, 7, 4, 9, 10, 6, 10, 7, 6, 4, 8, 5, 7, 6, 3, 7, 6, 7, 5, 5, 6, 1, 3, 2, 5, 3, 7, 3, 3, 6, 3, 2, 7, 3, 3, 2, 6, 3, 3, 2, 1, 3, 5, 5, 3, 3, 1, 2, 4, 4, 4, 1, 1, 2, 1, 4, 4, 2, 4, 4, 1, 3, 2, 3, 1, 2, 7, 4, 3, 3, 2, 3, 3, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 3, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1` 

Histogram of citations



```r
qplot(nCitedBy, data=dfCitationsAttributes, log="y")
```



```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```



```
## Warning message: Stacking not well defined when ymin != 0
```

<img src="http://i.imgur.com/OCaA9.png" class="plot" />





```r
summary(dfCitationsAttributes$nCitedBy)
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    29.5    34.0  2560.0 
```



```r
dim(dfCitationsAttributes)
```



```
## [1] 10342    85
```



```r
with(dfCitationsAttributes, summary(nCitedBy))
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    29.5    34.0  2560.0 
```




Fit



```r

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

all.results = function(res) {
  # give the results of the impact factor without exp because it is the
  # log impact factor, so interpretation is easier if kept in the log domain
  #print(calcCI.noexp(res, "lnimpact"))
  print(calcCI.exp(res, "dataset.in.geo.or.ae"))
}

#### Looks like this is the analysis
fit = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) +
rcs(first.author.num.prev.pubs.tr, 3) +           
rcs(first.author.num.prev.pmc.cites.tr, 3) +     
#rcs(first.author.year.first.pub.ago.tr, 3) +     
rcs(last.author.num.prev.pubs.tr, 3) +           
rcs(last.author.num.prev.pmc.cites.tr, 3) +      
#rcs(last.author.year.first.pub.ago.tr, 3) +
country.usa +                            
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
anova(fit)
```



```
## Analysis of Variance Table
## 
## Response: nCitedBy.log
##                                                Df Sum Sq Mean Sq F value
## rcs(num.authors.tr, 3)                          2    146      73  147.70
## rcs(pubmed.date.in.pubmed, 3)                   2   1541     770 1557.35
## rcs(first.author.num.prev.pubs.tr, 3)           2      5       3    5.54
## rcs(first.author.num.prev.pmc.cites.tr, 3)      2    179      90  181.43
## rcs(last.author.num.prev.pubs.tr, 3)            2      4       2    3.89
## rcs(last.author.num.prev.pmc.cites.tr, 3)       2    106      53  107.50
## country.usa                                     1      3       3    6.17
## rcs(institution.mean.norm.citation.score, 3)    2     11       5   10.65
## rcs(journal.num.articles.2008.tr, 3)            2     38      19   38.19
## rcs(journal.cited.halflife, 3)                  2      7       3    7.02
## rcs(journal.impact.factor.tr, 3)                2    326     163  329.31
## factor(pubmed.is.cancer)                        1     10      10   20.28
## factor(pubmed.is.animals)                       1     12      12   24.54
## factor(pubmed.is.plants)                        1     17      17   34.27
## factor(pubmed.is.core.clinical.journal)         1      4       4    8.06
## factor(dataset.in.geo.or.ae)                    1     18      18   35.88
## Residuals                                    4216   2086       0        
##                                                    Pr(>F)    
## rcs(num.authors.tr, 3)                            < 2e-16 ***
## rcs(pubmed.date.in.pubmed, 3)                     < 2e-16 ***
## rcs(first.author.num.prev.pubs.tr, 3)             0.00396 ** 
## rcs(first.author.num.prev.pmc.cites.tr, 3)        < 2e-16 ***
## rcs(last.author.num.prev.pubs.tr, 3)              0.02042 *  
## rcs(last.author.num.prev.pmc.cites.tr, 3)         < 2e-16 ***
## country.usa                                       0.01305 *  
## rcs(institution.mean.norm.citation.score, 3) 0.0000243529 ***
## rcs(journal.num.articles.2008.tr, 3)              < 2e-16 ***
## rcs(journal.cited.halflife, 3)                    0.00091 ***
## rcs(journal.impact.factor.tr, 3)                  < 2e-16 ***
## factor(pubmed.is.cancer)                     0.0000068777 ***
## factor(pubmed.is.animals)                    0.0000007554 ***
## factor(pubmed.is.plants)                     0.0000000052 ***
## factor(pubmed.is.core.clinical.journal)           0.00454 ** 
## factor(dataset.in.geo.or.ae)                 0.0000000023 ***
## Residuals                                                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
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
##     1.11 
## 
## $CI
## Estimate Estimate 
##     1.08     1.15 
## 
## $p
## Pr(>|t|) 
##        0 
## 
```





