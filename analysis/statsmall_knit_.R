
## @knitr setup
render_gfm() # use GFM hooks for output

# use imgur for hosting figures.  This is the default.
opts_knit$set(upload.fun=imgur_upload) # upload all images to imgur.com
knit_hooks$set(plot = hook_plot_html)
build_dep()
 


## @knitr workspace
# Clear the workspace and load package dependencies: 
rm(list=ls())   
require(ggplot2)
require(Hmisc)
require(plyr)
require(rms)
options(scipen=8)


## @knitr gfmtable
# From https://gist.github.com/2050761
gfm_table <- function(x, ...){
  require(ascii)
  y <- capture.output(print(ascii(x, ...), type = 'org'))
  # substitute + with | for table markup
  # TODO: modify regex so that only + signs in markup, like -+- are substituted
  y <- gsub('[+]', '|', y)
  return(writeLines(y))
} 
#library(ascii)
#gfm_table(anova(fit))


## @knitr unnamed-chunk-1
dfAttributes = read.csv("data/PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)


## @knitr unnamed-chunk-2
dfCitations = read.csv("data/scopus_all.csv", header=TRUE, stringsAsFactors=F)


## @knitr unnamed-chunk-3
dfCitationsAttributesRaw = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")


## @knitr unnamed-chunk-4
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published > 2001)
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published < 2010)
dim(dfCitationsAttributesRaw)


## @knitr sourcing
dfCitationsAttributesRaw$nCitedBy = as.numeric(dfCitationsAttributesRaw$Cited.by)
dfCitationsAttributesRaw[which(is.na(dfCitationsAttributesRaw$nCitedBy)),]$nCitedBy=0
dim(dfCitationsAttributesRaw)
 
source("helpers.R")
source("preprocess_raw_data.R")
 
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
dim(dfCitationsAttributes)
options(scipen=8)



## @knitr unnamed-chunk-5
library(ascii)
a = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:10]
gfm_table(cbind(names(a), round(a, 2)))


## @knitr unnamed-chunk-6
library(ascii)
gfm_table(table(dfCitationsAttributesRaw$pubmed_year)/nrow(dfCitationsAttributesRaw))


## @knitr unnamed-chunk-7
library(ascii)
gfm_table(table(dfCitationsAttributesRaw$in_ae_or_geo)/nrow(dfCitationsAttributesRaw))


## @knitr libraryggplot2
library(ggplot2)
qplot(nCitedBy.log, data=dfCitationsAttributes)


## @knitr unnamed-chunk-8
summary(dfCitationsAttributes$nCitedBy)


## @knitr unnamed-chunk-9
dat = dfCitationsAttributes

# Number of papers vs Data availability
tapply(dat$nCitedBy>=0,
       dat$dataset.in.geo.or.ae.int,
       sum)

# Number of citations vs Data availability
tapply(dat$nCitedBy,
       dat$dataset.in.geo.or.ae.int,
       sum)

# Number of citations vs Data availability
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, summary))

table(dat$dataset.in.geo.or.ae.int)
boxplot(nCitedBy+1 ~ dataset.in.geo.or.ae.int,
        data = dat,
        boxwex = 0.5, 
        names=c("Data Not Shared", "Data Shared"), 
        ylab = "Number of Citations", outline=T, notch=F, log="y")



## @knitr univariatecorrnowarnings
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

    
univarate.citation.predictors = which(abs(mycor[,"nCitedBy.log"]) > 0.1)
#univarate.citation.predictors
length(univarate.citation.predictors)    
topcor = mycor[univarate.citation.predictors, univarate.citation.predictors]


library(gplots)

heatmap.2(topcor, col=bluered(16), cexRow=1, cexCol = 1, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)




## @knitr univariateqplots
 
library(ggplot2)

dat.subset = dfCitationsAttributes
with(dat.subset, tapply(nCitedBy, pubmed.year.published, median, na.rm=T))


num_authors_breaks = c(1, 5, 10, 20, 40)
citation_breaks = c(1, 10, 40, 100, 400, 1000)

with(dat.subset, tapply(nCitedBy, cut(num.authors.tr, num_authors_breaks), median, na.rm=T))


qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

qplot(pubmed.date.in.pubmed, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

qplot(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

qplot(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)
qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)





## @knitr unnamed-chunk-10

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

fit

print(calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L"))   




## @knitr unnamed-chunk-11

library(ascii)
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

  print(calcCI.exp(myfit, "factor(dataset.in.geo.or.ae).L"))   
}

for (year in seq(2002, 2009) {
  dat.subset.year = subset(dat.subset, pubmed.year.published==year)
  a = do_analysis(dat.subset.year)
  print (a)
}




