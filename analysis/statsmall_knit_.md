<!--roptions dev='png', fig.width=5, fig.height=5, tidy=FALSE, cache=TRUE, echo=TRUE, message=FALSE, warning=FALSE, autodep=TRUE-->

<!--begin.rcode setup, echo=FALSE, cache=FALSE
render_gfm() # use GFM hooks for output

# use imgur for hosting figures.  This is the default.
opts_knit$set(upload.fun=imgur_upload) # upload all images to imgur.com
knit_hooks$set(plot = hook_plot_html)
build_dep()
 
end.rcode-->


# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <!--rinline date() -->

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("statsmall_knit_.md")

or, from the command line

    R -e "library(knitr); knit('statsmall_knit_.md')"
    pandoc -r markdown -w html -H header.html statsmall.md > temp.html
    file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/test.html

<!--begin.rcode workspace, messages=FALSE, echo=FALSE
# Clear the workspace and load package dependencies: 
rm(list=ls())   
require(ggplot2, quietly=T)
require(gplots, quietly=T)
require(plyr, quietly=T)
require(rms, quietly=T)
require(polycor, quietly=T)
require(ascii, quietly=T)

options(scipen=8)
end.rcode-->

<!-- begin.rcode gfmtable, echo=FALSE
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
end.rcode -->



# Data availability citation boost consistent with observed rates of data reuse

## Methods

### Assemble citation dataset

PLoS papers, as identified in PLoS ONE study:

- Piwowar HA (2011) Who shares? Who doesn’t? Factors associated with openly archiving raw research data. PLoS ONE 6(7): e18657. doi:10.1371/journal.pone.0018657
- Piwowar HA (2011) Data from: Who shares? Who doesn’t? Factors associated with openly archiving raw research data. Dryad Digital Repository. doi:10.5061/dryad.mf1sd

<!--begin.rcode
dfAttributes = read.csv("data/PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)
end.rcode-->

Got the citations from Scopus:

<!--begin.rcode
dfCitations = read.csv("data/scopus_all.csv", header=TRUE, stringsAsFactors=F)
end.rcode-->

Now merge together attributes with citation information.

<!--begin.rcode
dfCitationsAttributesRaw = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")
end.rcode-->

The dataset has <!--rinline dim(dfCitationsAttributesRaw)[1] --> rows and <!--rinline dim(dfCitationsAttributesRaw)[2] -->  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

### Statistical analysis



####Preprocessing


Limit to just those published after 2001 and before 2010.

<!--begin.rcode
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published > 2000)
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published < 2010)
dim(dfCitationsAttributesRaw)
end.rcode-->

Get citations into the right format

<!--begin.rcode sourcing, message=FALSE, warning=FALSE
dfCitationsAttributesRaw$nCitedBy = as.numeric(dfCitationsAttributesRaw$Cited.by)
dfCitationsAttributesRaw[which(is.na(dfCitationsAttributesRaw$nCitedBy)),]$nCitedBy=0
dim(dfCitationsAttributesRaw)
 
source("helpers.R")
source("preprocess_raw_data.R")
 
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
dim(dfCitationsAttributes)
options(scipen=8)

end.rcode-->


The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns. 


## Results


### Analysis of 11k PLoS articles based on automated determination of data availability

#### Description of cohort

The PLoS study had <!--rinline dim(dfAttributes)[1]--> rows.  For this study we exclude extreme years.

The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns.  


Distribution by journal
<!--begin.rcode
a = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:10]
gfm_table(cbind(names(a), round(a, 2)))
end.rcode-->

Distribution by year
<!--begin.rcode
gfm_table(table(dfCitationsAttributesRaw$pubmed_year)/nrow(dfCitationsAttributesRaw))
end.rcode-->

Distribution by data availability
<!--begin.rcode
gfm_table(table(dfCitationsAttributesRaw$in_ae_or_geo)/nrow(dfCitationsAttributesRaw))
end.rcode-->

Distribution by citation

The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns.  


<!--begin.rcode libraryggplot2, message=FALSE
qplot(nCitedBy.log, data=dfCitationsAttributes)
end.rcode-->

<!--begin.rcode 
summary(dfCitationsAttributes$nCitedBy)
end.rcode-->

#### Univariate

<!--begin.rcode
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

end.rcode-->
    
<!--begin.rcode univariatecorrnowarnings, warning=FALSE, fig.width=9, fig.height=9
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



heatmap.2(topcor, col=bluered(16), cexRow=1, cexCol = 1, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)


end.rcode-->
    
<!--begin.rcode univariateqplots, fig.width=9, fig.height=9
 

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



end.rcode-->

#### Multivariate



##### All years

<!--begin.rcode

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

fit

print(calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L"))   


end.rcode-->

##### Now by year

<!--begin.rcode

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

estimates_by_year

ggplot(estimates_by_year, aes(x=year, y=est)) + geom_line() + 
  geom_errorbar(width=.1, aes(ymin=ciLow, ymax=ciHigh)) +
  scale_x_continuous(name='year of publication') +
  scale_y_continuous(limits=c(0, 2.5), name='citations proportion for \n(papers with available data)/(those without)')

end.rcode-->

##### Now by year

<!--begin.rcode

# Using analysis method of splines, consistent with current study

  dat.subset.previous.study = subset(dfCitationsAttributes, (pubmed.year.published<2003) & (pubmed.is.cancer==1) & (pubmed.is.humans==1))

  dim(dat.subset.previous.study)

  myfitprev = lm(nCitedBy.log ~ 
    rcs(pubmed.date.in.pubmed, 3) +
    country.usa +              
    rcs(journal.impact.factor.tr, 3) +               
    factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)

  gfm_table(anova(myfitprev))

  myfitprev

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")

# Using analysis method of linear fit, consistent with previous study

  myfitprev = lm(nCitedBy.log ~ 
    pubmed.date.in.pubmed +
    country.usa +              
    journal.impact.factor.tr +               
    factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)

  gfm_table(anova(myfitprev))

  myfitprev

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")

end.rcode-->


### Subset, manual classification of data availability 

#### Description

#### Univariate



### Independent analysis, reuse frequency

#### Description

#### Univariate

