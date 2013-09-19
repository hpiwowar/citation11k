
## @knitr setup

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

library(knitcitations)

# to get knitcitations:
#library(devtools)
#install_github("knitcitations", "cboettig")

cite_options(tooltip=TRUE, linked=TRUE)

cleanbib()



## @knitr knitCitationsBibtexExperiment
  # set up citations
biblio <- read.bibtex("citation11k.bib")


## @knitr workspace
# Clear the workspace and load package dependencies: 
rm(list=ls())   
require(ggplot2, quietly=T)
require(scales, quietly=T)
require(gplots, quietly=T)
require(reshape2, quietly=T)
require(plyr, quietly=T)
require(rms, quietly=T)
require(polycor, quietly=T)
require(ascii, quietly=T)
require(knitcitations)
# to get knitcitations:
#library(devtools)

options(scipen=999)

source("helpers.R")
source("preprocess_raw_data.R")



## @knitr gfmtable
# From https://gist.github.com/2050761
gfm_table <- function(x, ...){
  y <- capture.output(print(ascii(x, ...), type = 'org'))
  # substitute + with | for table markup
  # TODO: modify regex so that only + signs in markup, like -+- are substituted
  y <- gsub('[+]', '|', y)
  return(writeLines(y))
} 
#gfm_table(anova(fit))


## @knitr calcCI

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


