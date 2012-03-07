<!--roptions dev='png', fig.width=5, fig.height=5, tidy=TRUE -->

# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!

To run this I start R, set the working directory to match where this file is, then run the following in R:

  > library(knitr)  
  > knit("stats_knit_.md")  # has underscores around the knit but md displays badly

<!--begin.rcode setup, include=FALSE
render_gfm() # use GFM hooks for output
#opts_knit$set(base.url='')
#opts_knit$set(imgur.key = '')
opts_knit$set(upload = TRUE)
#knit_hooks$set(output = function(x, options) paste("1\n", sep = ""), source = function(x, options) paste("1\n", sep = ""), plot = hook_plot_html)
knit_hooks$set(plot = hook_plot_html)
end.rcode-->

Get the data:

<!--begin.rcode getdata, echo=FALSE, cache=TRUE, eval=FALSE

# Read in data
setwd("~/Documents/Projects/citation benefit in 11k study/citation11k/analysis")

dfCitations = read.csv("scopus_all.csv", header=TRUE, stringsAsFactors=F)

dfAnnotations = read.csv("Mendeley_annotated_250_of_11k.csv", header=TRUE, stringsAsFactors=F)

dfAttributes = read.csv("PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)

# Get subset that has been annotated
dfAnnotationsAnnotated = subset(dfAnnotations, TAG.annotated == "11k-subset-reviewed")

# Merge together annotations with citation information
dfCitationsAnnotated = merge(dfAnnotationsAnnotated, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAnnotated$isCreated = factor(dfCitationsAnnotated$TAG.created)
dfCitationsAnnotated$nCitedBy = as.numeric(dfCitationsAnnotated$Cited.by)

# Merge together attributes with citation information
dfCitationsAttributes = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)

# How big is the dataset
dim(dfCitationsAttributes)

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
<!--begin.rcode Number of authors
qplot(pubmed_number_authors, data=dfCitationsAttributes, log="y")
qplot(log(pubmed_number_authors), log(1+nCitedBy), data=dfCitationsAttributes) + geom_smooth()
end.rcode-->

<!--begin.rcode therest, eval=FALSE, echo=FALSE

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
 
pairs(dat.uni[1:1000,20:34], lower.panel=panel.smooth, upper.panel=panel.cor)
 
mycor.uni = mycor[univarate.citation.predictors, univarate.citation.predictors]
heatmap.2(mycor.uni, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

  
  
library(gplots)    
heatmap.2(mycor, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)
    
heatmap.3(mycor)
#heatmap.3(mycor, col=bluered(16), cexRow=0.5, cexCol = .8, symm = TRUE, dend = "row", trace = "none", main = "Thesis Data", margins=c(15,15), key=FALSE, keysize=0.1)

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


