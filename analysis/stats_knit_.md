<!--roptions dev='pdf', fig.width=5, fig.height=5, tidy=TRUE, cache=TRUE -->

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

<!--begin.rcode setup, include=FALSE
render_gfm() # use GFM hooks for output
#opts_knit$set(base.url='') #only needed if going to upload to github etc

opts_knit$set(upload = TRUE)
#knit_hooks$set(output = function(x, options) paste("1\n", sep = ""), source = function(x, options) paste("1\n", sep = ""), plot = hook_plot_html)
knit_hooks$set(plot = hook_plot_html)
end.rcode-->

Generated on <!--rinline date() -->


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

<!--begin.rcode getdata, echo=FALSE, cache=TRUE, eval=FALSE

# Read in data

dfCitations = read.csv("scopus_all.csv", header=TRUE, stringsAsFactors=F)

dfAnnotations = read.csv("Mendeley_annotated_250_of_11k.csv", header=TRUE, stringsAsFactors=F)

dfAttributes = read.csv("PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)

# Merge together attributes with citation information
dfCitationsAttributes = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")

# How big is the dataset
dim(dfCitationsAttributes)

end.rcode-->

The dataset has <!--rinline dfCitationsAttributes[1] --> rows and <!--rinline dfCitationsAttributes[2] -->  columns.

<!--begin.rcode saves, echo=FALSE, cache=TRUE, eval=FALSE


# Get subset that has been annotated
dfAnnotationsAnnotated = subset(dfAnnotations, TAG.annotated == "11k-subset-reviewed")

# Merge together annotations with citation information
dfCitationsAnnotated = merge(dfAnnotationsAnnotated, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAnnotated$isCreated = factor(dfCitationsAnnotated$TAG.created)
dfCitationsAnnotated$nCitedBy = as.numeric(dfCitationsAnnotated$Cited.by)


# Clean the data, get variables in useful formats
dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)

# How big is the dataset
dim(dfCitationsAttributes)

end.rcode-->

The dataset has <!--rinline dfCitationsAttributes[1] --> rows and <!--rinline dfCitationsAttributes[2] -->  columns.

<!--begin.rcode saves, echo=FALSE, cache=TRUE, eval=FALSE

# do saves
save(dfCitations, file = "dfCitations.RData")
save(dfAnnotations, file = "dfAnnotations.RData")
save(dfAttributes, file = "dfAttributes.RData")
save(dfCitationsAnnotated, file = "dfCitationsAnnotated.RData")
save(dfCitationsAttributes, file = "dfCitationsAttributes.RData")

end.rcode-->


Load the data and get going:

<!--begin.rcode loaddata, echo=TRUE, cache=TRUE

# Load

setwd("~/Documents/Projects/citation benefit in 11k study/citation11k/analysis")
load("dfCitations.RData")
load("dfAnnotations.RData")
load("dfCitationsAnnotated.RData")
load("dfAttributes.RData")
load("dfCitationsAttributes.RData")

end.rcode-->


# How big is the dataset?

<!--begin.rcode checkdata
dim(dfCitationsAttributes)
end.rcode-->


# Citations patterns

<!--begin.rcode libraries, echo=FALSE
library(rms)
source("PLoSONE2011_helper.R")
source("preprocess_raw_data.R")

get.dat.nums = function
( dat.raw )
{
    library(plyr)
    
    ow = options("warn") #save the warning level
    options(warn=-1) # set to no warnings because there are some columns that rae not numeric
    dat.nums = colwise(as.numeric)(dat.raw)  ##<<details this produces warnings
    options(ow) #reset the warning level
    return(dat.nums)
}

dat.raw = dfCitationsAttributes
end.rcode-->


<!--begin.rcode preprocessing, warning=FALSE, echo=FALSE

dat = preprocess.raw.data(dat.raw)
dat.nums = get.dat.nums(dat.raw)

end.rcode-->


<!--begin.rcode attributesWithCitation, echo=FALSE

dat.all = dat
dat.subset = subset(dat, !is.na(dat$nCitedBy))
dat.subset = subset(dat.subset, dat.subset$pubmed.year.published > 2001)
dat.subset = subset(dat.subset, dat.subset$pubmed.year.published < 2010)
dat = dat.subset
    
dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)

summary(dfCitationsAttributes$nCitedBy)

library(Hmisc)
dim(dfCitationsAttributes)
with(dfCitationsAttributes, summary(nCitedBy))

library(ggplot2)
end.rcode-->

