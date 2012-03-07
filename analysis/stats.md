

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0

To run this I start R, set the working directory to match where this file is, then run the following in R:

  > library(knitr)  
  > knit("stats_knit_.md")  # has underscores around the knit but md displays badly




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





## Tell me how big it is



```r
dim(dfCitationsAttributes)
```



```
## [1] 10694   197
```





## Now look at attributes with citation











```r

dat.all = dat
dat.subset = subset(dat, !is.na(dat$nCitedBy))
dat.subset = subset(dat.subset, dat.subset$pubmed.year.published > 
    2001)
dat.subset = subset(dat.subset, dat.subset$pubmed.year.published < 
    2010)
dat = dat.subset

dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)

summary(dfCitationsAttributes$nCitedBy)
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     1.0     7.0    16.0    32.2    35.0  2640.0   173.0 
```



```r

library(Hmisc)
dim(dfCitationsAttributes)
```



```
## [1] 10694   197
```



```r
with(dfCitationsAttributes, summary(nCitedBy))
```



```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     1.0     7.0    16.0    32.2    35.0  2640.0   173.0 
```




###VIZ



```r

library(ggplot2)
qplot(nCitedBy, data = dfCitationsAttributes)
```



```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

<img src="http://i.imgur.com/kvSFu.png" class="plot" />