## @knitr colours
#colourblind friendly palettes from http://wiki.stdout.org/rcookbook/Graphs/Colors%20(ggplot2)
cbgRaw = c("#E69F00", "#56B4E9", "#009E73", "#999999", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")
cbgFillPalette <- scale_fill_manual(values=cbgRaw)
cbgColourPalette <- scale_colour_manual(values=cbgRaw)
cbgColorPalette = cbgColourPalette



## @knitr dfAttributes
dfAttributes = read.csv("data/PLoSONE2011_rawdata.txt", sep="\t", header=TRUE, stringsAsFactors=F)


## @knitr correlation_variables
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



## @knitr dfCitations

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



## @knitr preprocessing
# Preprocess attributes as per Piwowar 2011
dfCitationsAttributes = preprocess.raw.data(dfCitationsAttributesRaw)
options(scipen=999)
dfCitationsAttributes = merge(dfCitationsAttributes, dfCitationsAttributesRaw[,c("pmid", "pubmed_journal")], by="pmid", )


## @knitr univariate_correlations

myhetcorr = hetcor.modified(dfCitationsAttributes[,correlation_variables], use="pairwise.complete.obs", std.err=FALSE, pd=FALSE)
mycorr = myhetcorr$correlations
colnames(mycorr) = colnames(myhetcorr$correlations)    
rownames(mycorr) = rownames(myhetcorr$correlations)    

# Correlations with citation
correlations_with_citations = sort(mycorr[,"nCitedBy.log"], dec=T)
correlations_with_citations_df = data.frame(corr=correlations_with_citations)

# Correlations with data availability
correlations_with_data_avail = sort(mycorr[,"dataset.in.geo.or.ae"], dec=T)



## @knitr table1
gfm_table(correlations_with_citations_df)


## @knitr regressionAll
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


## @knitr RegressionAlaPrevStudy
  dat.subset.previous.study = subset(dfCitationsAttributes, (pubmed.year.published<2003) & (pubmed.is.cancer==1) & (pubmed.is.humans==1))

  myfitprev = lm(nCitedBy.log ~ 
      rcs(pubmed.date.in.pubmed, 3) +
      rcs(journal.impact.factor.tr, 3) +               
      factor(country.usa) +              
      factor(dataset.in.geo.or.ae)
               , dat.subset.previous.study)


## @knitr RegressionAlaPrevStudyMoreCovariates
  myfit_prev_more = lm(nCitedBy.log ~ 
      rcs(pubmed.date.in.pubmed, 3) +
      rcs(journal.impact.factor.tr, 3) +               
      rcs(num.authors.tr, 3) + 
      rcs(last.author.num.prev.pmc.cites.tr, 3) +      
      factor(country.usa) +              
      factor(dataset.in.geo.or.ae)
             , dat.subset.previous.study)


## @knitr regressionByYear

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



## @knitr citationContextData
dfTracking1k = read.csv("data/tracking1k_20111008.csv", sep=",", header=TRUE, stringsAsFactors=F)
dfTracking1k.GEO.subset = subset(dfTracking1k, TAG.source=="WoS" & TAG.confidence!="low confidence" & is.na(duplicates & TAG.repository=="GEO" & (TAG.dataset.reused=="dataset reused" | TAG.dataset.reused=="dataset not reused")))

num.GEO.total = dim(dfTracking1k.GEO.subset)[1]
num.GEO.reused = dim(subset(dfTracking1k.GEO.subset, TAG.dataset.reused=="dataset reused"))[1]
annotated.prop = binconf(num.GEO.reused, num.GEO.total)


## @knitr accessionRatios

dfPubmedPmcRatios = read.csv("data/pubmed_pmc_ratios.csv", header=TRUE, stringsAsFactors=F)

# get a more exact ratio
dfPubmedPmcRatios$pmc_pmid_ratio = dfPubmedPmcRatios$num_pmc/dfPubmedPmcRatios$num_pubmed
dfPubmedPmcRatios$year = as.numeric(dfPubmedPmcRatios$year)

# cbind(with(dfPubmedPmcRatios, paste(year, ": ", round(pmc_pmid_ratio*100, 0), "%", sep="")))


## @knitr dfPubmedGseCount

dfPubmedGseCount = read.csv("data/pubmed_gse_count.csv", header=TRUE, stringsAsFactors=F)

# subset(dfPubmedGseCount, year<2011)



## @knitr dfMentions

header_string = "accession,gse,gds,submit_pmids,reuse_pmcid,reuse_pmids_for_pmc,this_submit_authors,this_reuse_authors,intersect,submit_affiliation,release_date,sep1,bioloink_filter,basic_reuse_filter,creation_filter,oa_excerpts,word_filters,sep2,reuse_affiliation,journal,year,date_published,medline_status,is_geo_reuse,reuse_is_oa,metaanal,mesh_filters,blank,setname"
header = strsplit(header_string, ",")[[1]]

# cat records_20*.csv > GEO_dataset_attributes.csv
dfMentions = read.csv("data/GEO_dataset_attributes.csv", header=TRUE, stringsAsFactors=F)
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



## @knitr dfMentions_calcs

dfCountReusePapers = ddply(dfMentions, .(elapsedYears, thirdPartyReuse, dataSubmissionYear, pmc_pmid_ratio), summarise, count=length(elapsedYears))
dfCountReusePapers$extrap = dfCountReusePapers$count / dfCountReusePapers$pmc_pmid_ratio
dfCountReusePapers = merge(dfCountReusePapers, dfPubmedGseCount, by.x="dataSubmissionYear", by.y="year")

dfCountReusePapersThirdParty = ddply(subset(dfCountReusePapers, thirdPartyReuse==TRUE), c("dataSubmissionYear", "elapsedYears"), summarise, total = sum(extrap))
dfCountReusePapersThirdParty= merge(dfCountReusePapersThirdParty, dfPubmedGseCount, by.x="dataSubmissionYear", by.y="year")

dfCountReusePapersThirdPartyCumulative = ddply(dfCountReusePapersThirdParty[with(dfCountReusePapersThirdParty, order(elapsedYears)),], c("dataSubmissionYear"), transform, NT = cumsum(total))

total_extrap_reuse_papers = floor(sum(subset(dfCountReusePapers, thirdPartyReuse==TRUE, extrap)))



## @knitr data_available_numbers
data_available_numbers = table(dfCitationsAttributesRaw$in_ae_or_geo)
data_available_ttest = t.test(dfCitationsAttributesRaw$in_ae_or_geo)


## @knitr sortedjournals
sorted_journals = sort(table(dfCitationsAttributesRaw$pubmed_journal)/nrow(dfCitationsAttributesRaw), dec=T)[1:12]


## @knitr table2
gfm_table(cbind(names(sorted_journals), round(sorted_journals, 2)))

prop2001 = 100*round(nrow(subset(dfCitationsAttributesRaw, pubmed_year_published=="2001"))/nrow(dfCitationsAttributesRaw)[1], 2)

prop2009 = 100*round(nrow(subset(dfCitationsAttributesRaw, pubmed_year_published=="2009"))/nrow(dfCitationsAttributesRaw)[1], 2)


## @knitr table3
gfm_table(table(dfCitationsAttributesRaw$pubmed_year_published)/nrow(dfCitationsAttributesRaw))


## @knitr figure1

citation_breaks = c(0, 10, 100, 1000, 3000)
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
cbgColourPalette + theme_bw(base_size=32)



## @knitr display_regressionAll

#gfm_table(anova(fit_w_journal))
citation.boost.coefs.journal = calcCI.exp(fit_w_journal, "factor(dataset.in.geo.or.ae).L")
#print(citation.boost.coefs.journal)



## @knitr display_RegressionAlaPrevStudy
  gfm_table(anova(myfitprev))
  calcCI.exp(myfitprev, "factor(dataset.in.geo.or.ae).L")


## @knitr display_RegressionAlaPrevStudyMoreCovariates
  gfm_table(anova(myfit_prev_more))
  calcCI.exp(myfit_prev_more, "factor(dataset.in.geo.or.ae).L")


## @knitr table4
cat("\nyear\testimate [95% confidence interval]")
with(estimates_by_year, cat(paste("\n", year, "\t", est, " \t[", ciLow, ", \t", ciHigh, "]", sep="")))


## @knitr figure2
ggplot(estimates_by_year, aes(x=year, y=est)) + geom_line() + 
  geom_errorbar(width=.1, aes(ymin=ciLow, ymax=ciHigh)) +
  scale_x_continuous(name="year of study publication", breaks=seq(2001, 2009)) +
  scale_y_continuous(name='increased citation count for studies with publicly available data\n', limits=c(.5, 2.5), breaks=seq(0.5, 2.5, .5), labels=c("-50%", "0", "+50%", "+100%", "+150%")) + 
  theme_bw(base_size=32) +
  geom_hline(color="grey50", linetype="dashed", aes(yintercept=1))


## @knitr growthOfReusePapers
dfCountUnique3rdpartyPapers = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(paperPublishedYear, pmc_pmid_ratio), summarise, count=length(unique(reuse_pmcid)))

