<!--roptions dev='png', fig.width=5, fig.height=5, tidy=FALSE, cache=FALSE, echo=TRUE, message=FALSE, warning=FALSE, autodep=TRUE -->

<!--begin.rcode setup, echo=FALSE, cache=FALSE

# use imgur for hosting figures
# go to my_imgur_api_key.txt and add your own api key

upload_images = FALSE

if (upload_images) {
 opts_knit$set(upload.fun=function(file) {
  my_imgur_api_key = read.table("my_imgur_api_key.txt", header=TRUE, sep="\t")
  imgur_upload(file, key=my_imgur_api_key$key)
  })
}

# use html style links to plots, rather than markdown style         
knit_hooks$set(plot = hook_plot_html)
build_dep()

require(knitcitations)
cleanbib()
# to get knitcitations:
#library(devtools)
#install_github("knitcitations", "cboettig")
 
end.rcode-->

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <!--rinline date() -->

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line

    R -e "library(knitr); knit('stats_knit_.md')"
    pandoc -r markdown -w html -H header.html stats.md > stats.html
    file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/stats.html

to see just the R code in a separate .R file called stats_knit_.R, run 
    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"

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

source("helpers.R")
source("preprocess_raw_data.R")

end.rcode-->

<!--begin.rcode gfmtable, echo=FALSE, cache=FALSE
# From https://gist.github.com/2050761
gfm_table <- function(x, ...){
  y <- capture.output(print(ascii(x, ...), type = 'org'))
  # substitute + with | for table markup
  # TODO: modify regex so that only + signs in markup, like -+- are substituted
  y <- gsub('[+]', '|', y)
  return(writeLines(y))
} 
#gfm_table(anova(fit))
end.rcode-->