### Raw histogram of citations
<!--begin.rcode histogramsNoLog
qplot(nCitedBy, data=dfCitationsAttributes)
end.rcode-->

### Histogram of citations, log scale
<!--begin.rcode histogramsLog
qplot(nCitedBy, data=dfCitationsAttributes, log="y")
end.rcode-->

## Other variables that correlate with citations
### Year of publication
<!--begin.rcode citationTables
with(dfCitationsAttributes, table(pubmed_year_published))
with(dfCitationsAttributes, summary(log(1+nCitedBy)~pubmed_year_published))
qplot(Year, nCitedBy, data=dfCitationsAttributes, geom="boxplot", log="y") + geom_jitter(color="blue", alpha=0.1)
end.rcode-->

### Number of authors
<!--begin.rcode numberAuthors
qplot(pubmed_number_authors, data=dfCitationsAttributes, log="y")
qplot(log(pubmed_number_authors), log(1+nCitedBy), data=dfCitationsAttributes) + geom_smooth()
end.rcode-->


Some more looks

<!--begin.rcode therest, fig.width=9, fig.height=9

# A quick summary of the data
print("Number of papers")
print("Data not available, Data available")
tapply(dat$nCitedBy>=0,
       dat$dataset.in.geo.or.ae.int,
       sum)

print("Number of citations")
print("Data not available, Data available")
tapply(dat$nCitedBy,
       dat$dataset.in.geo.or.ae.int,
       sum)

table(dat$dataset.in.geo.or.ae.int)
boxplot(nCitedBy ~ dataset.in.geo.or.ae.int,
        data = dat,
        boxwex = 0.5, 
        names=c("Data Not Shared", "Data Shared"), 
        ylab = "Number of Citations", outline=T, notch=F, log="y")

with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, mean))
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, median))
with(dat, tapply(nCitedBy, dataset.in.geo.or.ae.int, summary))
    
    
library(polycor)
myhetcorr = hetcor.modified(dat.subset, use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycor = myhetcorr$correlations
colnames(mycor) = colnames(myhetcorr$correlations)    
rownames(mycor) = rownames(myhetcorr$correlations)    

sort(mycor[,"nCitedBy.log"])
    
univarate.citation.predictors = which(abs(mycor[,"nCitedBy.log"]) > 0.1)
univarate.citation.predictors
length(univarate.citation.predictors)    
topcor = mycor[univarate.citation.predictors, univarate.citation.predictors]
heatmap.2(topcor, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

dat.uni = dat.subset[, univarate.citation.predictors]
    
# From ?pairs
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y, use="pairwise.complete.obs"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor)
}
 
# pairs(dat.uni[1:1000,20:34], lower.panel=panel.smooth, upper.panel=panel.cor)
 
#mycor.uni = mycor[univarate.citation.predictors, univarate.citation.predictors]
#heatmap.2(mycor.uni, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

  
  
library(gplots)    
heatmap.2(mycor, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)
    
#heatmap.3(mycor)
#heatmap.3(mycor, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

end.rcode-->


Some more looks

<!--begin.rcode more3, eval=TRUE, echo=FALSE

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

all.results = function(res) {
  # give the results of the impact factor without exp because it is the
  # log impact factor, so interpretation is easier if kept in the log domain
  #print(calcCI.noexp(res, "lnimpact"))
  print(calcCI.exp(res, "dataset.in.geo.or.ae"))
}
      
library(rms)

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
print(calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L"))   

par(mfrow = c(2, 2))
plot(fit)


with(dat.subset, tapply(nCitedBy, pubmed.year.published, mean, na.rm=T))

library(ggplot2)


num_authors_breaks = c(1, 5, 10, 20, 40)
citation_breaks = c(1, 10, 40, 100, 400, 1000)
qplot(num.authors.tr, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

qplot(pubmed.date.in.pubmed, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)


x_breaks = quantile(dat.subset$journal.impact.factor.tr, na.rm=T)
qplot(journal.impact.factor.tr, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)


qplot(country.usa, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)
qplot(first.author.num.prev.pubs.tr, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)
qplot(last.author.num.prev.pubs.tr, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)

x_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)
qplot(institution.mean.norm.citation.score, nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth() + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks)



end.rcode-->


Some more looks

<!--begin.rcode therest2, eval=FALSE, echo=FALSE



hetcor(dat.subset[,c("num.authors.tr", "pubmed.date.in.pubmed", "country.usa", "journal.impact.factor.tr", "pubmed.is.cancer", "dataset.in.geo.or.ae")])

fit = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) +
#rcs(first.author.num.prev.pubs.tr, 3) +           
#rcs(first.author.num.prev.pmc.cites.tr, 3) +     
#rcs(last.author.num.prev.pubs.tr, 3) +           
#rcs(last.author.num.prev.pmc.cites.tr, 3) +      
country.usa +                            
#rcs(institution.mean.norm.citation.score, 3) +
#rcs(journal.num.articles.2008.tr, 3) +           
#rcs(journal.cited.halflife, 3) +                 
#rcs(journal.microarray.creating.count.tr, 3) +   
rcs(journal.impact.factor.tr, 3) +               
factor(pubmed.is.cancer) +
factor(dataset.in.geo.or.ae)
           , dat.subset)
