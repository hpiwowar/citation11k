




See the [end of this document](#about-this-doc) for information about generating this document and how to generate it from source with knitr.

















# Data Reuse and the Open Data Citation Advantage
*Piwowar, Carlson, Vision*


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there supporting evidence that additional citations are due to data reuse?
1. What is the timeline of data reuse?

## Abstract

See the [end of this document](#abstract-1) (at the end so it can pull in results from the R analysis).

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection." (Piwowar _et. al._ 2007)

Making research data publicly available also has costs. Some of these costs are to society: For example, data archives must be created and maintained. Many costs, however, are born by the data-collecting investigators: Data must be documented, formatted, and uploaded. Investigators may be afraid that other researchers will find errors in their results, or "scoop" additional analyses they have planned for the future.

Personal incentives are important to balance these personal costs.  Scientists report that receiving additional citations is an important motivator for publicly archiving their data (Tenopir _et. al._ 2011).

Evidence suggests that studies which make their data available do indeed receive more citations than similar studies that do not make their data available (Gleditsch & Strand, 2003; Piwowar _et. al._ 2007; Ioannidis _et. al._ 2009; Pienta _et. al._ 2010; Henneken & Accomazzi, 2011; Sears, 2011; Dorch, 2012).
This evidence has been <a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">frequently referenced</a> and highlighted in new policies that encourage and require data archiving [<a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">http://datadryad.org/jdap</a>], demonstrating the appetite for evidence of personal benefit.

It important to continue striving for an accurate estimate of citation correlation, to avoid over- or under-stating the benefits of data availability.

This report on open data citation advantage improves on previous work in several ways. First, the sample size is large, so we have been able to include additional variables in the statistical analyses.  The resulting estimates isolate the association between data availability and citation rate with more accuracy. Second, this report goes beyond citation analysis to include analysis of data reuse attribution directly.  We explore how data reuse patterns change over both the lifespan of a data repository and the lifespan of a dataset.

## Methods


###Relationship between data availability and citation

####Data collection




The primary analysis in this paper examines the citation count of a gene expression microarray experiment, relative to availability of the experiment's data.

The sample of microarray experiments used in the current analysis was previously determined (Piwowar, 2011; Piwowar, 2011).  Briefly, a full-text query uncovered papers with wet-lab methods related to gene expression microarray data collection.  The full-text query was characterized with high precision (90%, 95% confidence interval 86% to 93%) and a moderate recall (56%, 52% to 61%) for this task.  Running the query in PubMed Central, HighWire Press, and Google Scholar identified <code class="knitr inline">1.1603 &times; 10<sup>4</sup></code> distinct gene expression microarray papers.  The papers were published between 2000 and 2009.

The independent variable of interest is the availability of gene expression microarray data.  Data availability had been previously determined for our sample articles in (Piwowar, 2011), so we directly reused that dataset (Piwowar, 2011).  Datasets were considered available if they were discovered in either of the two predominant gene expression microarray databases: NCBI's Gene Expression Omnibus (GEO), and EBI's ArrayExpress.

"An earlier evaluation found that querying GEO and ArrayExpress with article PubMed identifiers located a representative 77% of all associated publicly available datasets [Piwowar 2010]. [We] used the same method for finding datasets associated with published articles in this study: [we] queried GEO for links to the PubMed identifiers in the analysis sample using the “pubmed_gds [filter]” and queried ArrayExpress by searching for each PubMed identifier in a downloaded copy of the ArrayExpress database. Articles linked from a dataset in either of these two centralized repositories were considered to have [publicly available data] for the endpoint of this study, and those without such a link were considered not to have [available] data." (Piwowar, 2011)

(Piwowar, 2011) included 124 attributes for each of the gene expression microarray studies in our sample.  We used a subset of these --attributes previously shown or suspected to correlate with citation rate:




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




Citation counts for <code class="knitr inline">1.0555 &times; 10<sup>4</sup></code> papers were exported from Scopus in November 2011. 


####Primary analysis

The analysis included several multivariate linear regressions to evaluate the association between the public availability of a study's microarray data and the number of citations (after log transformation) it received. 

We began with a simple correlations between number of citations and other variables, using Pearson correlations for numberic variables and polyserial correlations for binary and factor covariates.  We also calculated correlations between data availability and other variables to investigate collinearity. 







The main analysis was run across all papers in the sample with many  covariates known or found (in the correlation analysis above) to correlate with citation rate.  Covariates included the date of publication, the journal which published the study, the journal impact factor, the journal citation halflife, the number of articles published by the journal, the journal's open access policy, whether the journal is considered a core clinical journal by MEDLINE, the number of authors of the study, the country of the corresponding author, the citation score of the institution of the corresponding author, the publishing experience of the first and last author, and the subject of the study itself.  

Publishing experience was characterized by the number of years since the author's first paper in PubMed, the number of papers they have published, and the number of citations they have received in PubMed Central, estimated using Authority clusters as described in [Piwowar 2011].  The subject of the study was characterized by whether the paper was classified as cancer, animals, or plants.  For more information on study attributes see (Piwowar, 2011).

Citation count was log transformed to be consistent with prior literature.  Other count variables square-root transformed.  Continuous variables were represented with 3-part spines in the regression, using the rcs function in the R rms library.

The independent variable of interest was represented as a 0 or 1 in the regression, describing whether or not associated data had been found in the data repositories.  The relationship of the data availability variable to  citation count was described with 95% confidence intervals after raising the regression coefficient to the power of e (since the log of the number of citations was used in the regression).




Because publication date is such a strong correlate with both citation rate and data availability, we performed another analysis which stratified the sample by publication year, in addition to including publication date as a covariate.  Because the yearly regressions included fewer datapoints than the full regression, they supported a smaller number of covarites.  The yearly regressions included  date of publication, the journal which published the study, the journal impact factor, the journal's open access policy, the number of authors of the study, the citation score of the institution of the corresponding author, the previous number of PubMed Central citations recieved by the first and last author, whether the study was on cancer, and whether it used animals.








#### Comparison to Piwowar et al 2007

We ran two modified analyses to attempt to reproduce the findings of (Piwowar _et. al._ 2007).  First, we used a subset with roughly the same inclusion criteria as (Piwowar _et. al._ 2007) -- studies on cancer, with humans, published prior to 2003 -- and the same regression coefficients: publication date, impact factor, and whether the corresponding author's address is in the USA.




We followed that with a second regression that included several additional important covariates:  number of authors and number of previous citations by the last author.




####Manual review of citation context

We manually reviewed the citation context of some of these papers to determine how many of the citations were in the context of data reuse.

We randomly selected 100 datasets deposited in GEO in 2005.  For each dataset, we located the data collection article within ISI Web of Science based on its title and authors, and exported the list of all articles that cited this data collection article. This list of all citations was processed to subselect  50 random  citations, stratified by  the totalnumber of times the data collection article had been cited.

Manual review was performed for each instance of potential data reuse.  We located the article full text, read the relevant sections of the papers, and manually determined if the data from the associated dataset had been reused within the study. (Piwowar _et. al._ 2011)




###Data reuse patterns from accession number attribution

####Data collection

We collected a separate dataset to study reuse patterns because identifying data reuse from citations requires time-consuming classification of citation context.

Datasets are sometimes attributed directly, through mention of the dataset identifier or accession number in the full-text of a research paper.  Third-party dataset resuse can be estimated from these mentions by excluding papers that were authored by members of the dataset collection team.

We used the NCBI eUtils library and custom Python code to obtain a list of all datasets deposited into the Gene Expression Omnibus data repository, then searched PubMed Central for each of these dataset identifiers (using queries of the form "'GSEnnnn' OR 'GSE nnnn'"). For each hit we recorded the PubMed Central ID of the paper that mentioned the accession number, the year of paper publication, and the author surnames.  We also recorded the dataset accession number, the year of dataset publication, and the investigator names associated with the dataset record.

####Statistical analysis

We excluded papers with author surnames in common with those authors who deposited the original dataset, as described in  (Piwowar _et. al._ 2011).  

PubMed Central contains only a subset of papers recorded in PubMed. As described in  (Piwowar _et. al._ 2011), to extrapolate from the number of data reuses in PubMed Central to all possible data reuses in PubMed, we divided the yearly number of hits by the ratio of papers in PMC to papers in PubMed for this domain (domain was measured as the number of articles indexed with the MeSH term “gene expression profiling”).  




We retained reuse candidates for papers published between 2001 and 2010: 2011 was within 12 months of data collection, and had a dramatically lower proportion of papers in PubMed Central because the NIH archiving requirements permit a 12 month embargo.

To understand our findings on a per-dataset basis, we stratified reuse estimates by year of dataset submission and normalized our reuse findings by the number of datasets deposited that year.










### Data and script availability

Statistical analyses were last run on <code class="knitr inline">Wed Jul 25 11:48:53 2012</code> with <code class="knitr inline">R version 2.15.1 (2012-06-22)</code>.  Packages used include reshape2 (Wickham, 2007), plyr (Wickham, 2011), rms (Jr, 2012), polycor (Fox, 2010), ascii (Hajage, 2011), ggplot2 (Wickham, 2009), gplots (Bolker _et. al._ 2012), knitr (Xie, 2012), and knitcitations (Boettiger, 2012). P-values are two-tailed.  

Raw data and statistical scripts are available in the Dryad data repository at [url and citation to be determined and included upon article acceptance].  Data collection scripts are at [GitHub pypub.  Heather, push changes!]

The Markdown version of this manuscript with interleaved statistical scripts (Xie, 2012) is also at Dryad and in GitHub [https://github.com/hpiwowar/citation11k](https://github.com/hpiwowar/citation11k).

## Results

#### Description of cohort

We identified <code class="knitr inline">1.0557 &times; 10<sup>4</sup></code> articles published between 2001 and 2009 as collecting gene expression microarray data.




This sample was spread across <code class="knitr inline">667</code> journals, with the top 12 journals accounting for <code class="knitr inline">30</code>% of the papers.

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## | Cancer Res               | 0.04 |
## | Proc Natl Acad Sci U S A | 0.04 |
## | J Biol Chem              | 0.04 |
## | BMC Genomics             | 0.03 |
## | Physiol Genomics         | 0.03 |
## | PLoS One                 | 0.02 |
## | J Bacteriol              | 0.02 |
## | J Immunol                | 0.02 |
## | Blood                    | 0.02 |
## | Clin Cancer Res          | 0.02 |
## | Plant Physiol            | 0.02 |
## | Mol Cell Biol            | 0.01 |
</pre></div></div></div>


More papers were published in later years: <code class="knitr inline">2</code>% of articles in our sample were published in 2001, compared to <code class="knitr inline">15</code> % in 2009.

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
</pre></div></div></div>


Searching for datasets associated in the GEO and ArrayExpress repositories uncovered links for <code class="knitr inline">24.8</code>% of papers in the sample.

The articles in our sample were cited between <code class="knitr inline">0</code> and <code class="knitr inline">2643</code> times, with an average of <code class="knitr inline">32</code> citations per paper and a median of <code class="knitr inline">16</code> citations.

We confirmed the inclusion of articles mistakenly identified as creating gene expression microarry data had a small influence on the outcomes of our study. The overall distribution of citations for articles that did not create gene expression data is closer to zero than the distribution of citations for articles that did create gene expression data, but was found to be not statisitically significantly different.  Furthermore, a subanalysis on the manually-curated articles was similar to the findings from the whole sample. (see supplementary materials)

### Data availability is associated with citation boost

Without accounting for any confounding factors, the mean number of citations between papers with available data and those without are the same, and the distributions were similar.

We hasten to mention strong confunders.  The number of citations a paper has recieved is strongly correlated to the date it was published: older papers have had more time to accumulate citations.  Data archiving frequency is also correlated with time -- early articles were less likely to archive data  (Piwowar, 2011).  Indeed, we found that for any given publication date, papers with associated data recieved more citations than those without.  Furthermore, the distribution of citations for older papers with available data is centered at a higher median than citations for papers without data available.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/citationDist.png" class="plot" /></div></div>


Other variables have been previously shown to be correlated with citation rate, including number of authors, author experience, author institution, open access status, and subject area [cite]. Single-variable correlations can be misleading, so we performed multivariate regression to characterize the relationship between data availability and citation rate, independently of these other variables.




We found many of the variables were independently associated with citation rate, including number of authors, journal impact factor, the journal itself, the date of publication, the number of previous citations of the fist and last author, the number of previous publications of the last author, whether the paper was about animals or plants, and whether the data was made publicly available.

Estimate of the independent increase of citations due to data availability is  
<code class="knitr inline">9</code>%
with 95% confidence intervals [<code class="knitr inline">5</code>%
, <code class="knitr inline">13</code>% ]
(p=<code class="knitr inline">0.00</code>)



### More covariates led to a more conservative estimate

Our estimate of citation boost, <code class="knitr inline">9</code>% as per the multivariate regression, is notably smaller than the 69% (95% confidence intervals of 18 to 143%) citation advantage found by (Piwowar _et. al._ 2007), even though both studies looked at publicly available gene expression microarray data. There are several possible reasons for this difference.  

First, (Piwowar _et. al._ 2007) concentrated on datasets from high-impact studies: human cancer microarray trials published in the early years of microarray analysis (between 1999 and 2003), whereas the current study included gene expression microarray data studies on any subject published between 2001 and 2009. Second, because the (Piwowar _et. al._ 2007) sample was small, the previous analysis included only a few covariates: publication date, journal impact factor, and country of the corresponding author.

We attempted to reproduce the prior analysis with the current data points.  Limiting the inclusion criteria to datasets with MeSH terms "human" and "cancer", and to papers published between 2001 and 2003, reduced the cohort to 308 papers.  Running this subsample with covariates used in the (Piwowar _et. al._ 2007) paper resulted in a comperable estimate to the 2007 paper: a citation increase of 47% (95% confidence intervals of 6% to 103%).




The subsample of 308 papers was large enough to include a few additional covariates: number of authors and citation history of the last author.  Including these important covariates decreased the estimated effect to 18% with a confidence interval that spanned a *loss* of 17% citations to a boost of 66%. 




### Data reuse contributes to citation boost

To provide evidence on the proportion of the citation boost that may be caused by data reuse, we report the observed frequency with which papers that shared gene expression microarray data were cited in the context of data attribution.  Citations to papers that describe 100 datasets deposited into GEO in 2005 were collected using Web of Science.  A sample of 138 citations were randomly selected and manually reviewed.  

Of the <code class="knitr inline">138</code> reviewed citations to articles with archived gene expression data, <code class="knitr inline">8</code> were in the context of data reuse
<code class="knitr inline">6</code>%
with 95% confidence intervals [<code class="knitr inline">3</code>%
, <code class="knitr inline">11</code>% ]

### Citation boost and reuse rates change over time

Because publication date is such as strong correlate with both citation rate and data availability, we also ran regressions for each publication year individually (with a subset of the covariates).

The estimate of citation boost was different for different years of publication.  The estimates of citation boost for papers published in each year, with 95% confidence intervals:




<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_regressionEstimatesByYear.png" class="plot" /></div></div>



To provide evidence on the timeline of data attribution, we report  data reuse activity attributed through direct dataset mentions.  This is only a subset of all data reuse (it doesn't include attribution through citations, for example), but the patterns of reuse are likely similar across methods of attribution.

We found <code class="knitr inline">9274</code> mentions of GEO datasets in papers published between 2000 and 2010 within PubMed Central, including <!-- round(sum(subset(dfCountReusePapers, thirdPartyReuse==TRUE, count)), 0) --> by author teams that do not overlap those that deposited the data.  Extrapolating this to all of PubMed, we estimate there may be about <!-- round(sum(subset(dfCountReusePapers, thirdPartyReuse==TRUE, extrap)), 0)--> third-party reuses of GEO data attributed through accession numbers in all of PubMed, in papers published between 2000 and 2010.

The number of reuse papers started to grow rapidly only after several years of dataset publication.  In recent years both the number of datasets and the number of reuse papers are growing rapidly, at about the same rate.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/growthOfReusePapers.png" class="plot" /></div></div>


Almost all reuse papers by authors who collect and archive a given dataset (as estimated by surname overlap with data submission record) are published within two years of dataset publication.  This pattern contrasts sharply with data reuse by outside authors.

A panel displays the reuse of data published in the panel year, vs an x-axis of paper publication date.
<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_authorVThirdParty.png" class="plot" /></div></div>



Figure A shows the cumulative number of third-party reuse papers, illustrating growth over time.  Separate lines are displayed for different dataset publication years.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_accessionReuse_cumulative.png" class="plot" /></div></div>


Because the number of datasets published has grown dramatically with time, it is interesting to see the cumulative number of third-party reuses normalized by the number of datasets deposited each year.  Early years, 2001-2002, had relatively few data deposits but they have received a large amount of reuse.




We exclude the early years from the next plot to examine the pattern of data reuse once gene expression datasets became more common.  Figure B shows cumulative third-party reuse, normalized by number of datasets deposited each year, plotted as elapsed years since data publication.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_accessionReuse_cumulative_normalized_2003_elapsed.png" class="plot" /></div></div>


## Number of reuses in a paper increases with time

The number of datasets used in a reuse paper was found to increase over time. Each panel reports analysis for reuse papers published that year, reusing data from any year.  In 2002-2004 almost all reuse papers only used one or two datasets.  By 2010, 25% of reuse papers used 3 or more datasets. 

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/numberDatasetsInReusePaper.png" class="plot" /></div></div>






## Probability of reuse

Reuse was not limited to just a few papers. Almost all datasets published in 2001 and 2002 have been reused at least once.  Newer datasets have been used less often, but we observed reuse of at least 20% of the datasets deposited in 2007.  The actual rate, across all methods of attribution and extrapolated to all of PubMed, is likely much higher. 

Distribution of reuse across individual datasets.  One panel for every year of reuse study publication.

<div class="chunk"><div class="rcode"><div class="error"><pre class="knitr">## Error: object 'qtiles' not found
</pre></div><div class="error"><pre class="knitr">## Error: 'match' requires vector arguments
</pre></div><div class="error"><pre class="knitr">## Error: object 'qq' not found
</pre></div><div class="error"><pre class="knitr">## Error: object 'qqq' not found
</pre></div></div></div>


What is the distribution of the age of datasets used by data reuse studies?  We found the authors of data reuse papers are most likely to use data that is 3-6 years old by the time their paper is published, normalized for how many datasets were deposited each year.  

One panel for every year of publication, with papers published that year.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/distOfDatasetAge.png" class="plot" /></div></div>



## Discussion

Studies with publicly available datasets received more citations than similar studies without available datasets, even after controlling for many variables known to influence citation rate.  We found the open data citation boost for this sample to be <code class="knitr inline">9</code>% overall
(95% confidence interval: <code class="knitr inline">5</code>%
to <code class="knitr inline">13</code>%).  The specific boost depended heavily on the year the dataset was made available.  Datasets deposited very recently received no (or few) additional citations, while those deposited in 2004-2005 showed a clear boost of about 30% (confidence intervals 15% to 48%).  Older datasets also received a boost, though the estimate has wide confidence intervals because few studies created this type of data in the early 2000s.

Estimates calculated in this study are lower than those reported by previous studies.  The most similar study, (Piwowar _et. al._ 2007), found a citation boost of 69% (95% confidence intervals of 18 to 143%) for human cancer gene expression microarray studies published before 2003.  The high estimate of (Piwowar _et. al._ 2007) could be because it analyzed particularly impactful datasets (clinically relevant, released early in the history of microarray analysis). Alternatively, the estimate be artifically high because the analysis in (Piwowar _et. al._ 2007) omitted several important citation covariates (e.g. number of authors).  To investigate these possibilities we conducted a secondary analysis with our much larger dataset, roughly reproducing the inclusion criteria and methods for (Piwowar _et. al._ 2007).  We found a similar citation boost to (Piwowar _et. al._ 2007) with this restricted dataset and analysis (a citation increase of 47%, 95% CI 6% to 103%).  When we added two covariates to this analysis -- number of authors and citation history of last author -- the citation boost estimate decreased to 18% with wide confidence intervals (a *loss* of 17% citations to a boost of 66%).  This reinforces the importance of accounting for covariates to calculate accurate estimates, and the need for large samples to support full analysis: the 69% estimate is probably too high, even for its high-impact sample.

How can we interpret a citation boost of 10 to 30%?  Is it a large enough to motivate authors?  Future research is needed to understand author views on the trade-off between citation advantage (and other data archiving benefits) and perceived archiving costs.  For journals, a 10-30% citation boost is likely very motivating, given that journals currently fight for impact factor scores to two decimal places.  What about funders?  How is this citation boost related to more efficient and effective science?

### data reuse

A clear case can be made for data reuse contributing to a stellar scientific ROI [Nature letter], and at least part of an open data citation boost likely comes from data reuse attribution.  To verify that some of the data collection papers in this study were cited in the context of data reuse, we manually reviewed a random <code class="knitr inline">138</code> sample of the citations in our analysis.  We found that <code class="knitr inline">6</code>%
(95% CI: <code class="knitr inline">3</code>%
to <code class="knitr inline">11</code>%) of the citations were in the context of data reuse.  

Understanding data reuse patterns required a larger sample could easily be assembled through manual classification of citation context, so we collected a second dataset.  Our explorations of data reuse patterns leveraged an alternate practice for data reuse attribution: direct mention of a dataset's name and identifier (traditionally an accession number) within the body of a full-text research article.  

We found that the data collection team published almost all of its papers within two years of the data being made publicly available.  In contrast, data reuse papers by third-party authors continued to accumulate 6 years after the data was made publicly available.  The level of third-party data use was high: for 100 datasets deposited in year 0, we estimate that 40 papers in PubMed reused a dataset by year 2, 100 by year 4, and more than 150 by year 5.  This data reuse curve held remarkably constant for data deposited between 2004 and 2009.  Microarray datasets made available in 2001 and 2002 were reused much more often -- every single dataset deposited in 2001 has been reused in a third-party paper.  This is probably because of their ground-breaking roles.  The reuse growth trend for data deposited in 2003 has been slower, perhaps because 2003 data is not as ground-breaking as earlier data, and it is likely less standards-compliant and technically relevant than later data.

Third-party reuse papers are being published at about the same rate as new datasets are made available.  Recent reuse analyses use more datasets, on average, than older reuse studies. A quarter of reuse studies in 2010 used at least 3 datasets. Published analyses are most likely to include data published between 3 and 6 years ago, normalized for how many datasets were deposited each year.  

These results suggest that the lower citation boost we observed for recent papers is due, at least in part, to a relatively short followup time.

Analysis of the accession number mentions revealed that data reuse was driven by a broad base of datasets: at minimum of 20% of the datasets deposited between 2003 and 2007 have been reused by third parties.  We note these proportions are gross underestimates since they only include reuses we observed as accession number mentions in PubMed Central; no attempt has been made to extrapolate these distribution statistics to all of PubMed, or to reflect attributions through citations.  Further, many important instances of data reuse do not leave a trace in the published literature, such as those in education and training. Nonetheless, even these conservative estimates suggest that reuse finds value in a wide range of datasets, not simply a "very reusable" elite.

Data reuse, and the attendant efficiencies and discoveries, is a primary motivation for requiring that research data be made available.  Consequently, accurate measurement of data reuse is particularly important.  Future work can improve on the current study and previous studies by considering and integrating all methods of data use attribution.  This holistic effort would include identifying citations to the paper that describes the data collection, mentions of the dataset identifier itself -- whether in full text, the references section, or supplementary information -- citations to the dataset as a first-class research object, and even mentions of the data collection investigators in acknowledgement sections.  The citations and mentions would need classification based on context to ensure they are in the context of data reuse.

Estimates of data reuse could then be used to estimate the impact of policy decisions.  For example, do embargo periods decrease the level of data reuse?  Do restrictive or poorly articulated licencing terms decrease data reuse?  Which types of data reuse are facilitate by robust data standards and which types are unaffected?

### other sources of citations

We note that while an open data citation boost is likely largely driven by citation for data reuse, open data may directly or indirectly inspire citations for other reasons as well.  The literature on "Open Access Citation Benefit" has articulated several possible sources of OA citation boost, including Selection Bias and Early View  (CRAIG _et. al._ 2007).  Inspired by this work, we suggest several possible sources for an "Open Data Citation Benefit":

1. *Data Reuse*. Papers with available datasets can be used in more ways than papers without data, and therefore may receive additional attributions upon published data reuse.
1. *Credibility Signalling*. The credibility of research findings may be higher for research papers with available data. Such papers may be preferentially chosen background citations and/or the foundation of additional research.
1. *Increased Visibility*. Citing authors may be more likely to encounter a research project with available data. More artifacts associated with a research project gives the project a larger footprint, increasing the likelihood that someone finds an aspect of the research. Links from data to the research paper may also increase the search ranking of the research paper.
1. *Early View*. When data is made available before a paper is published, some citations may accrue earlier than otherwise because research methods and findings are encountered prior to paper publication.
1. *Selection Bias*. Authors may be more likely to publish data for papers they judge to be their best quality work, because they are most proud or confident in the results. Alternatively, there is evidence that author self-selection bias may have a negative correlation with research quality in the case of Open Data [Wicherts 2011]: authors may be less willing to share details for their most important and visible research in order to maintain a competitive edge and avoid the upheaval of error detection. 

Importantly, almost all of these mechanisms are aligned with more efficient and effective science.  This means that fueling increased use, facilitated credibility determination, earlier access, improved discoverability, and a focus on best work through data availability is good for both investigators and the science community as a whole.  To address the main citation-related conflicting incentive, withholding data that might be important for finding weaknesses or faults, may require mandates.  Or, instead, perhaps the research community will quickly learn to associate withheld data with poor quality research.

Although the estimated citation boost in the current study is consistent with observed data reuse alone, other sources may also have contributed.  Further work, with additional data, will be needed to understand the relative contributions from each source.  For example, analyses within the pubication output of a sample of data-collecting authors could support measurement of selection bias.  Observing search behaviour of researchers, and the returned search hit results, could provide evidence of increased visibility due to data availability.  Hypothetical examples could be provided to authors to determine whether they would be systematically more likely to cite a paper with available data in situations where they are considering the credibility of the findings.

### tools, practices, and research

This study and associated work clearly demonstrate that improvements in tools and practice are needed to make impact tracking easier and more accurate, for day-to-day analysis as well as studies like this.  Researchers and research tools need libre access to the full-text of the research literature to support sophisticated text mining.  Citation databases are key building blocks of discovery: researchers need access to the services, and also to the code that support the services so they are empowered to add missing features.  Practice needs improvement too.  Currently data attribution practices are nonstandard, which inevitably leads to confusion and undercounting. 

Future work is needed to assess other important metrics of reuse, beyond citation.  The impact on practitioners, education, data journalism, and industry research are not captured by attibution patterns in the scientific literature.  Altmetrics indicators uncover discussions in social social media, syallabi, patents, and theses: analyzing such indicators for datasets would provide valuable evidence of reuse beyond the scientific literature.  As evaluators move away from assessing research based on journal impact factor and toward article-level metrics, post-publication metrics rates will become icreasingly important indicators of research impact.  

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

<p>Boettiger C (2012).
<EM>knitcitations: Citations for knitr markdown files</EM>.
R package version 0.1-0, <a href="https://github.com/cboettig/knitcitations">https://github.com/cboettig/knitcitations</a>.

<p>Bolker GRWIRscadcbB, Bonebakker L, Gentleman R, Liaw WHA, Lumley T, Maechler M, Magnusson A, Moeller S, Schwartz M and Venables B (2012).
<EM>gplots: Various R programming tools for plotting data</EM>.
R package version 2.11.0, <a href="http://CRAN.R-project.org/package=gplots">http://CRAN.R-project.org/package=gplots</a>.

<p>CRAIG I, PLUME A, MCVEIGH M, PRINGLE J and AMIN M (2007).
&ldquo;Do open access articles have greater citation impact?A critical review of the literature.&rdquo;
<EM>Journal of Informetrics</EM>, <B>1</B>(3), pp. 239&ndash;248.
ISSN 17511577, <a href="http://dx.doi.org/10.1016/j.joi.2007.04.001">http://dx.doi.org/10.1016/j.joi.2007.04.001</a>, <a href="http://dx.doi.org/10.1016/j.joi.2007.04.001">http://dx.doi.org/10.1016/j.joi.2007.04.001</a>.

<p>Dorch B (2012).
&ldquo;On the Citation Advantage of linking to data.&rdquo;
<EM>hprints</EM>.
<a href="http://hprints.org/hprints-00714715">http://hprints.org/hprints-00714715</a>.

<p>Fox J (2010).
<EM>polycor: Polychoric and Polyserial Correlations</EM>.
R package version 0.7-8, <a href="http://CRAN.R-project.org/package=polycor">http://CRAN.R-project.org/package=polycor</a>.

<p>Gleditsch NP and Strand H (2003).
&ldquo;Posting your data: will you be scooped or will you be famous?&rdquo;
<EM>International Studies Perspectives</EM>, <B>4</B>(1), pp. 89&ndash;97.
<a href="http://www.prio.no/Research-and-Publications/Publication/?oid=55406">http://www.prio.no/Research-and-Publications/Publication/?oid=55406</a>.

<p>Hajage D (2011).
<EM>ascii: Export R objects to several markup languages</EM>.
R package version 2.1, <a href="http://CRAN.R-project.org/package=ascii">http://CRAN.R-project.org/package=ascii</a>.

<p>Henneken EA and Accomazzi A (2011).
&ldquo;Linking to Data - Effect on Citation Rates in Astronomy.&rdquo;
<EM>arXiv</EM>, pp. 4.
1111.3618, <a href="http://arxiv.org/abs/1111.3618">http://arxiv.org/abs/1111.3618</a>.

<p>Ioannidis JPA, Allison DB, Ball CA, Coulibaly I, Cui X, Culhane AC, Falchi M, Furlanello C, Game L, Jurman G, Mangion J, Mehta T, Nitzberg M, Page GP, Petretto E and Noort Vv (2009).
&ldquo;Repeatability of published microarray gene expression analyses.&rdquo;
<EM>Nature genetics</EM>, <B>41</B>(2), pp. 149&ndash;55.
ISSN 1546-1718, <a href="http://dx.doi.org/10.1038/ng.295">http://dx.doi.org/10.1038/ng.295</a>, <a href="http://www.ncbi.nlm.nih.gov/pubmed/19174838">http://www.ncbi.nlm.nih.gov/pubmed/19174838</a>.

<p>Jr FEH (2012).
<EM>rms: Regression Modeling Strategies</EM>.
R package version 3.5-0, <a href="http://CRAN.R-project.org/package=rms">http://CRAN.R-project.org/package=rms</a>.

<p>Pienta AM, Alter GC and Lyle JA (2010).
&ldquo;The Enduring Value of Social Science Research: The Use and Reuse of Primary Research Data.&rdquo;
<EM>The Organisation, Economics and Policy of Scientific Research workshop</EM>.
<a href="http://hdl.handle.net/2027.42/78307">http://hdl.handle.net/2027.42/78307</a>.

<p>Piwowar HA, Day RB and Fridsma DS (2007).
&ldquo;Sharing detailed research data is associated with increased citation rate.&rdquo;
<EM>PLoS ONE</EM>, <B>2</B>(3).
<a href="http://dx.doi.org/10.1371/journal.pone.0000308">http://dx.doi.org/10.1371/journal.pone.0000308</a>.

<p>Piwowar HA, Carlson JD and Vision TJ (2011).
&ldquo;Beginning to track 1000 datasets from public repositories into the published literature.&rdquo;
<EM>Proceedings of the American Society for Information Science and Technology</EM>, <B>48</B>(1), pp. 1&ndash;4.
ISSN 00447870, <a href="http://dx.doi.org/10.1002/meet.2011.14504801337">http://dx.doi.org/10.1002/meet.2011.14504801337</a>, <a href="http://doi.wiley.com/10.1002/meet.2011.14504801337">http://doi.wiley.com/10.1002/meet.2011.14504801337</a>.

<p>Piwowar HA (2011).
&ldquo;Data from: Who shares? Who doesn't? Factors associated with openly archiving raw research data.&rdquo;
<EM>Dryad Digital Repository</EM>.
<a href="http://dx.doi.org/10.5061/dryad.mf1sd">http://dx.doi.org/10.5061/dryad.mf1sd</a>, <a href="http://datadryad.org/handle/10255/dryad.33858">http://datadryad.org/handle/10255/dryad.33858</a>.

<p>Piwowar HA (2011).
&ldquo;Who Shares? Who Doesn't? Factors Associated with Openly Archiving Raw Research Data.&rdquo;
<EM>PLoS ONE</EM>, <B>6</B>(7), pp. e18657.
ISSN 1932-6203, <a href="http://dx.doi.org/10.1371/journal.pone.0018657">http://dx.doi.org/10.1371/journal.pone.0018657</a>, <a href="http://dx.plos.org/10.1371/journal.pone.0018657">http://dx.plos.org/10.1371/journal.pone.0018657</a>.

<p>Sears J (2011).
&ldquo;Data Sharing Effect on Article Citation Rate in Paleoceanography - KomFor.&rdquo;
<a href="http://www.komfor.net/blog/unbenanntemitteilung">http://www.komfor.net/blog/unbenanntemitteilung</a>.

<p>Tenopir C, Allard S, Douglass K, Aydinoglu AU, Wu L, Read E, Manoff M and Frame M (2011).
&ldquo;Data sharing by scientists: practices and perceptions.&rdquo;
<EM>PLoS one</EM>, <B>6</B>(6), pp. e21101.
ISSN 1932-6203, <a href="http://dx.doi.org/10.1371/journal.pone.0021101">http://dx.doi.org/10.1371/journal.pone.0021101</a>, <a href="http://dx.plos.org/10.1371/journal.pone.0021101">http://dx.plos.org/10.1371/journal.pone.0021101</a>.

<p>Wickham H (2007).
&ldquo;Reshaping Data with the reshape Package.&rdquo;
<EM>Journal of Statistical Software</EM>, <B>21</B>(12), pp. 1&ndash;20.
<a href="http://www.jstatsoft.org/v21/i12/">http://www.jstatsoft.org/v21/i12/</a>.

<p>Wickham H (2009).
<EM>ggplot2: elegant graphics for data analysis</EM>.
Springer New York.
ISBN 978-0-387-98140-6, <a href="http://had.co.nz/ggplot2/book">http://had.co.nz/ggplot2/book</a>.

<p>Wickham H (2011).
&ldquo;The Split-Apply-Combine Strategy for Data Analysis.&rdquo;
<EM>Journal of Statistical Software</EM>, <B>40</B>(1), pp. 1&ndash;29.
<a href="http://www.jstatsoft.org/v40/i01/">http://www.jstatsoft.org/v40/i01/</a>.

<p>Xie Y (2012).
<EM>knitr: A general-purpose package for dynamic report generation in R</EM>.
R package version 0.6.3, <a href="http://CRAN.R-project.org/package=knitr">http://CRAN.R-project.org/package=knitr</a>.



References are available in a publicly-available [Mendeley group](http://www.mendeley.com/groups/2223913/11k-citation/papers/) 

## Abstract

(hasn't been updated to reflect all analyses)

### Background
Attribution upon reuse of scientific data is important to reward data creators and document the provenance of research findings.  In many fields, data attribution commonly takes the form of citation to the paper that described the primary data collection.  Previous studies have found that papers with publicly available datasets do indeed receive a higher number of citations than similar studies without available data.  However, previous studies were relatively small and did not control for many variables known to predict citation rate.  In this analysis we look at citation rates while controlling for many known citation predictors, and investigate whether the estimated citation boost is consistent with evidence of data reuse.

### Methods and Results
In a multivariate linear regression on <code class="knitr inline">1.0555 &times; 10<sup>4</sup></code> studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 
<code class="knitr inline">9</code>%
(95% confidence interval: [<code class="knitr inline">5</code>%
to <code class="knitr inline">13</code>%)
more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 
<code class="knitr inline">6</code>%
(95% CI: <code class="knitr inline">3</code>%
to <code class="knitr inline">11</code>%, 
n=<code class="knitr inline">138</code>)
of citations to those studies were in the context of data reuse attribution.

### Discussion


## Supplementary material


###Validation of automated method of detecting data availability

Our method of identifying which articles create gene expression microarray data made a nontrivial number of errors: about 10% of the articles it identified as creating gene expression microarray data do not in fact create gene expression datasets [cite].

The papers that are erroniously included in our subset to not create gene expression data, so they certainly don''t have associated archived datasets: all  erroniously included papers were automatically classified in the "no archived data" group. 

If it were true that these erroniously-included articles recieved many more or many fewer citations than other articles in the group, their inclusion could influence the findings of this study.  To verify our assumption that the influence of these mistakenly-included articles is in fact small, we manually reviewed a random 226 of the 11k (get exact number) articles.  Of these manually reviewed articles, 206 did indeed create gene expression microarray data, and 20 did not (but satisfied the boolean-search query for other reasons).  

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="number">206</span><span class="keyword">/</span><span class="number">226</span>
</pre></div><div class="output"><pre class="knitr">## [1] 0.9115
</pre></div></div></div>


Examining the citations of the  20 articles that did not create gene expression data revealed that these studies were cited less often than those that did create data: a mean of 26 citations compared to a mean of 32 citations.  The overall distribution of citations for articles that did not create gene expression data is closer to zero than the distribution of citations for articles that did create gene expression data.





We took steps to verify our assumption that the influence of articles erroniously identified these mistakenly-included articles is in fact small.  We began by manually reviewed a random 226 of the 11k (get exact number) articles to identify those which we were assuming had created gene expression microarray data but in fact had not.

We compared the distribution of those with errors to those without, calculated whether they were statitically different, and ran a regression with the known-correct sample only.









<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## nCitedBy    N=226, 4 Missing
## 
## +---------+---------------------------+---+--------+
## |         |                           |  N|nCitedBy|
## +---------+---------------------------+---+--------+
## |isCreated|    created-microarray-data|206|   31.86|
## |         |created-microarray-data-not| 20|   26.30|
## +---------+---------------------------+---+--------+
## |  Overall|                           |226|   31.37|
## +---------+---------------------------+---+--------+
</pre></div></div></div>






This difference, however, was found to be not statisitically significantly different at the p<0.05 level, using either a t-test on the log of the citation counts or a Wilcoxon rank sum test on the raw citation counts.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">ttest_citedby</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
## 	Welch Two Sample t-test
## 
## data:  nCitedBy by isCreated 
## t = 0.5747, df = 22.61, p-value = 0.5712
## alternative hypothesis: true difference in means is not equal to 0 
## 95 percent confidence interval:
##  -14.47  25.59 
## sample estimates:
##     mean in group created-microarray-data 
##                                     31.86 
## mean in group created-microarray-data-not 
##                                     26.30 
## 
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">ttest_log_citedby</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
## 	Welch Two Sample t-test
## 
## data:  log(1 + nCitedBy) by isCreated 
## t = 1.331, df = 21.77, p-value = 0.1968
## alternative hypothesis: true difference in means is not equal to 0 
## 95 percent confidence interval:
##  -0.2003  0.9175 
## sample estimates:
##     mean in group created-microarray-data 
##                                     2.991 
## mean in group created-microarray-data-not 
##                                     2.632 
## 
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">wilcox_citedby</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  nCitedBy by isCreated 
## W = 2440, p-value = 0.1733
## alternative hypothesis: true location shift is not equal to 0 
## 
</pre></div></div></div>


To confirm that the erroniously-included articles were not driving the findings about the citation relationship with data availability, we ran a multivariate regression analysis on the subsample of 206 articles that we manually determined did in fact generate gene expression microarray data.  The estimated effect is statistically significant and similar to the findings from the whole sample.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">annotated_merged_created</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                           | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |-------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)             | 2.00   | 83.82  | 41.91   | 73.91   | 0.00   |
## | rcs(journal.impact.factor.tr, 3)          | 2.00   | 18.69  | 9.35    | 16.48   | 0.00   |
## | rcs(num.authors.tr, 3)                    | 2.00   | 4.03   | 2.01    | 3.55    | 0.03   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3) | 2.00   | 4.79   | 2.40    | 4.22    | 0.02   |
## | factor(country.usa)                       | 1.00   | 0.05   | 0.05    | 0.09    | 0.77   |
## | factor(dataset.in.geo.or.ae)              | 1.00   | 5.68   | 5.68    | 10.03   | 0.00   |
## | Residuals                                 | 177.00 | 100.37 | 0.57    |         |        |
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">annotated_merged_created</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.32  1.11   1.57 0.002
</pre></div></div></div>


# about this doc
 * author of this file: Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Yihui Xie for knitr and Carl Boettiger for his clear examples of this literate programming framework. 
 * Generated on <code class="knitr inline">Wed Jul 25 11:49:03 2012</code>

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


