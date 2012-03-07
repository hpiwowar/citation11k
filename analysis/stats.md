

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!

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

<img src="http://i.imgur.com/8aUEc.png" class="plot" />



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

<img src="http://i.imgur.com/tTjeb.png" class="plot" />



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

<img src="http://i.imgur.com/AM9KR.png" class="plot" />



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

<img src="http://i.imgur.com/yBuIt.png" class="plot" />


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

<img src="http://i.imgur.com/TYkYj.png" class="plot" />







