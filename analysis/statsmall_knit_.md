<!--begin.rcode echo=FALSE
render_gfm() # use GFM hooks for output

# use imgur for hosting figures.  This is the default.
opts_knit$set(upload = TRUE)
knit_hooks$set(plot = hook_plot_html)
end.rcode-->

<!--roptions dev='pdf', fig.width=5, fig.height=5, tidy=FALSE, cache=TRUE, echo=TRUE, messages=FALSE, warnings=FALSE-->


# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <!--rinline date() -->

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("statsmall_knit_.md")


<!--begin.rcode setup, echo=FALSE
# Clear the workspace and load package dependencies: 
rm(list=ls())   
require(ggplot2)
require(Hmisc)
require(plyr)
require(rms)
options(scipen=8)
end.rcode-->

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
dfCitationsAttributes = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")
end.rcode-->

The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

*FIXME: The PLoS study had <!--rinline dim(dfAttributes)[1]--> rows.  Where are the rest?  Missing Scopus data.  Go recollect.*

## Results

## Citations patterns

<!--begin.rcode libraries, echo=FALSE
source("PLoSONE2011_helper.R")
source("preprocess_raw_data.R")

get.dat.nums = function
( dat.raw )
{
    ow = options("warn") #save the warning level
    options(warn=-1) # set to no warnings because there are some columns that rae not numeric
    dat.nums = colwise(as.numeric)(dat.raw)  ##<<details this produces warnings
    options(ow) #reset the warning level
    return(dat.nums)
}
end.rcode-->

Preprocessing

<!--begin.rcode
dfCitationsAttributes$nCitedBy = as.numeric(dfCitationsAttributes$Cited.by)
dfCitationsAttributes[which(is.na(dfCitationsAttributes$nCitedBy)),]$nCitedBy=0
end.rcode-->

<!--begin.rcode preprocessing, warning=FALSE
dat = preprocess.raw.data(dfCitationsAttributes)
end.rcode-->


Limit to just those published after 2001 and before 2010.

<!--begin.rcode
dat = subset(dat, dat$pubmed.year.published > 2001)
dat = subset(dat, dat$pubmed.year.published < 2010)
dfCitationsAttributes = dat
end.rcode-->

The dataset has <!--rinline dim(dfCitationsAttributes)[1] --> rows and <!--rinline dim(dfCitationsAttributes)[2] -->  columns.  


<!--rinline table(dfCitationsAttributes$nCitedBy) --> 

Histogram of citations

<!--begin.rcode
qplot(nCitedBy, data=dfCitationsAttributes, log="y")
end.rcode-->

<!--begin.rcode 
summary(dfCitationsAttributes$nCitedBy)
dim(dfCitationsAttributes)
with(dfCitationsAttributes, summary(nCitedBy))
end.rcode-->

Fit

<!--begin.rcode 

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
print(calcCI.exp(fit, "factor(dataset.in.geo.or.ae).L"))   

end.rcode-->