dfCountUnique3rdpartyPapers$extrap = with(dfCountUnique3rdpartyPapers, count/pmc_pmid_ratio)

dfCountUnique3rdpartyPapers = ddply(dfCountUnique3rdpartyPapers, .(), transform, cumul_extrap=cumsum(extrap))

dfCountUnique3rdpartyPapers = merge(dfCountUnique3rdpartyPapers, dfPubmedGseCount, by.x="paperPublishedYear", by.y="year")

dfCountUnique3rdpartyPapers = ddply(dfCountUnique3rdpartyPapers, .(), transform, cumul_gse=cumsum(num_gse_ids))


## @knitr figure3
# log
ggplot(data=dfCountUnique3rdpartyPapers, aes(x=paperPublishedYear, y=cumul_gse)) + geom_point() + geom_line(aes(color="datasets")) + 
scale_x_continuous(name="\nyear of publication", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative count (log scale)\n", trans="log", breaks=log_breaks()) +
scale_colour_manual(name="", values=cbgRaw) +
theme_bw(base_size=32) +
geom_line(aes(y=cumul_extrap, color="third-party reuse papers")) + geom_point(aes(y=cumul_extrap)) 


## @knitr figure4
ggplot(dfCountReusePapers, aes(x=elapsedYears, y=extrap, color=thirdPartyReuse)) + geom_line() + 
scale_x_continuous(name="\nyears since data publication", limits=c(0, 8)) +
scale_y_continuous(name="Number of papers\n", labels=comma_format()) +
facet_wrap(~dataSubmissionYear) +
scale_colour_manual(name="",
                    values=cbgRaw,
                    breaks=c(FALSE, TRUE),
                    labels=c("orig authors", "third-party authors")) +
theme_bw(base_size=32)


## @knitr figure5
# cumulative
ggplot(data=subset(dfCountReusePapersThirdPartyCumulative, dataSubmissionYear>2000), aes(x=dataSubmissionYear+elapsedYears, y=NT, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\npublication year of reuse paper", limits=c(2001, 2010)) +
scale_y_continuous(name="Cumulative number of papers\n", labels=comma_format()) +
scale_color_hue(name="year of data publication") +
theme_bw(base_size=32)


## @knitr suppfigure1
ggplot(data=subset(dfCountReusePapersThirdPartyCumulative, dataSubmissionYear>2002), aes(x=elapsedYears, y=NT/num_gse_ids, group=dataSubmissionYear, color=factor(dataSubmissionYear))) + geom_point() + geom_line() + 
scale_x_continuous(name="\nyears since data publication", limits=c(0, 8)) +
scale_y_continuous(name="Cumulative number of papers\nnormalized by number of datasets deposited in given year\n", labels=comma_format()) +
scale_colour_manual(name="year of data publication", values=cbgRaw) +
theme_bw(base_size=32)


## @knitr figure6

dfGsePerReusePaper = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(reuse_pmcid, paperPublishedYear), summarise, count=length(unique(gse)))

breaks = c(1,5,10,50)
ggplot(data=dfGsePerReusePaper, aes(x=factor(paperPublishedYear), y=count)) + 
  geom_jitter(position = position_jitter(w = 0.1, h = 0.1), color=cbgRaw[1]) +
  scale_x_discrete("\nYear reuse paper was published") +
  scale_y_continuous(name="Number of datasets per reuse paper\n", trans="log", breaks=breaks) +  
  stat_summary(fun.y=mean, geom=c("line"), color=cbgRaw[2], aes(group=1)) +
  cbgColourPalette + theme_bw(base_size=32)



## @knitr figure7

dfCountReuseByGse = ddply(subset(dfMentions, thirdPartyReuse==TRUE), .(gse, dataSubmissionYear), summarise, count=length(elapsedYears))

for (year in seq(2001, 2009)) {
    num_with_reuse = sum(with(subset(dfCountReuseByGse, dataSubmissionYear==year), table(count)))
    num_total = dfPubmedGseCount[which(dfPubmedGseCount$year==year), "num_gse_ids"]
    if (num_with_reuse < num_total) {
      placeholder_zero_accessions = paste("FAKE", seq(num_with_reuse+1, num_total), sep="")
      for (accession in placeholder_zero_accessions) {
          dfCountReuseByGse = rbind(dfCountReuseByGse, data.frame(gse=accession, dataSubmissionYear=year, count=0))  
      }
    }
}

q = ddply(dfCountReuseByGse, "dataSubmissionYear", summarise, quantile=seq(0,1,0.01), count=quantile(count, seq(0,1,0.01)))

qq = subset(q, count %in% c(1, 3))

qqq = ddply(qq, c("dataSubmissionYear", "count"), summarise, maxq=min(quantile))

ggplot(data=qqq, aes(x=dataSubmissionYear, y=1-maxq, color=factor(count, labels=c("reused at least once", "reused at least three times")))) + geom_line() + geom_point() + 
  scale_x_continuous("\nYear data was submitted") +
  scale_y_continuous(name="Proportion of data submissions\n") + 
scale_color_hue(name="") + theme_bw(base_size=32)



## @knitr figure8

# distribution of elapsed years per publication date
dfDatasetsByElapsed = ddply(subset(dfMentions, (dataSubmissionYear>2002) & (thirdPartyReuse==TRUE)), .( elapsedYears, paperPublishedYear, num_gse_ids), summarise, count=length(gse))

  ggplot(data=subset(dfDatasetsByElapsed, paperPublishedYear>2004), aes(x=elapsedYears, y=count/num_gse_ids)) + geom_line() +
    scale_x_continuous(name="\nyears since data publication", limits=c(0,9)) +
    scale_y_continuous(name="Proportion of all datasets published in given year\n") +    
    facet_wrap(~paperPublishedYear) + 
    cbgColourPalette +
    theme_bw(base_size=32) 



## @knitr citations
bibliography()


## @knitr percent
206/226


## @knitr manualAnnotationCreatedData
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


## @knitr manualAnnotationCreatedStats
ttest_citedby = with(dfCitationsAnnotated, t.test(nCitedBy~isCreated))
ttest_log_citedby = with(dfCitationsAnnotated, t.test(log(1+nCitedBy)~isCreated))
wilcox_citedby = with(dfCitationsAnnotated, wilcox.test(nCitedBy~isCreated))


## @knitr manualAnnotationCreatedRegression
annotated_merged_created = lm(nCitedBy.log ~ 
  rcs(pubmed.date.in.pubmed, 3) +
  rcs(journal.impact.factor.tr, 3) +               
  rcs(num.authors.tr, 3) + 
  rcs(last.author.num.prev.pmc.cites.tr, 3) +      
  factor(country.usa) +              
  factor(dataset.in.geo.or.ae)
             , dat.annotated.merged.created)


## @knitr manualAnnotationCreatedCitations
with(dfCitationsAnnotated, summary(nCitedBy~isCreated))


## @knitr display_manualAnnotationCreatedCitations
citation_breaks = c(0, 10, 100, 1000, 3000)
ggplot(dfCitationsAnnotated, aes(1+nCitedBy, fill=factor(isCreated))) + geom_density(alpha=0.2) + 
scale_fill_manual(name="",
                    values=cbgRaw, 
                    breaks=c("created-microarray-data", "created-microarray-data-not"),
                    labels=c("did collect microarray data", "did NOT collect microarray data")) + 
scale_x_log10(name="\nnumber of citations", breaks=citation_breaks+1, labels=citation_breaks) + 
#cbgFillPalette + 
cbgColourPalette + theme_bw(base_size=32)


## @knitr display_manualAnnotationCreatedStats
print(ttest_citedby)
print(ttest_log_citedby)
print(wilcox_citedby)


## @knitr display_manualAnnotationCreatedRegression
gfm_table(anova(annotated_merged_created))
calcCI.exp(annotated_merged_created, "factor(dataset.in.geo.or.ae).L")


