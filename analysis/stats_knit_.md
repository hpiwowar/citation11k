<!--roptions dev='png', fig.width=7, fig.height=7, tidy=FALSE, cache=FALSE, echo=TRUE, message=FALSE, warning=FALSE, autodep=TRUE, cache.path='/tmp/knitr-cache/' -->

<!--begin.rcode setup, echo=FALSE, cache=FALSE

# use imgur for hosting figures
# go to static/my_imgur_api_key.txt and add your own api key

upload_images = TRUE

if (upload_images) {
   #opts_knit$set(upload.fun = imgur_upload)
   opts_knit$set(upload.fun = function (file){
      sprintf("http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/%s", file)    
    })
} else {
    opts_chunk$set(fig.path='figure/')
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

# knitr citation11k manuscript
 * author of this file: Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Yihui Xie for knitr and Carl Boettiger for his clear examples of this literate programming framework. 
 * Generated on <!--rinline date() -->

To execute the R code in this file and embed the results in the text, I start R, set the working directory, then run the following:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line, to generate an html file:

    R -e "library(knitr); knit('stats_knit_.md')"; pandoc --toc -r markdown -w html -H static/header.html stats.md > stats.html

The stats.html file can be viewed directly in a browser.
The images are stored in my Public Dropbox folder.

After pushing the .md files to GitHub, the stats.md file can also be viewed at [https://github.com/hpiwowar/citation11k/blob/master/analysis/stats.md](https://github.com/hpiwowar/citation11k/blob/master/analysis/stats.md) .

To extract the R code in a separate .R file called stats_knit_.R, run knit with tangle set to TRUE:

    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"

<!--begin.rcode workspace, messages=FALSE, echo=FALSE
# Clear the workspace and load package dependencies: 
rm(list=ls())   
require(ggplot2, quietly=T)
require(gplots, quietly=T)
require(reshape2, quietly=T)
require(plyr, quietly=T)
require(rms, quietly=T)
require(polycor, quietly=T)
require(ascii, quietly=T)
require(knitcitations)
cleanbib()
# to get knitcitations:
#library(devtools)

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

<!--begin.rcode calcCI, echo=FALSE

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
end.rcode-->

<!--begin.rcode colours, echo=FALSE
#colourblind friendly palettes from http://wiki.stdout.org/rcookbook/Graphs/Colors%20(ggplot2)
cbgRaw = c("#E69F00", "#56B4E9", "#009E73", "#999999", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cbgFillPalette <- scale_fill_manual(values=cbgRaw)
cbgColourPalette <- scale_colour_manual(values=cbgRaw)
cbgColorPalette = cbgColourPalette

end.rcode-->


# Data Reuse and the Open Data Citation Advantage
*Piwowar, Carlson, Vision*


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there supporting evidence that additional citations are due to data reuse?
1. What is the timeline of data reuse?

## Abstract

See the [end of this document](#abstract-1) (at the end so it can pull in results from the R analysis).

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection." [Piwowar, 2007]

Making research data publicly available also has costs. Data archives must be created and maintained. Data must be documented, formatted, and uploaded. Data-collecting investigators may be asked to answer questions when others try to use their data.

Scientists report that receiving more citations would be an important motivator for publicly archiving their data [Tenopir].

Several studies across several disciplines have found an association between data availability and number of citations recieved by a publication [cite studies below]. This evidence has been <a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">frequently referenced</a>, including in new policies that encourage and require data archiving [<a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">http://datadryad.org/jdap</a>]. It is important, therefore, to continue to strive for an accurate estimate of possible citation benefit.

The present study hopes to improve previous estimates in several ways. First, the present study is large enough to include many key covariates that may have conflated estimates of citation boost in previous, smaller studies: Number of authors, author publication experience, institution, open access availability, and subject area. Second, the current analysis estimates how citation boost levels may change over time. Third, the current analysis includes evidence on patterns of data reuse.


## Methods


###Relationship between data availability and citation

####Data collection

<!--begin.rcode dfAttributes, echo=FALSE
dfAttributes = read.csv("data/PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)
end.rcode-->

The primary analysis in this paper examines the citation count of a gene expression microarray experiment, relative to availability of the experiment's data.

The sample of microarray experiments used in the current analysis was previously determined (Piwowar 2011 PLoS ONE, data from Piwowar 2011 Dryad).  Briefly, a full-text query uncovered papers with wet-lab methods related to gene expression microarray data collection.  The full-text query was characterized with high precision (90%, 95% confidence interval 86% to 93%) and a moderate recall (56%, 52% to 61%) for this task.  Running the query in PubMed Central, HighWire Press, and Google Scholar identified <!--rinline dim(dfAttributes)[1] --> distinct gene expression microarray papers.  The papers were published between 2000 and 2009.

The independent variable of interest is the availability of gene expression microarray data.  Data availability had been previously determined for our sample articles in Piwowar 2011, so we directly reused that dataset [Piwowar Dryad 2011].  Datasets were considered available if they were discovered in either of the two predominant gene expression microarray databases: NCBI's Gene Expression Omnibus (GEO), and EBI's ArrayExpress.

"An earlier evaluation found that querying GEO and ArrayExpress with article PubMed identifiers located a representative 77% of all associated publicly available datasets [Piwowar 2010]. [We] used the same method for finding datasets associated with published articles in this study: [we] queried GEO for links to the PubMed identifiers in the analysis sample using the “pubmed_gds [filter]” and queried ArrayExpress by searching for each PubMed identifier in a downloaded copy of the ArrayExpress database. Articles linked from a dataset in either of these two centralized repositories were considered to have [publicly available data] for the endpoint of this study, and those without such a link were considered not to have [available] data." [Piwowar 2011]

Piwowar 2011 included 124 attributes for each of the gene expression microarray studies in our sample.  We used a subset of these --attributes previously shown or suspected to correlate with citation rate:

<!--begin.rcode correlation_variables, warning=FALSE, echo=FALSE
correlation_variables_string = "dataset.in.geo.or.ae
nCitedBy.log
pubmed.date.in.pubmed
pubmed.year.published
pubmed.is.bacteria
pubmed.is.plants
pubmed.is.humans
pubmed.is.cultured.cells
pubmed.is.animals
pubmed.is.cancer
pubmed.is.geo.reuse
journal.impact.factor.tr
journal.microarray.creating.count.tr
journal.num.articles.2008.tr
pubmed.is.core.clinical.journal
pubmed.is.open.access
institution.rank
institution.mean.norm.citation.score
institution.is.govnt
institution.nci
institution.stanford
institution.harvard
pubmed.is.funded.nih.intramural
pubmed.is.funded.nih
num.grants.via.nih.tr
nih.cumulative.years.tr
nih.sum.avg.dollars.tr
has.R.funding
num.authors.tr
last.author.num.prev.microarray.creations.tr
last.author.num.prev.pmc.cites.tr
last.author.female
last.author.num.prev.pubs.tr
last.author.year.first.pub.ago.tr
first.author.num.prev.microarray.creations.tr
first.author.num.prev.pmc.cites.tr
first.author.female
first.author.num.prev.pubs.tr
first.author.year.first.pub.ago.tr
country.usa
country.uk
country.japan
country.china
country.korea
country.canada
country.australia"
correlation_variables = strsplit(correlation_variables_string, "\n")[[1]]

end.rcode-->

* date of publication
* journal
* journal impact factor (2008)
* journal open access status
* size of the journal
* number of authors
* years since first publication by the first and last author
* number of papers published by first and last author
* number of PubMed Central citations received by first and last author
* country of corresponding author
* institution of corresponding author
* institution rank and citation score
* study topic (human/animal/plant study, cancer/not cancer)
* NIH funding of the study, if applicable


This study required citation counts for thousands of articles, based on  PubMed ID. At the time of data collection, neither Thomson Reuter's Web of Science nor Google Scholar supported looking up number of citations by PubMed ID. This type of query was (and is) supported by Elsevier's Scopus citation database. Alas, none of our affiliated institutions subscribed to Scopus. Scopus does not offer individual subscriptions. A personal email to a Scopus Product Manager went unanswered.

One author (HAP) attempted to use the British Library's walk-in access of Scopus on its Reading Room computers during a trip overseas. Unfortunately, the British Library did not permit any method of electronic transfer of our PubMed identifier list onto the Reading Room computers, including internet document access, transferring a text file from a USB drive, or using the help desk as an intermediary (see related policies at http://www.bl.uk/reshelp/inrrooms/stp/cond/conditions.html). The Library was not willing to permit an exception in this case, and we were unwilling to manually type ten thousand PubMed identifiers into the Scopus search box in the Reading Room.
HAP eventually obtained Scopus access through a Research Worker agreement with Canada's National Research Library (NRC-CISTI), after being fingerprinted to obtain a police clearance certificate.

Although Scopus now has an API that would facilitate easy programmatic access to citation counts, at the time of data collection the authors were not aware of any way to retrieve Scopus data through researcher-developed computer programs.  We queried and exported Scopus citation data manually through interaction with the Scopus website. The Scopus website had a limit to the length of query and the number of citations that could be exported at once. To work within these restrictions we concatenated up to 500 PubMed IDs at a time into 22 queries, where each query took the form "PMID(1234) OR PMID(5678) OR ..."

<!--begin.rcode dfCitations, echo=FALSE

# Read in citations
dfCitations = read.csv("data/scopus_all.csv", header=TRUE, stringsAsFactors=F)

# Merge with attributes
dfCitationsAttributesRaw = merge(dfAttributes, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Keep those published after 2000 and before 2010
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published > 2000)
dfCitationsAttributesRaw = subset(dfCitationsAttributesRaw, dfCitationsAttributesRaw$pubmed_year_published < 2010)

# Turn citations read in to numbers; zeros were represented as blanks
dfCitationsAttributesRaw$nCitedBy = as.numeric(dfCitationsAttributesRaw$Cited.by)
dfCitationsAttributesRaw[which(is.na(dfCitationsAttributesRaw$nCitedBy)),]$nCitedBy=0

end.rcode-->

Citation counts for <!--rinline dim(dfCitationsAttributesRaw)[1] --> papers were exported from Scopus in November 2011. 


####Primary analysis

The analysis included several multivariate linear regressions to evaluate the association between the public availability of a study's microarray data and the number of citations (after log transformation) it received. 

We began with a simple correlations between number of citations and other variables, using Pearson correlations for numberic variables and polyserial correlations for binary and factor covariates.  We also calculated correlations between data availability and other variables to investigate collinearity. 

<!--begin.rcode preprocessing, warning=FALSE, echo=FALSE
# Preprocess attributes as per Piwowar 2011
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
options(scipen=8)
dfCitationsAttributes = merge(dfCitationsAttributes, dfCitationsAttributesRaw[,c("pmid", "pubmed_journal")], by="pmid", )
end.rcode-->

<!--begin.rcode univariate_correlations, warning=FALSE, echo=FALSE

myhetcorr = hetcor.modified(dfCitationsAttributes[,correlation_variables], use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycorr = myhetcorr$correlations
colnames(mycorr) = colnames(myhetcorr$correlations)    
rownames(mycorr) = rownames(myhetcorr$correlations)    

# Correlations with citation
correlations_with_citations = sort(mycorr[,"nCitedBy.log"], dec=T)

# Correlations with data availability
correlations_with_data_avail = sort(mycorr[,"dataset.in.geo.or.ae"], dec=T)

end.rcode-->

The main analysis was run across all papers in the sample with many  covariates known or found (in the correlation analysis above) to correlate with citation rate.  Covariates included the date of publication, the journal which published the study, the journal impact factor, the journal citation halflife, the number of articles published by the journal, the journal's open access policy, whether the journal is considered a core clinical journal by MEDLINE, the number of authors of the study, the country of the corresponding author, the citation score of the institution of the corresponding author, the publishing experience of the first and last author, and the subject of the study itself.  

Publishing experience was characterized by the number of years since the author's first paper in PubMed, the number of papers they have published, and the number of citations they have received in PubMed Central, estimated using Authority clusters as described in [Piwowar 2011].  The subject of the study was characterized by whether the paper was classified as cancer, animals, or plants.  For more information on study attributes see [Piwowar 2011].

Citation count was log transformed to be consistent with prior literature.  Other count variables square-root transformed.  Continuous variables were represented with 3-part spines in the regression, using the rcs function in the R rms library.

The independent variable of interest was represented as a 0 or 1 in the regression, describing whether or not associated data had been found in the data repositories.  The relationship of the data availability variable to  citation count was described with 95% confidence intervals after raising the regression coefficient to the power of e (since the log of the number of citations was used in the regression).

<!--begin.rcode regressionAll
fit_w_journal = lm(nCitedBy.log ~ 
          rcs(journal.impact.factor.tr, 3) +               
          rcs(pubmed.date.in.pubmed, 3) +
          rcs(journal.num.articles.2008.tr, 3) +           
          rcs(journal.cited.halflife, 3) +                 
          factor(pubmed.is.open.access) +              
          rcs(num.authors.tr, 3) + 
          rcs(first.author.num.prev.pubs.tr, 3) +           
          rcs(first.author.num.prev.pmc.cites.tr, 3) +     
          rcs(first.author.year.first.pub.ago.tr, 3) +     
          rcs(last.author.num.prev.pubs.tr, 3) +           
          rcs(last.author.num.prev.pmc.cites.tr, 3) +      
          rcs(last.author.year.first.pub.ago.tr, 3) +
          rcs(institution.mean.norm.citation.score, 3) +
          factor(country.usa) +              
          factor(country.china) +              
          factor(country.korea) +              
          factor(pubmed.is.cancer) +
          factor(pubmed.is.animals) +
          factor(pubmed.is.plants) +
          factor(pubmed.is.core.clinical.journal) +
          factor(pubmed_journal) +          
          factor(dataset.in.geo.or.ae)
           , dfCitationsAttributes)
end.rcode-->

Because publication date is such a strong correlate with both citation rate and data availability, we performed another analysis which stratified the sample by publication year, in addition to including publication date as a covariate.  Because the yearly regressions included fewer datapoints than the full regression, they supported a smaller number of covarites.  The yearly regressions included  date of publication, the journal which published the study, the journal impact factor, the journal's open access policy, the number of authors of the study, the citation score of the institution of the corresponding author, the previous number of PubMed Central citations recieved by the first and last author, whether the study was on cancer, and whether it used animals.

<!--begin.rcode regressionByYear

# has a few less covariates than full model
do_analysis = function(mydat) {
  myfit = lm(nCitedBy.log ~ 
      rcs(pubmed.date.in.pubmed, 3) +
      rcs(journal.impact.factor.tr, 3) + 
      rcs(journal.num.articles.2008.tr, 3) +           
      rcs(num.authors.tr, 3) + 
      rcs(first.author.num.prev.pmc.cites.tr, 3) +     
      rcs(last.author.num.prev.pmc.cites.tr, 3) +      
      rcs(institution.mean.norm.citation.score, 3) +
      factor(pubmed.is.cancer) +
      factor(pubmed.is.animals) +
      factor(dataset.in.geo.or.ae)
             , mydat)
  calcCI.exp(myfit, "factor(dataset.in.geo.or.ae).L")
}

estimates_by_year = data.frame()
for (year in seq(2001, 2009)) {
  dat.subset.year = subset(dfCitationsAttributes, pubmed.year.published==year)
  results = do_analysis(dat.subset.year)
  estimates_by_year = rbind(estimates_by_year, cbind(year=year, results))
}

end.rcode-->



####Validation for automated method of detecting data availability

Our method of identifying which articles create gene expression microarray data made a nontrivial number of errors: about 10% of the articles it identified as creating gene expression microarray data do not in fact create gene expression datasets [cite].

The papers that are erroniously included in our subset to not create gene expression data, so they certainly don''t have associated archived datasets: all  erroniously included papers were automatically classified in the "no archived data" group. 

If it were true that these erroniously-included articles recieved many more or many fewer citations than other articles in the group, their inclusion could influence the findings of this study.

<!--begin.rcode manualAnnotationCreatedData, echo=FALSE
dfAnnotations = read.csv("data/Mendeley_annotated_250_of_11k.csv", header=TRUE, stringsAsFactors=F)
# Get subset that has been annotated
dfAnnotationsAnnotated = subset(dfAnnotations, TAG.annotated == "11k-subset-reviewed")
# Merge together annotations with citation information
dfCitationsAnnotated = merge(dfAnnotationsAnnotated, dfCitations, by.x="pmid", by.y="PubMed.ID")

# Clean the data, get variables in useful formats
dfCitationsAnnotated$isCreated = factor(dfCitationsAnnotated$TAG.created)
dfCitationsAnnotated$nCitedBy = as.numeric(dfCitationsAnnotated$Cited.by)

dat.annotated.merged = merge(dfCitationsAnnotated, dfCitationsAttributes, by="pmid")
dat.annotated.merged.created = subset(dat.annotated.merged, isCreated==levels(isCreated)[1])
end.rcode-->

We took steps to verify our assumption that the influence of articles erroniously identified these mistakenly-included articles is in fact small.  We began by manually reviewed a random 226 of the 11k (get exact number) articles to identify those which we were assuming had created gene expression microarray data but in fact had not.

We compared the distribution of those with errors to those without, calculated whether they were statitically different, and ran a regression with the known-correct sample only.

<!--begin.rcode manualAnnotationCreatedStats
ttest_citedby = with(dfCitationsAnnotated, t.test(nCitedBy~isCreated))
ttest_log_citedby = with(dfCitationsAnnotated, t.test(log(1+nCitedBy)~isCreated))
wilcox_citedby = with(dfCitationsAnnotated, wilcox.test(nCitedBy~isCreated))
end.rcode-->


<!--begin.rcode manualAnnotationCreatedRegression
annotated_merged_created = lm(nCitedBy.log ~ 
  rcs(pubmed.date.in.pubmed, 3) +
  rcs(journal.impact.factor.tr, 3) +               
  rcs(num.authors.tr, 3) + 
  rcs(last.author.num.prev.pmc.cites.tr, 3) +      
  factor(country.usa) +              
  factor(dataset.in.geo.or.ae)
             , dat.annotated.merged.created)
end.rcode-->

####Subset analysis to compare findings with Piwowar et al 2007

We ran two modified analyses to attempt to reproduce the findings of [Piwowar 2007].  First, we used a subset with roughly the same inclusion criteria as Piwowar 2007 -- studies on cancer, with humans, published prior to 2003 -- and the same regression coefficients: publication date, impact factor, and whether the corresponding author's address is in the USA.

<!--begin.rcode RegressionAlaPrevStudy
  dat.subset.previous.study = subset(dfCitationsAttributes, (pubmed.year.published<2003) & (pubmed.is.cancer==1) & (pubmed.is.humans==1))

  myfitprev = lm(nCitedBy.log ~ 
      rcs(pubmed.date.in.pubmed, 3) +
      rcs(journal.impact.factor.tr, 3) +               
      factor(country.usa) +              
      factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)
end.rcode-->

We followed that with a second regression that included several additional important covariates:  number of authors and number of previous citations by the last author.

<!--begin.rcode RegressionAlaPrevStudyMoreCovariates
  myfit_prev_more = lm(nCitedBy.log ~ 
      rcs(pubmed.date.in.pubmed, 3) +
      rcs(journal.impact.factor.tr, 3) +               
      rcs(num.authors.tr, 3) + 
      rcs(last.author.num.prev.pmc.cites.tr, 3) +      
      factor(country.usa) +              
      factor(dataset.in.geo.or.ae)
             , dat.subset.previous.study)
end.rcode-->

####Manual review of citation context

We manually reviewed the citation context of some of these papers to determine how many of the citations were in the context of data reuse.

We randomly selected 100 datasets deposited in GEO in 2005.  For each dataset, we located the data collection article within ISI Web of Science based on its title and authors, and exported the list of all articles that cited this data collection article. This list of all citations was processed to subselect  50 random  citations, stratified by  the totalnumber of times the data collection article had been cited.  

Manual review was performed for each instance of potential data reuse.  We located the article full text, read the relevant sections of the papers, and manually determined if the data from the associated dataset had been reused within the study.  [Beginning to Track]

<!--begin.rcode citationContextData, echo=FALSE
dfTracking1k = read.csv("data/tracking1k_20111008.csv", sep=",", header=TRUE, stringsAsFactors=F)
dfTracking1k.GEO.subset = subset(dfTracking1k, TAG.source=="WoS" & TAG.confidence!="low confidence" & is.na(duplicates & TAG.repository=="GEO" & (TAG.dataset.reused=="dataset reused" | TAG.dataset.reused=="dataset not reused")))

num.GEO.total = dim(dfTracking1k.GEO.subset)[1]
num.GEO.reused = dim(subset(dfTracking1k.GEO.subset, TAG.dataset.reused=="dataset reused"))[1]
annotated.prop = binconf(num.GEO.reused, num.GEO.total)
end.rcode-->

###Data reuse patterns from accession number attribution

####Data collection

We collected a separate dataset to study reuse patterns because identifying data reuse from citations requires time-consuming classification of citation context.

Datasets are sometimes attributed directly, through mention of the dataset identifier or accession number in the full-text of a research paper.  Third-party dataset resuse can be estimated from these mentions by excluding papers that were authored by members of the dataset collection team.

We used the NCBI eUtils library and custom Python code to obtain a list of all datasets deposited into the Gene Expression Omnibus data repository, then searched PubMed Central for each of these dataset identifiers (using queries of the form "'GSEnnnn' OR 'GSE nnnn'"). For each hit we recorded the PubMed Central ID of the paper that mentioned the accession number, the year of paper publication, and the author surnames.  We also recorded the dataset accession number, the year of dataset publication, and the investigator names associated with the dataset record.

####Statistical analysis

We excluded papers with author surnames in common with those authors who deposited the original dataset, as described in [Beginning to Track.]  

PubMed Central contains only a subset of papers recorded in PubMed. As described in [Beginning to Track.], to extrapolate from the number of data reuses in PubMed Central to all possible data reuses in PubMed, we divided the yearly number of hits by the ratio of papers in PMC to papers in PubMed for this domain (domain was measured as the number of articles indexed with the MeSH term “gene expression profiling”).  

<!--begin.rcode accessionRatios, echo=FALSE

dfPubmedPmcRatios = read.csv("data/pubmed_pmc_ratios.csv", header=TRUE, stringsAsFactors=F)

# get a more exact ratio
dfPubmedPmcRatios$pmc_pmid_ratio = dfPubmedPmcRatios$num_pmc/dfPubmedPmcRatios$num_pubmed
dfPubmedPmcRatios$year = as.numeric(dfPubmedPmcRatios$year)

cbind(with(dfPubmedPmcRatios, paste(year, ": ", round(pmc_pmid_ratio*100, 0), "%", sep="")))
end.rcode-->

We retained reuse candidates for papers published between 2001 and 2010: 2011 was within 12 months of data collection, and had a dramatically lower proportion of papers in PubMed Central because the NIH archiving requirements permit a 12 month embargo.

To understand our findings on a per-dataset basis, we stratified reuse estimates by year of dataset submission and normalized our reuse findings by the number of datasets deposited that year:

<!--begin.rcode dfPubmedGseCount, echo=FALSE

dfPubmedGseCount = read.csv("data/pubmed_gse_count.csv", header=TRUE, stringsAsFactors=F)

dfPubmedGseCount[2:10,]
end.rcode-->

<!--begin.rcode dfMentions, echo=FALSE

header_string = "accession,gse,gds,submit_pmids,reuse_pmcid,reuse_pmids_for_pmc,this_submit_authors,this_reuse_authors,intersect,submit_affiliation,release_date,sep1,bioloink_filter,basic_reuse_filter,creation_filter,oa_excerpts,word_filters,sep2,reuse_affiliation,journal,year,date_published,medline_status,is_geo_reuse,reuse_is_oa,metaanal,mesh_filters,blank,setname"
header = strsplit(header_string, ",")[[1]]

# cat records_20*.csv > all_records.csv
dfMentions = read.csv("data/all_records.csv", header=FALSE, stringsAsFactors=F)
names(dfMentions) = header

dfMentions$noAuthorOverlap = ((dfMentions$intersect) == "[]")
dfMentions$thirdPartyReuse = dfMentions$noAuthorOverlap
dfMentions$dataSubmissionYear = as.numeric(substr(dfMentions$setname, 10, 13))
dfMentions$paperPublishedYear = dfMentions$year
dfMentions$elapsedYears = dfMentions$paperPublishedYear  - dfMentions$dataSubmissionYear 
dfMentions = subset(dfMentions, select=c(thirdPartyReuse, dataSubmissionYear, paperPublishedYear, elapsedYears, gse, reuse_pmcid))

dfMentions = merge(dfMentions, dfPubmedPmcRatios[,c("pmc_pmid_ratio", "year")], by.x="paperPublishedYear", by.y="year", )
dfMentions = merge(dfMentions, dfPubmedGseCount, by.x="dataSubmissionYear", by.y="year", )

# has to be long enough ago that papers are in PMC
dfMentions = subset(dfMentions, paperPublishedYear < 2011)

end.rcode-->

<!--begin.rcode dfMentions_calcs, echo=FALSE

df.long.summary.byyear.extrap = ddply(dfMentions, .(elapsedYears, thirdPartyReuse, dataSubmissionYear, pmc_pmid_ratio), summarise, count=length(elapsedYears))
df.long.summary.byyear.extrap$extrap = df.long.summary.byyear.extrap$count / df.long.summary.byyear.extrap$pmc_pmid_ratio
df.long.summary.byyear.extrap = merge(df.long.summary.byyear.extrap, dfPubmedGseCount, by.x="dataSubmissionYear", by.y="year")

df.long.summary.reuse.only = subset(df.long.summary.byyear.extrap, thirdPartyReuse==TRUE)

df.byyear.reuse.only = ddply(df.long.summary.reuse.only, c("dataSubmissionYear", "elapsedYears"), summarise, total = sum(extrap))
df.byyear.reuse.only = merge(df.byyear.reuse.only, dfPubmedGseCount, by.x="dataSubmissionYear", by.y="year")

df.cumulative.reuse.only = ddply(df.byyear.reuse.only[with(df.byyear.reuse.only, order(elapsedYears)),], c("dataSubmissionYear"), transform, NT = cumsum(total))

end.rcode-->

### Data and script availability

Statistical analyses were last run on <!--rinline date() --> with <!--rinline version$version.string -->.  Packages used include reshape2<!--rinline citep(list(citation("reshape2"))) -->, plyr<!--rinline citep(list(citation("plyr"))) -->, rms<!--rinline citep(list(citation("rms"))) -->, polycor<!--rinline citep(list(citation("polycor"))) -->, ascii<!--rinline citep(list(citation("ascii"))) -->, ggplot2<!--rinline citep(list(citation("ggplot2"))) -->, gplots<!--rinline citep(list(citation("gplots"))) -->, knitr<!--rinline citep(list(citation("knitr"))) -->, and knitcitations<!--rinline citep(list(citation("knitcitations"))) -->. P-values are two-tailed.  

Raw data and statistical scripts are available in the Dryad data repository at [url and citation to be determined and included upon article acceptance].  Data collection scripts are at [GitHub pypub.  Heather, push changes!]

The text Markdown version of this manuscript with interleaved statistical scripts using knitr <!--rinline citep(list(citation("knitr"))) --> is also included in Dryad and at GitHub (https://github.com/hpiwowar/citation11k)[https://github.com/hpiwowar/citation11k].

## Results

### Relationship between data availability and citation

#### Description of cohort

We retained <!--rinline dim(dfCitationsAttributes)[1] --> articles published between 2001 and 2009 that had been identified as collecting gene expression microarray data.

<!--begin.rcode sorted_journals, echo=FALSE
sorted_journals = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:12]
end.rcode-->

The composition of this sample is spread across <!--rinline length(table(dfCitationsAttributesRaw$pubmed_journal)) --> journals, with the top 12 journals accounting for <!--rinline 100*round(sum(sorted_journals), 2-->% of the papers.

<!--begin.rcode journalTable, echo=FALSE
gfm_table(cbind(names(sorted_journals), round(sorted_journals, 2)))
prop2001 = 100*round(nrow(subset(dfCitationsAttributesRaw, pubmed_year_published=="2001"))/nrow(dfCitationsAttributesRaw)[1], 2)
prop2009 = 100*round(nrow(subset(dfCitationsAttributesRaw, pubmed_year_published=="2009"))/nrow(dfCitationsAttributesRaw)[1], 2)
end.rcode-->

Collecting gene expression micorarray data became more popular over time: <!--rinline prop2001-->% of articles in our sample were published in 2001, compared to <!--rinline prop2009--> % in 2009.

<!--begin.rcode yearTable, echo=FALSE
gfm_table(table(dfCitationsAttributesRaw$pubmed_year_published)/nrow(dfCitationsAttributesRaw))
end.rcode-->

Searching for associated datasets in the GEO and ArrayExpress repository uncovered links between <!--rinline summary(dfCitationsAttributes$dataset.in.geo.or.ae.int)["Mean"]-->% of papers in this sample and publicly available data.  

<!--begin.rcode sharing, fig.width=6, fig.height=6
table(dfCitationsAttributes$dataset.in.geo.or.ae.int)

gfm_table(table(dfCitationsAttributes$dataset.in.geo.or.ae.int)/nrow(dfCitationsAttributes))

end.rcode-->


Articles published more recently were more likely to have associated datasets.

<!--begin.rcode sharing_over_time, fig.width=6, fig.height=6, cache=FALSE, echo=FALSE

library(ggplot2)

df.long = melt(dfCitationsAttributes, measure.vars=c('pubmed.year.published'))
df.long.summary = ddply(df.long, .(variable, value), summarise, proportion=sum(dataset.in.geo.or.ae.int > 0) / length(dataset.in.geo.or.ae.int))

ggplot(data=df.long.summary, aes(x=value, y=proportion)) +
  geom_smooth() +
  #facet_wrap(~variable) +
  scale_y_continuous(name="proportion with available data\n", formatter='percent') + 
  scale_x_continuous(name="", breaks=seq(2001,2009), labels=seq(2001,2009)) +
  theme_bw(base_size=16)

end.rcode-->

The articles in our sample were cited between <!--rinline min(dfCitationsAttributes$nCitedBy)--> and <!--rinline max(dfCitationsAttributes$nCitedBy)--> times, with an average of <!--rinline mean(dfCitationsAttributes$nCitedBy)--> citations per paper and a median of <!--rinline median(dfCitationsAttributes$nCitedBy)-->.  

<!--begin.rcode sharingVCitations
summary(dfCitationsAttributes$nCitedBy)
end.rcode-->

Without accounting for any confounding factors, the mean number of citations between papers with available data and those without are the same, and there is little visible difference in the distribution of citations between these two groups.

<!--begin.rcode sharingVCitations_breakdown
with(dfCitationsAttributes, tapply(nCitedBy, dataset.in.geo.or.ae.int, summary))
end.rcode-->

<!--begin.rcode sharingVCitations_graph, echo=FALSE
citation_breaks = c(0, 10, 100, 1000, 3000)
ggplot(dfCitationsAttributesRaw, aes(1+nCitedBy, fill=factor(in_ae_or_geo))) + geom_density(alpha=0.2) + 
scale_fill_manual(name="",
                    breaks=c("0", "1"),
                    labels=c("data NOT available", "data available"), 
                    values=cbgRaw) + 
scale_x_log10(name="\nnumber of citations", breaks=citation_breaks+1, labels=citation_breaks) + 
#cbgFillPalette + 
cbgColourPalette + theme_bw(base_size=16)
end.rcode-->


The number of citations a paper has recieved is strongly correlated to the date it was published: older papers have had more time to accumulate citations.  Because data archiving was relatively infrequent for articles published earlier, a difference in citation behaviour may be confounded with publication date.

Indeed, we saw that for any given publication date, papers with associated data recieve more citations than those without.

<!--begin.rcode citationsByYearBySharing, echo=FALSE

median_citations_by_year = cbind(
dataset_not_available = with(subset(dfCitationsAttributes, dataset.in.geo.or.ae==0), tapply(nCitedBy, pubmed.year.published, median, na.rm=T))
,
dataset_available = with(subset(dfCitationsAttributes, dataset.in.geo.or.ae==1), tapply(nCitedBy, pubmed.year.published, median, na.rm=T))
)
round(median_citations_by_year, 0)

end.rcode-->
    
This difference in citation is not driven by outliers: as shown by the distribution of citations over time, the distribution of citations for older papers with available data is centered at a higher median than citations for papers without data available.

<!--begin.rcode citationDist, echo=FALSE 

ggplot(dfCitationsAttributes, aes(1+nCitedBy, fill=factor(dataset.in.geo.or.ae)), color="black") + 
geom_density(alpha=0.2) + 
scale_fill_manual(name="",
                    breaks=c("0", "1"),
                    labels=c("data NOT available", "data available"), 
                    values=cbgRaw) + 
facet_grid(pubmed.year.published~.) + 
scale_y_continuous(breaks=c(0, 0.5), labels=c(0, 0.5)) + 
scale_x_log10(name="\nnumber of citations", breaks=citation_breaks+1, labels=citation_breaks) + 
#cbgFillPalette + 
cbgColourPalette + theme_bw(base_size=16)

end.rcode-->

#### Correlations

Other factors have been previously shown to be correlated with citation rate, including number of authors, author experience, author institution, open access status, and subject area [cite]. 

Cited by correlations.  It must be remembered that these are univariate correlations and so should not be interpreted without additional context.  For example, most open access publications were published recently, so relative to non-open access publications in this sample they have had less time to accumulate citations.

<!--begin.rcode display_correlations_with_citations, warning=FALSE, echo=FALSE
gfm_table(cbind(names(correlations_with_citations), round(correlations_with_citations, 2)))
end.rcode-->

Data availability correlations:

<!--begin.rcode univariate_dataavail, warning=FALSE, echo=FALSE
gfm_table(cbind(names(correlations_with_data_avail), round(correlations_with_data_avail, 2)))
end.rcode-->

#### Multivariate regression
 
Multivariate regression analysis can be useful to identify the relationship between data availability and citation rate, independently of other variables.


<!--begin.rcode display_regressionAll, echo=FALSE

gfm_table(anova(fit_w_journal))
citation.boost.coefs.journal = calcCI.exp(fit_w_journal, "factor(dataset.in.geo.or.ae).L")
print(citation.boost.coefs.journal)

end.rcode-->

In this analysis, we found many of the variables were independently associated with citation rate, including number of authors, journal impact factor, the journal itself, the date of publication, the number of previous citations of the fist and last author, the number of previous publications of the last author, whether the paper was about animals or plants, and whether the data was made publicly available.

Estimate of the independent increase of citations due to data availability is  
<!--rinline 100*(citation.boost.coefs.journal$est-1) -->%
with 95% confidence intervals [<!--rinline 100*(citation.boost.coefs.journal$ciLow-1) -->%
, <!--rinline 100*(citation.boost.coefs.journal$ciHigh-1) -->% ]
(p=<!--rinline format(citation.boost.coefs.journal$p, nsmall = 2) -->)

Because publication date is such as strong correlate with both citation rate and data availability, we also ran regressions for each publication year individually (with a subset of the covariates).

The estimate of citation boost was different for different years of publication.

The estimates of citation boost for papers published in each year, with 95% confidence intervals:

<!--begin.rcode regressionEstimatesByYear
estimates_by_year
end.rcode-->

<!--begin.rcode display_regressionEstimatesByYear, echo=FALSE

ggplot(estimates_by_year, aes(x=year, y=est)) + geom_line() + 
  geom_errorbar(width=.1, aes(ymin=ciLow, ymax=ciHigh)) +
  scale_x_continuous(name="", breaks=seq(2001, 2009)) +
  scale_y_continuous(name='coefficient ratio\n', limits=c(0, 2.5)) + 
  theme_bw(base_size=16) +
  geom_hline(color="grey50", linetype="dashed", aes(yintercept=1))

end.rcode-->

###Validation for automated method of detecting data availability

Our method of identifying which articles create gene expression microarray data made a nontrivial number of errors: about 10% of the articles it identified as creating gene expression microarray data do not in fact create gene expression datasets [cite].

The papers that are erroniously included in our subset to not create gene expression data, so they certainly don''t have associated archived datasets: all  erroniously included papers were automatically classified in the "no archived data" group. 

If it were true that these erroniously-included articles recieved many more or many fewer citations than other articles in the group, their inclusion could influence the findings of this study.

To verify our assumption that the influence of these mistakenly-included articles is in fact small, we manually reviewed a random 226 of the 11k (get exact number) articles.

Of these manually reviewed articles, 206 did indeed create gene expression microarray data, and 20 did not (but satisfied the boolean-search query for other reasons).  

<!--begin.rcode percent
206/226
end.rcode-->

Examining the citations of the  20 articles that did not create gene expression data revealed that these studies were cited less often than those that did create data: a mean of 26 citations compared to a mean of 32 citations.  The overall distribution of citations for articles that did not create gene expression data is closer to zero than the distribution of citations for articles that did create gene expression data.

<!--begin.rcode manualAnnotationCreatedCitations
with(dfCitationsAnnotated, summary(nCitedBy~isCreated))
end.rcode-->


<!--begin.rcode display_manualAnnotationCreatedCitations, echo=FALSE, eval=FALSE
ggplot(dfCitationsAnnotated, aes(1+nCitedBy, fill=factor(isCreated))) + geom_density(alpha=0.2) + 
scale_fill_manual(name="",
                    values=cbgRaw, 
                    breaks=c("created-microarray-data", "created-microarray-data-not"),
                    labels=c("did collect microarray data", "did NOT collect microarray data")) + 
scale_x_log10(name="\nnumber of citations", breaks=citation_breaks+1, labels=citation_breaks) + 
#cbgFillPalette + 
cbgColourPalette + theme_bw(base_size=16)
end.rcode-->

This difference, however, was found to be not statisitically significantly different at the p<0.05 level, using either a t-test on the log of the citation counts or a Wilcoxon rank sum test on the raw citation counts.

<!--begin.rcode display_manualAnnotationCreatedStats
print(ttest_citedby)
print(ttest_log_citedby)
print(wilcox_citedby)
end.rcode-->

To confirm that the erroniously-included articles were not driving the findings about the citation relationship with data availability, we ran a multivariate regression analysis on the subsample of 206 articles that we manually determined did in fact generate gene expression microarray data.  The estimated effect is statistically significant and similar to the findings from the whole sample.

<!--begin.rcode display_manualAnnotationCreatedRegression
gfm_table(anova(annotated_merged_created))
calcCI.exp(annotated_merged_created, "factor(dataset.in.geo.or.ae).L")
end.rcode-->

### Subset analysis to compare findings with Piwowar et al 2007

These estimates of citation boost found in the multivariate regression were different from those found by (Piwowar et al 2007), even though both studies looked at publicly available gene expression microarray data. There are several possible reasons for this difference.  

First, Piwowar et al 2007 included only data from human cancer microarray trials published between 1999 and 2003 <check>, whereas the current study uses all gene expression microarray data studies in PubMed from 2001 through 2009. 

Second, because the Piwowar et al 2007 sample was small, the previous analysis included only a few possible covariates: publication date, journal impact factor, and country of the corresponding author.

We attempted to reproduce that environment in the current study to see if we would find more comperable results.

Limiting the current sample to datasets with MeSH terms "human" and "cancer" published from 2001 to 2003 retained 308 papers.  Running this subsample with  covariates from the Piwowar 2007 paper found a comperable estimate to the 2007 paper: a citation increase of 47% (95% confidence intervals of 6% to 103%).

<!--begin.rcode display_RegressionAlaPrevStudy
  gfm_table(anova(myfitprev))

  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")
end.rcode-->

How is did this estimate change when we included additional covariates?  The subsample of 308 papers was large enough to include a few additional covariates:  number of authors and citation history of the last author.  Including these covariates returned  a smaller estimated effect: 18% with a confidence interval that spanned a *loss* of 17% citations to a boost of 66%.  This range is too wide to be instructive, other than to note its top end is close to the previous rough estimates.

<!--begin.rcode display_RegressionAlaPrevStudyMoreCovariates

  gfm_table(anova(myfit_prev_more))

  calcCI.exp(myfit_prev_more, "factor(dataset.in.geo.or.ae).L")
end.rcode-->



### Manual review of citation context

To provide evidence on the proportion of the citation boost that may be caused by data reuse, we report the observed frequency with which papers that shared gene expression microarray data were cited in the context of data attribution.  Citations to papers that describe 100 datasets deposited into GEO in 2005 were collected using Web of Science.  A sample of 138 citations were randomly selected and manually reviewed.  

Of the <!--rinline num.GEO.total --> reviewed citations to articles with archived gene expression data, <!--rinline num.GEO.reused --> were in the context of data reuse
<!--rinline 100*(round(annotated.prop[1], 2)) -->%
with 95% confidence intervals [<!--rinline 100*(round(annotated.prop[2], 2)) -->%
, <!--rinline 100*(round(annotated.prop[3], 2)) -->% ]


### Data reuse patterns from accession number attribution


Finally, to provide evidence on the timeline of data attribution, we report  data reuse activity attributed through direct dataset mentions.

Author surnames in common with data publication team vs third party.  One panel per year, with data deposited that year.

<!--begin.rcode display_authorVThirdParty, echo=FALSE
ggplot(df.long.summary.byyear.extrap, aes(x=elapsedYears, y=extrap, color=thirdPartyReuse)) + geom_line() + 
scale_x_continuous(name="\nyears since data publication", limits=c(0, 8)) +
scale_y_continuous(name="Number of papers\n", formatter="comma") +
facet_wrap(~dataSubmissionYear) +
scale_color_hue(name="",
                    breaks=c(FALSE, TRUE),
                    labels=c("orig authors", "third-party authors")) +
theme_bw(base_size=16)
end.rcode-->

Author vs third party, normalized by number of datasets deposited in the given year.  One panel per year, with data deposited that year, normalized by number of datasets published that year.

<!--begin.rcode display_authorVThirdParty_normalized, echo=FALSE
ggplot(data=subset(df.long.summary.byyear.extrap, (dataSubmissionYear>2002) & (dataSubmissionYear<2009)), aes(x=elapsedYears, y=extrap/num_gse_ids, color=thirdPartyReuse)) + 
geom_line() + 
scale_x_continuous(name="\nyears since data publication", limits=c(0, 8)) +
scale_y_continuous(name="Cumulative number of papers\nnormalized by number of datasets deposited in given year\n", formatter="comma") +
facet_wrap(~dataSubmissionYear) +
scale_color_hue(name="Number of papers",
                    breaks=c(FALSE, TRUE),
                    labels=c("orig authors", "third-party authors")) +
theme_bw(base_size=16)
end.rcode-->

Third-party reuse for all data depositing years, overlayed

<!--begin.rcode display_accessionReuse, echo=FALSE
ggplot(data=subset(df.byyear.reuse.only, dataSubmissionYear>2000), aes(x=dataSubmissionYear+elapsedYears, y=total, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\npublication year of reuse paper", limits=c(2001, 2010)) +
scale_y_continuous(name="Number of papers\n", formatter="comma") +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=16)
end.rcode-->

Cumulative third-party reuse

<!--begin.rcode display_accessionReuse_cumulative, echo=FALSE
# cumulative
ggplot(data=subset(df.cumulative.reuse.only, dataSubmissionYear>2000), aes(x=dataSubmissionYear+elapsedYears, y=NT, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\npublication year of reuse paper", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative number of papers\n", formatter="comma") +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=16)
end.rcode-->

Cumulative third-party reuse, normalized by number of datasets deposited each year

<!--begin.rcode display_accessionReuse_cumulative_normalized, echo=FALSE
ggplot(data=subset(df.cumulative.reuse.only, dataSubmissionYear>2000), aes(x=dataSubmissionYear+elapsedYears, y=NT/num_gse_ids, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\npublication year of reuse paper", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative number of papers\nnormalized by number of datasets in given year\n", formatter="comma") +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=16)
end.rcode-->

Cumulative third-party reuse, normalized by number of datasets deposited each year, excluding datasets deposited in 2001 and 2002.


<!--begin.rcode display_accessionReuse_cumulative_normalized_2003, echo=FALSE
ggplot(data=subset(df.cumulative.reuse.only, dataSubmissionYear>2002), aes(x=dataSubmissionYear+elapsedYears, y=NT/num_gse_ids, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\npublication year of reuse paper", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative number of papers\nnormalized by number of datasets in given year\n", formatter="comma") +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=16)
end.rcode-->

Cumulative third-party reuse, normalized by number of datasets deposited each year, excluding datasets deposited in 2001 and 2002, plotted as elapsed years since data publication.

<!--begin.rcode display_accessionReuse_cumulative_normalized_2003_elapsed, echo=FALSE
ggplot(data=subset(df.cumulative.reuse.only, dataSubmissionYear>2002), aes(x=elapsedYears, y=NT/num_gse_ids, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\nyears since data publication", limits=c(0, 8)) +
scale_y_continuous(name="Cumulative number of papers\nnormalized by number of datasets deposited in given year\n", formatter="comma") +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=16)
end.rcode-->

Is the number of reuse papers growing over time?  How does it compare with the availablility of datasets?

<!--begin.rcode growthOfReusePapers, echo=FALSE
dfCountUnique3rdpartyPapers = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(paperPublishedYear, pmc_pmid_ratio), summarise, count=length(unique(reuse_pmcid)))

dfCountUnique3rdpartyPapers$extrap = with(dfCountUnique3rdpartyPapers, count/pmc_pmid_ratio)

dfCountUnique3rdpartyPapers = ddply(dfCountUnique3rdpartyPapers, .(), transform, cumul_extrap=cumsum(extrap))

dfCountUnique3rdpartyPapers = merge(dfCountUnique3rdpartyPapers, dfPubmedGseCount, by.x="paperPublishedYear", by.y="year")

dfCountUnique3rdpartyPapers = ddply(dfCountUnique3rdpartyPapers, .(), transform, cumul_gse=cumsum(num_gse_ids))

#not log
ggplot(data=dfCountUnique3rdpartyPapers, aes(x=paperPublishedYear, y=cumul_gse)) + geom_point() + geom_line(aes(color="datasets\n")) + 
scale_x_continuous(name="\nyear of data or paper publication", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative count\n", formatter="comma") +
scale_color_hue(name="") +
theme_bw(base_size=16) +
geom_line(aes(y=cumul_extrap, color="reuse papers,\nattribution by accession")) + geom_point(aes(y=cumul_extrap)) 

end.rcode-->

Both are growing exponentially now, at about the same rate.

<!--begin.rcode growthOfReusePapersLog, echo=FALSE

# log
breaks=c(1, 10, 100, 1000, 10000, 30000)
ggplot(data=dfCountUnique3rdpartyPapers, aes(x=paperPublishedYear, y=cumul_gse)) + geom_point() + geom_line(aes(color="datasets\n")) + 
scale_x_continuous(name="\nyear of data or paper publication", limits=c(2001, 2010)) +
scale_y_log(name="Cumulative count (log scale)\n", breaks=breaks, labels=breaks) +
scale_color_hue(name="") +
theme_bw(base_size=16) +
geom_line(aes(y=cumul_extrap, color="reuse papers,\nattribution by accession")) + geom_point(aes(y=cumul_extrap)) 
end.rcode-->



The number of datasets used in a reuse paper is increasing over time. One panel for every year of publication, with papers published that year.

<!--begin.rcode numberDatasetsInReusePaper, echo=FALSE

dfGsePerReusePaper = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(reuse_pmcid, paperPublishedYear), summarise, count=length(unique(gse)))

qtiles = seq(0,1,0.01)
breaks = c(0, 5, 10, 50, 100)

dfCountsOfGsePerReusePaper = ddply(dfGsePerReusePaper, .(count, paperPublishedYear), summarise, number_reuse_papers=length(unique(reuse_pmcid)))
q = ddply(dfGsePerReusePaper, "paperPublishedYear", summarise, quantile=qtiles, count=quantile(count, qtiles))
ggplot(data=subset(q, paperPublishedYear>2001), aes(x=count, y=quantile)) + geom_step(weight=3) + 
#    scale_x_log10(breaks=breaks, labels=breaks) +
    scale_x_continuous("\nnumber of datasets attributed in a reuse paper", breaks=seq(0, 30, 10), limits=c(0,30)) +
    scale_y_continuous(name="Cumulative probability\n") +
    theme_bw(base_size=16) + facet_wrap(~ paperPublishedYear)

end.rcode-->

Distribution of reuse across individual datasets.  One panel for every year of publication, with papers published that year.

<!--begin.rcode display_distAcrossDatasets, echo=FALSE
qtiles = seq(0,1,0.01)

dfCountReuseByGse = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(gse, dataSubmissionYear), summarise, count=length(elapsedYears))

for (year in seq(2001, 2009)) {
    num_with_reuse = sum(with(subset(dfCountReuseByGse, dataSubmissionYear==year), table(count)))
    num_total = dfPubmedGseCount[which(dfPubmedGseCount$year==year), "num_gse_ids"]
    placeholder_zero_accessions = paste("FAKE", seq(num_with_reuse+1, num_total), sep="")
    for (accession in placeholder_zero_accessions) {
        dfCountReuseByGse = rbind(dfCountReuseByGse, data.frame(gse=accession, dataSubmissionYear=year, count=0))  
    }
}

q = ddply(dfCountReuseByGse, "dataSubmissionYear", summarise, quantile=qtiles, count=quantile(count, qtiles))
ggplot(data=q, aes(x=count, y=quantile)) + geom_step() + 
    scale_x_continuous(name="\nnumber of times a dataset has been attributed", limits=c(0,40)) +
    scale_y_continuous(name="Cumulative probability\n") +
    theme_bw(base_size=16) + facet_wrap(~ dataSubmissionYear)

end.rcode-->

Reuse paper authors are most likely to use data that is 3-6 years old by the time their paper is published, normalized for how many datasets were deposited each year.  One panel for every year of publication, with papers published that year.

<!--begin.rcode distOfDatasetAge, echo=FALSE

# distribution of elapsed years per publication date
dfDatasetsByElapsed = ddply(subset(dfMentions, (dataSubmissionYear>2002) & (thirdPartyReuse==TRUE)), .( elapsedYears, paperPublishedYear, num_gse_ids), summarise, count=length(gse))

  ggplot(data=subset(dfDatasetsByElapsed, paperPublishedYear>2004), aes(x=elapsedYears, y=count/num_gse_ids)) + geom_line() +
    scale_x_continuous(name="\nyears since data publication", limits=c(0,9)) +
    scale_y_continuous(name="Proportion of all datasets published in given year\n") +    
    facet_wrap(~paperPublishedYear) + 
    theme_bw(base_size=16) 

end.rcode-->




## Discussion

<!--begin.rcode knitCitationsBibtexExperiment, echo=FALSE, results="asis", cache=FALSE
  # set up citations
biblio <- read.bibtex("citation11k.bib")
end.rcode-->


Studies with publicly available datasets received more citations than similar studies without available datasets, even after controlling for many variables known to influence citation rate.  We found the open data citation boost for this sample to be <!--rinline 100*(citation.boost.coefs.journal$est-1) -->% overall
(95% confidence interval: [<!--rinline 100*(citation.boost.coefs.journal$ciLow-1) -->%
to <!--rinline 100*(citation.boost.coefs.journal$ciHigh-1) -->%).  The specific boost depended heavily on the year the dataset was made available.  Datasets deposited in the last few years received no (or few) additional citations, while those deposited in 2004-2005 showed a clear boost of about 30% (confidence intervals 15% to 48%).  Older datasets also received a boost, though the confidence intervals were too wide to be very informative.

These new estimates are lower than those found by previous studies.  The most similar study, Piwowar 2007, found a citation boost of 69% (95% confidence intervals of 18 to 143%) for human cancer gene expression microarray studies published before 2003.  The high estimate of Piwowar 2007 could be because it analyzed particularly impactful datasets (clinically relevant, released early in the history of microarray analysis). Alternatively, the estimate be artifically high because the analysis in Piwowar 2007 omitted several important citation covariates (e.g. number of authors).  To investigate these possibilities we conducted a secondary analysis with our much larger dataset, roughly reproducing the inclusion criteria and methods for Piwowar 2007.  We found a similar citation boost to Piwowar 2007 with this restricted dataset and analysis (a citation increase of 47%, 95% CI 6% to 103%).  When we added two covariates to this analysis -- number of authors and citation history of last author -- the citation boost estimate decreased to 18% with wide confidence intervals (a *loss* of 17% citations to a boost of 66%).  This reinforces the importance of accounting for covariates to calculate accurate estimates, and the need for large samples to support full analysis: the 69% estimate is probably too high, even for its high-impact sample.

How can we interpret a citation boost of 10 to 30%?  Is it a large enough to motivate authors?  Future research is needed to understand author views on the trade-off between citation advantage (and other data archiving benefits) and perceived archiving costs.  For journals, a 10-30% citation boost is likely very motivating, given that journals currently fight for impact factor scores to two decimal places.  What about funders?  How is this citation boost related to more efficient and effective science?

A clear case can be made for data reuse contributing to a stellar scientific ROI [Nature letter], and at least part of an open data citation boost likely comes from data reuse attribution.  To verify that some of the data collection papers in this study were cited in the context of data reuse, we manually reviewed a random <!--rinline num.GEO.total --> sample of the citations in our analysis.  We found that <!--rinline 100*(round(annotated.prop[1], 2)) -->%
(95% CI: <!--rinline 100*(round(annotated.prop[2], 2)) -->%
to <!--rinline 100*(round(annotated.prop[3], 2)) -->%) of the citations were in the context of data reuse.  

Understanding data reuse patterns required a larger sample could easily be assembled through manual classification of citation context.  Instead, our explorations of data reuse patterns leveraged an alternate practice for data reuse attribution: direct mention of a dataset's name and identifier (traditionally an accession number) within the body of a full-text research article.  

Our results suggest the data collection team published almost all of its reuse papers within two years of the data being made publicly available.  In contrast, data reuse papers by third-party authors continued to accumulate rapidly 6 years after the data was made publicly available.  The level of third-party data use was high: for 100 datasets deposited in year 0, we estimate that 40 papers in PubMed reused a dataset by year 2, 100 by year 4, and more than 150 by year 7.  This data reuse curve held remarkably constant for data deposited between 2004 and 2009.  Microarray datasets made available in 2001 and 2002 were reused much more often, probably because of their ground-breaking roles.  The reuse growth trend for data deposited in 2003 has been slower, perhaps because 2003 data is not as ground-breaking as earlier data, and is probably less standards-compliant than later data.

These results suggest that the lower citation boost we observed for recent papers is due, at least in part, to a relatively short followup time.

Analysis of the accession number mentions revealed that data reuse was driven by a broad base of datasets: at least 21% of the datasets deposited in both 2003 and 2007 had been reused by third parties, and 17% of datasets from 2009.  We note these proportions are gross underestimates since they only include reuses we observed as accession number mentions in PubMed Central; no attempt has been made to extrapolate these distribution statistics to all of PubMed, or to reflect attributions through citations.  Further, many important instances of data reuse do not leave a trace in the published literature, such as those in education and training. Nonetheless, even these conservative estimates suggest that reuse finds value in a wide range of datasets, not simply a "very reusable" elite.

Data reuse, and the attendant efficiencies and discoveries, is a primary motivation for requiring that research data be made available.  Consequently, accurate measurement of data reuse is particularly important.  Future work can improve on the current study and previous studies by considering and integrating all methods of data use attribution.  This holistic effort would include identifying citations to the paper that describes the data collection, mentions of the dataset identifier itself -- whether in full text, the references section, or supplementary information -- citations to the dataset as a first-class research object, and even mentions of the data collection investigators in acknowledgement sections.  The citations and mentions would need classification based on context to ensure they are in the context of data reuse.

Estimates of data reuse could then be used to estimate the impact of policy decisions.  For example, do embargo periods decrease the level of data reuse?  Do restrictive or poorly articulated licencing terms decrease data reuse?  Which types of data reuse are facilitate by robust data standards and which types are unaffected?

We note that while an open data citation boost is likely largely driven by citation for data reuse, open data may directly or indirectly inspire citations for other reasons as well.  The literature on "Open Access Citation Benefit" has articulated several possible sources of OA citation boost, including Selection Bias and Early View ["Craig2007"].  Inspired by this work, we suggest several possible sources for an "Open Data Citation Benefit":

1. *Data Reuse*. Papers with available datasets can be used in more ways than papers without data, and therefore may receive additional attributions upon published data reuse.
1. *Credibility Signalling*. The credibility of research findings may be higher for research papers with available data. Such papers may be preferentially chosen background citations and/or the foundation of additional research.
1. *Increased Visibility*. Citing authors may be more likely to encounter a research project with available data. More artifacts associated with a research project gives the project a larger footprint, increasing the likelihood that someone finds an aspect of the research. Links from data to the research paper may also increase the search ranking of the research paper.
1. *Early View*. When data is made available before a paper is published, some citations may accrue earlier than otherwise because research methods and findings are encountered prior to paper publication.
1. *Selection Bias*. Authors may be more likely to publish data for papers they judge to be their best quality work, because they are most proud or confident in the results. ALTERNATIVELY, there is evidence that author self-selection bias may have a negative correlation with research quality in the case of Open Data [Wicherts 2011]: authors may be less willing to share details for their most important and visible research in order to maintain a competitive edge and avoid the upheaval of error detection. 

Importantly, almost all of these mechanisms are aligned with more efficient and effective science.  This means that fueling increased use, facilitated credibility determination, earlier access, improved discoverability, and a focus on best work through data availability is good for both investigators and the science community as a whole.  To address the main citation-related conflicting incentive, withholding data that might be important for finding weaknesses or faults, may require mandates.  Or, instead, perhaps the research community will quickly learn to associate withheld data with poor quality research.

Although the estimated citation boost in the current study is consistent with observed data reuse alone, other sources may also have contributed.  Further work, with additional data, will be needed to understand the relative contributions from each source.  For example, analyses within the pubication output of a sample of data-collecting authors could support measurement of selection bias.  Observing search behaviour of researchers, and the returned search hit results, could provide evidence of increased visibility due to data availability.  Hypothetical examples could be provided to authors to determine whether they would be systematically more likely to cite a paper with available data in situations where they are considering the credibility of the findings.

As evaluators move away from assessing research based on journal impact factor and toward article-level metrics, post-publication metrics rates will become icreasingly important indicators of research impact.  This study and associated work clearly demonstrates that improvements in tools and practice are needed to make impact tracking easier and more accurate, for day-to-day analysis as well as studies like this.  Researchers and research tools need libre access to the full-text of the research literature to support sophisticated text mining.  Citation databases are key building blocks of discovery: researchers need access to the services, and also to the code that support the services so they are empowered to add missing features.  Practice needs improvement too.  Currently data attribution practices are nonstandard, which inevitably leads to confusion and undercounting. 

Future work is needed to assess other important metrics of reuse, beyond citation.  The impact on practitioners, education, data journalism, and industry research are not captured by attibution patterns in the scientific literature.  Altmetrics indicators uncover discussions in social social media, syallabi, patents, and theses: analyzing such indicators for datasets would provide valuable evidence of reuse beyond the scientific literature.  

It is important to remember that the primary rationale for making research data broadly available has nothing to do with evaluation metrics: full description of experimental process and findings is a tenant of science and publicly-funded science is a public resource [http://www.nature.com/news/open-your-minds-and-share-your-results-1.10895].  Nonetheless, robust evidence of personal benefit will help as science transitions to a culture that simply expects data.

## Acknowledgements

- CISTI for Scopus access
- British Library helpers
- Angus, Jonathan, Estephanie
- my funding, Jonathan + Estephanie’s funding

## Author Contributions

HAP: initial idea, study design, data collection, analysis, initial manuscript draft
TJV: study design, substantial manuscript revisions
Both authors discussed the results and implications and commented on the manuscript at all stages.

## References

see references in [Mendeley library](http://www.mendeley.com/groups/2223913/11k-citation/papers/)

- heather, give the papers in the mendeley library another read

References:
<!--begin.rcode citations, echo=FALSE, cache=FALSE, results="asis"
bibliography()
end.rcode-->  

### Experimenting with knitr citations
Demo citing thank Carl for his great library! 
<!--begin.rcode knitCitationsExperiment, echo=FALSE, results="asis", cache=FALSE
citep(list(citation("knitcitations"))) 
end.rcode-->. 

Now cite everyone! 

<!--begin.rcode citeEveryone
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
- Milia N, Congiu A, Anagnostou P, Montinaro F, Capocasa M, et al. (2012) Mine, Yours, Ours? Sharing Data on Human Genetic Variation. PLoS ONE 7(6): e37552. doi:10.1371/journal.pone.0037552
- http://hprints.org/hprints-00714715

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

<ul>
  <li>Ochsner, S. A., Steffen, D. L., Stoeckert, C. J., &amp; McKenna, N. J. (2008). Much room for improvement in deposition rates of expression microarray datasets. Nature Methods. Retrieved from http://dx.doi.org/10.1038/nmeth1208-991</li>
  <li>Tenopir C, Allard S, Douglass K, Aydinoglu AU, Wu L, et al. (2011) Data Sharing by Scientists: Practices and Perceptions. PLoS ONE 6(6): e21101. doi:10.1371/journal.pone.0021101</li>
  <li>Piwowar HA (2011). "Who Shares? Who Doesn't? Factors Associated with Openly Archiving Raw Research Data." <em>PLoS ONE</em>, <em>6</em>(7), pp. e18657</li>
  <li>Dudley JT, Robert Tibshirani, Tarangini Deshpande, Atul J Butte (2009) Disease signatures are robust across tissues and experiments.  Molecular systems biology 5 p. 307</li>
  <li>Tanya Barrett, Dennis B Troup, Stephen E Wilhite, Pierre Ledoux, Carlos Evangelista, Irene F Kim, Maxim Tomashevsky, Kimberly A Marshall, Katherine H Phillippy, Patti M Sherman, Rolf N Muertter, Michelle Holko, Oluwabukunmi Ayanbule, Andrey Yefanov, Alexandra Soboleva (2011) NCBI GEO: archive for functional genomics data sets--10 years on.   Nucleic acids research 39 (Database issue) p. D1005-10</li>
</ul>

### Other studies of correlation with citations:

- Bioinformatics, 25, 3303-3309 (2009). "Predicting citation count of Bioinformatics papers within four years of publication." Ibanez, A., Larrañaga, P. and Bielza, C.  http://bioinformatics.oxfordjournals.org/content/25/24/3303.full


## Abstract

(hasn't been updated to reflect all analyses)

### Background
Attribution upon reuse of scientific data is important to reward data creators and document the provenance of research findings.  In many fields, data attribution commonly takes the form of citation to the paper that described the primary data collection.  Previous studies have found that papers with publicly available datasets do indeed receive a higher number of citations than similar studies without available data.  However, previous studies were relatively small and did not control for many variables known to predict citation rate.  In this analysis we look at citation rates while controlling for many known citation predictors, and investigate whether the estimated citation boost is consistent with evidence of data reuse.

### Methods and Results
In a multivariate linear regression on <!--rinline dim(dfCitationsAttributesRaw)[1] --> studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 
<!--rinline 100*(citation.boost.coefs.journal$est-1) -->%
(95% confidence interval: [<!--rinline 100*(citation.boost.coefs.journal$ciLow-1) -->%
to <!--rinline 100*(citation.boost.coefs.journal$ciHigh-1) -->%)
more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 
<!--rinline 100*(round(annotated.prop[1], 2)) -->%
(95% CI: <!--rinline 100*(round(annotated.prop[2], 2)) -->%
to <!--rinline 100*(round(annotated.prop[3], 2)) -->%, 
n=<!--rinline num.GEO.total -->)
of citations to those studies were in the context of data reuse attribution.

### Discussion