<!--begin.rcode colours, echo=FALSE
#colourblind friendly palettes from http://wiki.stdout.org/rcookbook/Graphs/Colors%20(ggplot2)
cbgRaw = c("#E69F00", "#56B4E9", "#009E73", "#999999", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cbgFillPalette <- scale_fill_manual(values=cbgRaw)
cbgColourPalette <- scale_colour_manual(values=cbgRaw)
cbgColorPalette = cbgColourPalette

end.rcode-->


# Data availability citation boost consistent with observed rates of data reuse


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there evidence any increase in citations is related to data reuse?

## Abstract

See the [end of this document](#abstract-1) (at the end so it can pull in results from the R analysis).

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis[1]. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection.” [Piwowar, Sharing] 

When research data is made publicly available, is there a demonstrable benefit to scientific progress and the study investigators?  

Citations are often used as a proxy for the scientific contribution of a paper.  Citations are also used in research funding and promotion decisions; Boosting citation rate is thus is a potentially important motivator for publication authors.

Previous studies have explored the relationship between the citation rate of a publication and whether its data was made publicly available.  The first study we know about..... In 2007, co-authors and I published a report that found … .  Others have also found correlations between citation rate and data availability.

Here, we report an analysis based on a large cohort of relatively homogenious studies.  The size our cohort has facilitated controlling for many more variables than previous studies, allowing us to make further progress in isolating the citation rate relationship with data archiving itself.

Clinical microarray data provides a useful environment for the investigation: despite being valuable for reuse valuable for reuse [butte] and well-supported by data sharing standards and infrastructure [], fewer than half of the studies that collect this data make it publicly available [Ochsner, Piwowar]

## Methods

Analysis run on <!--rinline date() -->.

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


## Results

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
 
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
dim(dfCitationsAttributes)
options(scipen=8)

end.rcode-->


The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns. 




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
gfm_table(table(dfCitationsAttributesRaw$pubmed_year_published)/nrow(dfCitationsAttributesRaw))

#library(ggplot2)
qplot(factor(pubmed_year_published), nCitedBy, data=dfCitationsAttributesRaw, geom="boxplot", log="y") + geom_jitter(color="blue", alpha=0.1) + cbgFillPalette + cbgColourPalette

end.rcode-->

Distribution by data availability
<!--begin.rcode test
gfm_table(table(dfCitationsAttributesRaw$in_ae_or_geo)/nrow(dfCitationsAttributesRaw))
end.rcode-->

Distribution by citation

The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns.  


<!--begin.rcode libraryggplot2, message=FALSE

qplot(nCitedBy.log, data=dfCitationsAttributes) + cbgFillPalette + cbgColourPalette
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
    
<!--begin.rcode univariatecorrnowarnings, warning=FALSE

#dat = dfCitationsAttributes
myhetcorr = hetcor.modified(dat, use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycor = myhetcorr$correlations
colnames(mycor) = colnames(myhetcorr$correlations)    
rownames(mycor) = rownames(myhetcorr$correlations)    

# Correlations with data availability
## See if anything is so collinear it will cause problems in regression
a = sort(mycor[,"dataset.in.geo.or.ae.int"], dec=T)
gfm_table(cbind(names(a), round(a, 2)))

# Correlations with citation
a = sort(mycor[,"nCitedBy.log"], dec=T)
gfm_table(cbind(names(a), round(a, 2)))

univarate.citation.predictors = which(abs(mycor[,"nCitedBy.log"]) > 0.1)
#univarate.citation.predictors
length(univarate.citation.predictors)    
topcor = mycor[univarate.citation.predictors, univarate.citation.predictors]

end.rcode-->
    
<!--begin.rcode heatmap42, fig.width=9, fig.height=9
    
heatmap.2(topcor, col=bluered(16), cexRow=1, cexCol = 1, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

end.rcode-->
    
<!--begin.rcode univariateqplots, fig.width=9, fig.height=9
 

dat.subset = dfCitationsAttributes
with(dat.subset, tapply(nCitedBy, pubmed.year.published, median, na.rm=T))


num_authors_breaks = c(1, 5, 10, 20, 40)
citation_breaks = c(1, 10, 40, 100, 400, 1000)

with(dat.subset, tapply(nCitedBy, cut(num.authors.tr, num_authors_breaks), median, na.rm=T))

qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette


qplot(pubmed.date.in.pubmed, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette


##Distribution by journal

most_common_journals = names(sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:10])
dat_most_common_journals = subset(dfCitationsAttributesRaw, (pubmed_journal %in% most_common_journals))

prop.table(table(dat_most_common_journals$pubmed_journal, dat_most_common_journals$in_ae_or_geo), margin=1)  

ggplot(data=dat_most_common_journals, aes(x=pubmed_date_in_pubmed, y=1+nCitedBy, color=factor(in_ae_or_geo))) + geom_point() + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette + facet_wrap(~ pubmed_journal)

ggplot(dat.subset, aes(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(pubmed.is.cancer, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(pubmed.is.humans, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(pubmed.is.cultured.cells, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(has.R.funding, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(country.usa, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

qplot(num.grants.via.nih.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

x_breaks = quantile(dat.subset$last.author.num.prev.microarray.creations.tr, na.rm=T)
qplot(last.author.num.prev.microarray.creations.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

ggplot(dat.subset, aes(dataset.in.geo.or.ae, last.author.num.prev.pubs.tr)) + geom_jitter() + geom_boxplot(aes(group=dataset.in.geo.or.ae)) + scale_y_continuous(trans="log10", breaks=x_breaks, labels=x_breaks)  + cbgFillPalette + cbgColourPalette + coord_flip() 


x_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)
qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette
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
citation.boost.coefs = calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L")
print(citation.boost.coefs)

end.rcode-->

Estimate of citation boost is 
<!--rinline 100*(citation.boost.coefs$est-1) -->%
with 95% confidence intervals [<!--rinline 100*(citation.boost.coefs$ciLow-1) -->%
, <!--rinline 100*(citation.boost.coefs$ciHigh-1) -->% ]
(p=<!--rinline format(citation.boost.coefs$p, nsmall = 2) -->)


##### now with journal covariates

<!--begin.rcode

fit_w_journal = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
          factor(journal.impact.factor.tr) +
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
          #rcs(journal.impact.factor.tr, 3) +               
          factor(pubmed.is.cancer) +
          factor(pubmed.is.animals) +
          factor(pubmed.is.plants) +
          factor(pubmed.is.core.clinical.journal) +
          factor(dataset.in.geo.or.ae)
           , dfCitationsAttributes)

gfm_table(anova(fit_w_journal))

fit_w_journal
citation.boost.coefs.journal = calcCI.exp(fit_w_journal, "factor(dataset.in.geo.or.ae).L")
print(citation.boost.coefs.journal)

end.rcode-->

Estimate of citation boost is 
<!--rinline 100*(citation.boost.coefs.journal$est-1) -->%
with 95% confidence intervals [<!--rinline 100*(citation.boost.coefs.journal$ciLow-1) -->%
, <!--rinline 100*(citation.boost.coefs.journal$ciHigh-1) -->% ]
(p=<!--rinline format(citation.boost.coefs.journal$p, nsmall = 2) -->)

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

<!--begin.rcode

dfAnnotations = read.csv("data/Mendeley_annotated_250_of_11k.csv", header=TRUE, stringsAsFactors=F)

# Get subset that has been annotated
dfAnnotationsAnnotated = subset(dfAnnotations, TAG.annotated == "11k-subset-reviewed")

# Merge together annotations with citation information
dfCitationsAnnotated = merge(dfAnnotationsAnnotated, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAnnotated$isCreated = factor(dfCitationsAnnotated$TAG.created)
dfCitationsAnnotated$nCitedBy = as.numeric(dfCitationsAnnotated$Cited.by)


end.rcode-->


<!--begin.rcode

# Dig in to looking at annotated subset

dim(dfCitationsAnnotated)
with(dfCitationsAnnotated, table(isCreated))
with(dfCitationsAnnotated, summary(nCitedBy~isCreated))
with(dfCitationsAnnotated, summary(log(1+nCitedBy)~isCreated))

#library(ggplot2)

# Do they look different
qplot(nCitedBy, data=dfCitationsAnnotated)
qplot(nCitedBy, data=dfCitationsAnnotated, color=isCreated, geom="density", binwidth=25)
qplot(isCreated, log(1+nCitedBy), data=dfCitationsAnnotated, geom="boxplot") + 
  geom_jitter(position=position_jitter(width=.1), color="blue")

end.rcode-->


<!--begin.rcode
  
# Do they have different distributions
with(dfCitationsAnnotated, print(t.test(nCitedBy~isCreated)))
with(dfCitationsAnnotated, print(t.test(log(1+nCitedBy)~isCreated)))
with(dfCitationsAnnotated, print(wilcox.test(nCitedBy~isCreated)))

# Now look if just created has the same pattern 

dat.annotated.merged = merge(dfCitationsAnnotated, dfCitationsAttributes, by="pmid")
dat.annotated.merged.created = subset(dat.annotated.merged, isCreated==levels(isCreated)[1])

#library(rms)

fit.annotated.merged = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) + 
rcs(journal.impact.factor.tr, 3) +   
 dataset.in.geo.or.ae
           , dat.annotated.merged.created)
anova(fit.annotated.merged)
print(calcCI.exp(fit.annotated.merged, "dataset.in.geo.or.ae.L")) 
dim(dat.annotated.merged.created)

end.rcode-->


## Dig into tracking 1k

<!--begin.rcode

dfTracking1k = read.csv("data/tracking1k_20111008.csv", sep=",", header=TRUE, stringsAsFactors=F)

dim(dfTracking1k)
#names(dfTracking1k)

dfTracking1k.GEO.subset = subset(dfTracking1k, TAG.source=="WoS" & TAG.confidence!="low confidence" & is.na(duplicates & TAG.repository=="GEO" & (TAG.dataset.reused=="dataset reused" | TAG.dataset.reused=="dataset not reused")))

num.GEO.total = dim(dfTracking1k.GEO.subset)[1]
num.GEO.reused = dim(subset(dfTracking1k.GEO.subset, TAG.dataset.reused=="dataset reused"))[1]

annotated.prop = binconf(num.GEO.reused, num.GEO.total)

end.rcode-->


Proportion of citations to datasets that were in the context of data use (n=<!--rinline num.GEO.total -->):
<!--rinline 100*(round(annotated.prop[1], 2)) -->%
with 95% confidence intervals [<!--rinline 100*(round(annotated.prop[2], 2)) -->%
, <!--rinline 100*(round(annotated.prop[3], 2)) -->% ]


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

see references in [Mendeley library](http://www.mendeley.com/groups/2223913/11k-citation/papers/)


And now I want to thank Carl for his great library! 
<!--begin.rcode echo=FALSE, results="asis", cache=FALSE
citep(list(citation("knitcitations"))) 
end.rcode-->. 

Now cite everyone! 
<!--begin.rcode echo=FALSE, results="asis", cache=FALSE
biblio <- read.bibtex("citation11k.bib")

citep(biblio[names(biblio)])
end.rcode-->

### demo bibliography

<!--begin.rcode bib, results='asis', echo=FALSE, cache=FALSE
bibliography()
end.rcode-->

### Other studies of citation benefit:

- Gleditsch, Nils Petter & Håvard Strand, 2003. 'Posting Your Data: Will You Be Scooped or Will You Be Famous?', International Studies Perspectives 4(1): 89–97.
- Henneken, Edwin A and Accomazzi, Alberto.  Linking to Data - Effect on Citation Rates in Astronomy. eprint arXiv:1111.3618 11/2011
- Ioannidis et al. Repeatability of published microarray gene expression analyses  Nature Genetics 41, 149 - 155 (2009) .  doi:10.1038/ng.295
- Pienta et al The Research Data Life Cycle and the Probability of Secondary Use in Re-Analysis 
The Research Data Life Cycle and the Probability of Secondary Use in Re-Analysis 
- Amy M. Pienta, George Alter, Jared Lyle.  The Enduring Value of Social Science Research: The Use and Reuse of Primary Research Data.  http://hdl.handle.net/2027.42/78307 
- Piwowar HA, Day RS, Fridsma DB (2007) Sharing Detailed Research Data Is Associated with Increased Citation Rate. PLoS ONE 2(3): e308. doi:10.1371/journal.pone.0000308
- http://www.komfor.net/blog/unbenanntemitteilung


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
In a multivariate linear regression on <!--rinline dim(dfCitationsAttributesRaw)[1] --> studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 
<!--rinline 100*(citation.boost.coefs$est-1) -->%
(95% confidence interval: [<!--rinline 100*(citation.boost.coefs$ciLow-1) -->%
to <!--rinline 100*(citation.boost.coefs$ciHigh-1) -->%)
more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 
<!--rinline 100*(round(annotated.prop[1], 2)) -->%
(95% CI: <!--rinline 100*(round(annotated.prop[2], 2)) -->%
to <!--rinline 100*(round(annotated.prop[3], 2)) -->%, 
n=<!--rinline num.GEO.total -->)
of citations to those studies were in the context of data reuse attribution.

### Discussion
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.