anova(fit)
print(calcCI.exp(fit, "dataset.in.geo.or.ae.L"))    






##########

# Dig in to looking at annotated subset

library(Hmisc)
dim(dfCitationsAnnotated)
with(dfCitationsAnnotated, table(isCreated))
with(dfCitationsAnnotated, summary(nCitedBy~isCreated))
with(dfCitationsAnnotated, summary(log(1+nCitedBy)~isCreated))

# Do they look different
library(ggplot2)
qplot(nCitedBy, data=dfCitationsAnnotated)
qplot(nCitedBy, data=dfCitationsAnnotated, color=isCreated, geom="density", binwidth=25)
qplot(isCreated, nCitedBy, data=dfCitationsAnnotated, geom="boxplot") + geom_jitter(position=position_jitter(width=.01), color="blue") 
qplot(isCreated, log(1+nCitedBy), data=dfCitationsAnnotated, geom="boxplot") + geom_jitter(position=position_jitter(width=.01), color="blue") 
  
# Do they have different distributions
with(dfCitationsAnnotated, t.test(nCitedBy~isCreated))
with(dfCitationsAnnotated, t.test(log(1+nCitedBy)~isCreated))
with(dfCitationsAnnotated, wilcox.test(nCitedBy~isCreated))

# Also double check with whatever multivariate thing I come up with 
#### TODO

# Do stuff below.  then:
dat.annotated.merged = merge(dfCitationsAnnotated, dat.subset, by="pmid")
dat.annotated.merged.created = subset(dat.annotated.merged, isCreated==levels(isCreated)[1])

fit.annotated.merged = lm(nCitedBy.log ~ rcs(num.authors.tr, 3) + 
rcs(pubmed.date.in.pubmed, 3) +
#rcs(first.author.num.prev.pubs.tr, 3) +           
#rcs(first.author.num.prev.pmc.cites.tr, 3) +     
#rcs(first.author.year.first.pub.ago.tr, 3) +     
#rcs(last.author.num.prev.pubs.tr, 3) +           
#rcs(last.author.num.prev.pmc.cites.tr, 3) +      
#rcs(last.author.year.first.pub.ago.tr, 3) +
#country.usa +                            
#rcs(institution.mean.norm.citation.score, 3) +
#rcs(journal.num.articles.2008.tr, 3) +           
#rcs(journal.cited.halflife, 3) +                 
#rcs(journal.microarray.creating.count.tr, 3) +   
rcs(journal.impact.factor.tr, 3) +   
#isCreated  +  #adding this!!!          
 dataset.in.geo.or.ae
           , dat.annotated.merged.created)
anova(fit.annotated.merged)
print(calcCI.exp(fit.annotated.merged, "dataset.in.geo.or.ae.L")) 


with(dfCitationsAnnotated, tapply(nCitedBy, Year, mean, na.rm=T))


myhetcorr.annotated.merged = hetcor.modified(dat.annotated.merged, use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycor.annotated.merged = myhetcorr.annotated.merged$correlations
colnames(mycor.annotated.merged) = colnames(myhetcorr.annotated.merged$correlations)    
rownames(mycor.annotated.merged) = rownames(myhetcorr.annotated.merged$correlations)    

sort(mycor.annotated.merged[,"isCreated"])


###### EXTRA

library(MASS)
fit = glm.nb(nCitedBy.log ~ rcs(num.authors.tr, 5) + 
rcs(pubmed.date.in.pubmed, 5) +
country.usa +                            
rcs(journal.impact.factor.tr, 5) +               
factor(pubmed.is.cancer) +
factor(dataset.in.geo.or.ae)
           , dat.subset)
anova(fit)
print(calcCI.exp(fit, "dataset.in.geo.or.ae.L")) 

end.rcode-->


