




# knitr citation11k manuscript
 * author of this file: Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Yihui Xie for knitr and Carl Boettiger for his clear examples of this literate programming framework. 
 * Generated on <code class="knitr inline">Mon Jul 23 12:13:08 2012</code>

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




The primary analysis in this paper examines the citation count of a gene expression microarray experiment, relative to availability of the experiment's data.

The sample of microarray experiments used in the current analysis was previously determined (Piwowar 2011 PLoS ONE, data from Piwowar 2011 Dryad).  Briefly, a full-text query uncovered papers with wet-lab methods related to gene expression microarray data collection.  The full-text query was characterized with high precision (90%, 95% confidence interval 86% to 93%) and a moderate recall (56%, 52% to 61%) for this task.  Running the query in PubMed Central, HighWire Press, and Google Scholar identified <code class="knitr inline">11603</code> distinct gene expression microarray papers.  The papers were published between 2000 and 2009.

The independent variable of interest is the availability of gene expression microarray data.  Data availability had been previously determined for our sample articles in Piwowar 2011, so we directly reused that dataset [Piwowar Dryad 2011].  Datasets were considered available if they were discovered in either of the two predominant gene expression microarray databases: NCBI's Gene Expression Omnibus (GEO), and EBI's ArrayExpress.

"An earlier evaluation found that querying GEO and ArrayExpress with article PubMed identifiers located a representative 77% of all associated publicly available datasets [Piwowar 2010]. [We] used the same method for finding datasets associated with published articles in this study: [we] queried GEO for links to the PubMed identifiers in the analysis sample using the “pubmed_gds [filter]” and queried ArrayExpress by searching for each PubMed identifier in a downloaded copy of the ArrayExpress database. Articles linked from a dataset in either of these two centralized repositories were considered to have [publicly available data] for the endpoint of this study, and those without such a link were considered not to have [available] data." [Piwowar 2011]

Piwowar 2011 included 124 attributes for each of the gene expression microarray studies in our sample.  We used a subset of these --attributes previously shown or suspected to correlate with citation rate:




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




Citation counts for <code class="knitr inline">10555</code> papers were exported from Scopus in November 2011. 


####Primary analysis

The analysis included several multivariate linear regressions to evaluate the association between the public availability of a study's microarray data and the number of citations (after log transformation) it received. 

We began with a simple correlations between number of citations and other variables, using Pearson correlations for numberic variables and polyserial correlations for binary and factor covariates.  We also calculated correlations between data availability and other variables to investigate collinearity. 







The main analysis was run across all papers in the sample with many  covariates known or found (in the correlation analysis above) to correlate with citation rate.  Covariates included the date of publication, the journal which published the study, the journal impact factor, the journal citation halflife, the number of articles published by the journal, the journal's open access policy, whether the journal is considered a core clinical journal by MEDLINE, the number of authors of the study, the country of the corresponding author, the citation score of the institution of the corresponding author, the publishing experience of the first and last author, and the subject of the study itself.  

Publishing experience was characterized by the number of years since the author's first paper in PubMed, the number of papers they have published, and the number of citations they have received in PubMed Central, estimated using Authority clusters as described in [Piwowar 2011].  The subject of the study was characterized by whether the paper was classified as cancer, animals, or plants.  For more information on study attributes see [Piwowar 2011].

Citation count was log transformed to be consistent with prior literature.  Other count variables square-root transformed.  Continuous variables were represented with 3-part spines in the regression, using the rcs function in the R rms library.

The independent variable of interest was represented as a 0 or 1 in the regression, describing whether or not associated data had been found in the data repositories.  The relationship of the data availability variable to  citation count was described with 95% confidence intervals after raising the regression coefficient to the power of e (since the log of the number of citations was used in the regression).




Because publication date is such a strong correlate with both citation rate and data availability, we performed another analysis which stratified the sample by publication year, in addition to including publication date as a covariate.  Because the yearly regressions included fewer datapoints than the full regression, they supported a smaller number of covarites.  The yearly regressions included  date of publication, the journal which published the study, the journal impact factor, the journal's open access policy, the number of authors of the study, the citation score of the institution of the corresponding author, the previous number of PubMed Central citations recieved by the first and last author, whether the study was on cancer, and whether it used animals.








#### Comparison to Piwowar et al 2007

We ran two modified analyses to attempt to reproduce the findings of [Piwowar 2007].  First, we used a subset with roughly the same inclusion criteria as Piwowar 2007 -- studies on cancer, with humans, published prior to 2003 -- and the same regression coefficients: publication date, impact factor, and whether the corresponding author's address is in the USA.




We followed that with a second regression that included several additional important covariates:  number of authors and number of previous citations by the last author.




####Manual review of citation context

We manually reviewed the citation context of some of these papers to determine how many of the citations were in the context of data reuse.

We randomly selected 100 datasets deposited in GEO in 2005.  For each dataset, we located the data collection article within ISI Web of Science based on its title and authors, and exported the list of all articles that cited this data collection article. This list of all citations was processed to subselect  50 random  citations, stratified by  the totalnumber of times the data collection article had been cited.  

Manual review was performed for each instance of potential data reuse.  We located the article full text, read the relevant sections of the papers, and manually determined if the data from the associated dataset had been reused within the study.  [Beginning to Track]




###Data reuse patterns from accession number attribution

####Data collection

We collected a separate dataset to study reuse patterns because identifying data reuse from citations requires time-consuming classification of citation context.

Datasets are sometimes attributed directly, through mention of the dataset identifier or accession number in the full-text of a research paper.  Third-party dataset resuse can be estimated from these mentions by excluding papers that were authored by members of the dataset collection team.

We used the NCBI eUtils library and custom Python code to obtain a list of all datasets deposited into the Gene Expression Omnibus data repository, then searched PubMed Central for each of these dataset identifiers (using queries of the form "'GSEnnnn' OR 'GSE nnnn'"). For each hit we recorded the PubMed Central ID of the paper that mentioned the accession number, the year of paper publication, and the author surnames.  We also recorded the dataset accession number, the year of dataset publication, and the investigator names associated with the dataset record.

####Statistical analysis

We excluded papers with author surnames in common with those authors who deposited the original dataset, as described in [Beginning to Track.]  

PubMed Central contains only a subset of papers recorded in PubMed. As described in [Beginning to Track.], to extrapolate from the number of data reuses in PubMed Central to all possible data reuses in PubMed, we divided the yearly number of hits by the ratio of papers in PMC to papers in PubMed for this domain (domain was measured as the number of articles indexed with the MeSH term “gene expression profiling”).  

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">##       [,1]       
##  [1,] "2000: 18%"
##  [2,] "2001: 18%"
##  [3,] "2002: 15%"
##  [4,] "2003: 16%"
##  [5,] "2004: 18%"
##  [6,] "2005: 18%"
##  [7,] "2006: 20%"
##  [8,] "2007: 23%"
##  [9,] "2008: 33%"
## [10,] "2009: 37%"
## [11,] "2010: 36%"
## [12,] "2011: 10%"
</pre></div></div></div>


We retained reuse candidates for papers published between 2001 and 2010: 2011 was within 12 months of data collection, and had a dramatically lower proportion of papers in PubMed Central because the NIH archiving requirements permit a 12 month embargo.

To understand our findings on a per-dataset basis, we stratified reuse estimates by year of dataset submission and normalized our reuse findings by the number of datasets deposited that year:

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">##    year num_gse_ids
## 2  2001          13
## 3  2002          92
## 4  2003         523
## 5  2004         847
## 6  2005        1393
## 7  2006        1814
## 8  2007        2711
## 9  2008        3279
## 10 2009        4313
</pre></div></div></div>








### Data and script availability

Statistical analyses were last run on <code class="knitr inline">Mon Jul 23 12:13:45 2012</code> with <code class="knitr inline">R version 2.15.1 (2012-06-22)</code>.  Packages used include reshape2(Wickham, 2007), plyr(Wickham, 2011), rms(Jr, 2012), polycor(Fox, 2010), ascii(Hajage, 2011), ggplot2(Wickham, 2009), gplots(Bolker _et. al._ 2012), knitr(Xie, 2012), and knitcitations(Boettiger, 2012). P-values are two-tailed.  

Raw data and statistical scripts are available in the Dryad data repository at [url and citation to be determined and included upon article acceptance].  Data collection scripts are at [GitHub pypub.  Heather, push changes!]

The text Markdown version of this manuscript with interleaved statistical scripts using knitr (Xie, 2012) is also included in Dryad and at GitHub (https://github.com/hpiwowar/citation11k)[https://github.com/hpiwowar/citation11k].

## Results

### Relationship between data availability and citation

#### Description of cohort

We retained <code class="knitr inline">10557</code> articles published between 2001 and 2009 that had been identified as collecting gene expression microarray data.




The composition of this sample is spread across <code class="knitr inline">667</code> journals, with the top 12 journals accounting for <code class="knitr inline">30</code>% of the papers.

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


Collecting gene expression micorarray data became more popular over time: <code class="knitr inline">2</code>% of articles in our sample were published in 2001, compared to <code class="knitr inline">15</code> % in 2009.

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
</pre></div></div></div>


Searching for associated datasets in the GEO and ArrayExpress repository uncovered links between <code class="knitr inline">0.248</code>% of papers in this sample and publicly available data.  

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
##    0    1 
## 7940 2617 
</pre></div><div class="source"><pre class="knitr">
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
</pre></div></div></div>



Articles published more recently were more likely to have associated datasets.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/sharing_over_time.png" class="plot" /></div></div>


The articles in our sample were cited between <code class="knitr inline">0</code> and <code class="knitr inline">2643</code> times, with an average of <code class="knitr inline">31.5004</code> citations per paper and a median of <code class="knitr inline">16</code>.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.5    35.0  2640.0 
</pre></div></div></div>


Without accounting for any confounding factors, the mean number of citations between papers with available data and those without are the same, and the distributions of citations between these two groups.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span> <span class="symbol">summary</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
</pre></div></div></div>



The number of citations a paper has recieved is strongly correlated to the date it was published: older papers have had more time to accumulate citations.  Because data archiving was relatively infrequent for articles published earlier, a difference in citation behaviour may be confounded with publication date.

Indeed, we saw that for any given publication date, papers with associated data recieved more citations than those without.Furthermore, the distribution of citations for older papers with available data is centered at a higher median than citations for papers without data available.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/citationDist.png" class="plot" /></div></div>


#### Correlations

Other factors have been previously shown to be correlated with citation rate, including number of authors, author experience, author institution, open access status, and subject area [cite]. 

Cited by correlations.  It must be remembered that these are univariate correlations and so should not be interpreted without additional context.  For example, most open access publications were published recently, so relative to non-open access publications in this sample they have had less time to accumulate citations.

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## | nCitedBy.log                                  | 1     |
## | journal.impact.factor.tr                      | 0.45  |
## | last.author.num.prev.pmc.cites.tr             | 0.3   |
## | journal.num.articles.2008.tr                  | 0.25  |
## | last.author.year.first.pub.ago.tr             | 0.24  |
## | institution.mean.norm.citation.score          | 0.24  |
## | first.author.num.prev.pmc.cites.tr            | 0.24  |
## | journal.microarray.creating.count.tr          | 0.23  |
## | institution.harvard                           | 0.22  |
## | first.author.year.first.pub.ago.tr            | 0.22  |
## | institution.stanford                          | 0.21  |
## | country.usa                                   | 0.18  |
## | num.authors.tr                                | 0.17  |
## | pubmed.is.core.clinical.journal               | 0.17  |
## | last.author.num.prev.pubs.tr                  | 0.15  |
## | institution.nci                               | 0.14  |
## | pubmed.is.humans                              | 0.08  |
## | pubmed.is.funded.nih                          | 0.07  |
## | has.R.funding                                 | 0.07  |
## | pubmed.is.plants                              | 0.07  |
## | first.author.num.prev.pubs.tr                 | 0.06  |
## | pubmed.is.cancer                              | 0.06  |
## | nih.cumulative.years.tr                       | 0.03  |
## | country.uk                                    | 0.03  |
## | num.grants.via.nih.tr                         | 0.02  |
## | nih.sum.avg.dollars.tr                        | 0.01  |
## | pubmed.is.bacteria                            | 0.01  |
## | dataset.in.geo.or.ae                          | 0.01  |
## | last.author.num.prev.microarray.creations.tr  | 0.01  |
## | pubmed.is.cultured.cells                      | -0.01 |
## | first.author.num.prev.microarray.creations.tr | -0.01 |
## | pubmed.is.geo.reuse                           | -0.01 |
## | institution.is.govnt                          | -0.01 |
## | country.australia                             | -0.02 |
## | pubmed.is.funded.nih.intramural               | -0.03 |
## | country.canada                                | -0.05 |
## | institution.rank                              | -0.06 |
## | last.author.female                            | -0.07 |
## | first.author.female                           | -0.08 |
## | country.japan                                 | -0.1  |
## | pubmed.is.animals                             | -0.11 |
## | country.china                                 | -0.19 |
## | country.korea                                 | -0.26 |
## | pubmed.is.open.access                         | -0.3  |
## | pubmed.year.published                         | -0.58 |
## | pubmed.date.in.pubmed                         | -0.59 |
</pre></div></div></div>


Data availability correlations:

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## | dataset.in.geo.or.ae                          | 1     |
## | institution.stanford                          | 0.34  |
## | pubmed.is.open.access                         | 0.29  |
## | pubmed.date.in.pubmed                         | 0.28  |
## | pubmed.year.published                         | 0.27  |
## | journal.microarray.creating.count.tr          | 0.19  |
## | pubmed.is.funded.nih                          | 0.15  |
## | pubmed.is.funded.nih.intramural               | 0.15  |
## | pubmed.is.bacteria                            | 0.14  |
## | journal.impact.factor.tr                      | 0.13  |
## | num.grants.via.nih.tr                         | 0.11  |
## | nih.cumulative.years.tr                       | 0.11  |
## | institution.mean.norm.citation.score          | 0.1   |
## | has.R.funding                                 | 0.1   |
## | last.author.num.prev.microarray.creations.tr  | 0.1   |
## | pubmed.is.geo.reuse                           | 0.09  |
## | last.author.num.prev.pmc.cites.tr             | 0.09  |
## | nih.sum.avg.dollars.tr                        | 0.08  |
## | institution.is.govnt                          | 0.07  |
## | num.authors.tr                                | 0.06  |
## | pubmed.is.plants                              | 0.06  |
## | first.author.num.prev.microarray.creations.tr | 0.06  |
## | country.canada                                | 0.06  |
## | country.usa                                   | 0.05  |
## | country.uk                                    | 0.05  |
## | first.author.num.prev.pmc.cites.tr            | 0.04  |
## | pubmed.is.animals                             | 0.03  |
## | first.author.female                           | 0.03  |
## | last.author.female                            | 0.02  |
## | nCitedBy.log                                  | 0.01  |
## | country.australia                             | 0     |
## | last.author.num.prev.pubs.tr                  | -0.01 |
## | institution.rank                              | -0.02 |
## | first.author.num.prev.pubs.tr                 | -0.02 |
## | last.author.year.first.pub.ago.tr             | -0.03 |
## | journal.num.articles.2008.tr                  | -0.03 |
## | pubmed.is.core.clinical.journal               | -0.04 |
## | institution.harvard                           | -0.05 |
## | first.author.year.first.pub.ago.tr            | -0.07 |
## | pubmed.is.humans                              | -0.13 |
## | pubmed.is.cultured.cells                      | -0.15 |
## | pubmed.is.cancer                              | -0.16 |
## | institution.nci                               | -0.18 |
## | country.japan                                 | -0.21 |
## | country.china                                 | -0.22 |
## | country.korea                                 | -0.25 |
</pre></div></div></div>


#### Multivariate regression
 
Multivariate regression analysis can be useful to identify the relationship between data availability and citation rate, independently of other variables.


<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## |                                              | Df      | Sum Sq  | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|---------|---------|---------|---------|--------|
## | rcs(journal.impact.factor.tr, 3)             | 2.00    | 1134.56 | 567.28  | 1128.24 | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1439.09 | 719.55  | 1431.07 | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00    | 4.31    | 2.15    | 4.29    | 0.01   |
## | rcs(journal.cited.halflife, 3)               | 2.00    | 11.54   | 5.77    | 11.48   | 0.00   |
## | factor(pubmed.is.open.access)                | 1.00    | 0.15    | 0.15    | 0.29    | 0.59   |
## | rcs(num.authors.tr, 3)                       | 2.00    | 68.61   | 34.31   | 68.23   | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 1.05    | 0.52    | 1.04    | 0.35   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 53.07   | 26.54   | 52.77   | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 1.70    | 0.85    | 1.69    | 0.19   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 2.22    | 1.11    | 2.20    | 0.11   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 28.92   | 14.46   | 28.76   | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 1.82    | 0.91    | 1.81    | 0.16   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 0.36    | 0.18    | 0.36    | 0.70   |
## | factor(country.usa)                          | 1.00    | 0.97    | 0.97    | 1.92    | 0.17   |
## | factor(country.china)                        | 1.00    | 1.62    | 1.62    | 3.22    | 0.07   |
## | factor(country.korea)                        | 1.00    | 1.89    | 1.89    | 3.76    | 0.05   |
## | factor(pubmed.is.cancer)                     | 1.00    | 13.37   | 13.37   | 26.60   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00    | 13.63   | 13.63   | 27.11   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 14.24   | 14.24   | 28.32   | 0.00   |
## | factor(pubmed.is.core.clinical.journal)      | 1.00    | 4.53    | 4.53    | 9.02    | 0.00   |
## | factor(pubmed_journal)                       | 422.00  | 364.83  | 0.86    | 1.72    | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 9.47    | 9.47    | 18.84   | 0.00   |
## | Residuals                                    | 3919.00 | 1970.48 | 0.50    |         |        |
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  1.05   1.13 0
</pre></div></div></div>


In this analysis, we found many of the variables were independently associated with citation rate, including number of authors, journal impact factor, the journal itself, the date of publication, the number of previous citations of the fist and last author, the number of previous publications of the last author, whether the paper was about animals or plants, and whether the data was made publicly available.

Estimate of the independent increase of citations due to data availability is  
<code class="knitr inline">9</code>%
with 95% confidence intervals [<code class="knitr inline">5</code>%
, <code class="knitr inline">13</code>% ]
(p=<code class="knitr inline">0.00</code>)

Because publication date is such as strong correlate with both citation rate and data availability, we also ran regressions for each publication year individually (with a subset of the covariates).

The estimate of citation boost was different for different years of publication.

The estimates of citation boost for papers published in each year, with 95% confidence intervals:

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">estimates_by_year</span>
</pre></div><div class="output"><pre class="knitr">##           year                          param  est ciLow ciHigh     p
## Estimate  2001 factor(dataset.in.geo.or.ae).L 1.37  0.84   2.25 0.212
## Estimate1 2002 factor(dataset.in.geo.or.ae).L 1.16  0.89   1.50 0.268
## Estimate2 2003 factor(dataset.in.geo.or.ae).L 1.19  1.01   1.41 0.044
## Estimate3 2004 factor(dataset.in.geo.or.ae).L 1.30  1.15   1.47 0.000
## Estimate4 2005 factor(dataset.in.geo.or.ae).L 1.32  1.19   1.47 0.000
## Estimate5 2006 factor(dataset.in.geo.or.ae).L 1.15  1.04   1.27 0.005
## Estimate6 2007 factor(dataset.in.geo.or.ae).L 1.08  1.00   1.17 0.055
## Estimate7 2008 factor(dataset.in.geo.or.ae).L 1.08  0.99   1.18 0.077
## Estimate8 2009 factor(dataset.in.geo.or.ae).L 1.01  0.92   1.10 0.865
</pre></div></div></div>


<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_regressionEstimatesByYear.png" class="plot" /></div></div>


Our method of identifying which articles create gene expression microarray data made a nontrivial number of errors: about 10% of the articles it identified as creating gene expression microarray data do not in fact create gene expression datasets [cite].

We confirmed the inclusion of these had a small influence on the outcomes of our study. The overall distribution of citations for articles that did not create gene expression data is closer to zero than the distribution of citations for articles that did create gene expression data, but was found to be not statisitically significantly different.  Furthermore, a subanalysis on the manually-curated articles was similar to the findings from the whole sample.

### Comparison to Piwowar et al 2007

Our estimate of citation boost, <code class="knitr inline">9</code>% as per the multivariate regression, is notably smaller than the 69% (95% confidence intervals of 18 to 143%) citation advantage found by Piwowar et al 2007], even though both studies looked at publicly available gene expression microarray data. There are several possible reasons for this difference.  

First, Piwowar et al 2007 concentrated on datasets from high-impact studies: human cancer microarray trials published in the early years of microarray analysis (between 1999 and 2003), whereas the current study included gene expression microarray data studies on any subject published between 2001 and 2009. Second, because the Piwowar et al 2007 sample was small, the previous analysis included only a few covariates: publication date, journal impact factor, and country of the corresponding author.

We attempted to reproduce the prior analysis with the current data points.  Limiting the inclusion criteria to datasets with MeSH terms "human" and "cancer", and to papers published between 2001 and 2003, reduced the cohort to 308 papers.  Running this subsample with covariates used in the Piwowar 2007 paper resulted in a comperable estimate to the 2007 paper: a citation increase of 47% (95% confidence intervals of 6% to 103%).

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                  | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)    | 2.00   | 5.33   | 2.67    | 3.27    | 0.04   |
## | rcs(journal.impact.factor.tr, 3) | 2.00   | 68.81  | 34.40   | 42.23   | 0.00   |
## | factor(country.usa)              | 1.00   | 0.06   | 0.06    | 0.07    | 0.79   |
## | factor(dataset.in.geo.or.ae)     | 1.00   | 4.35   | 4.35    | 5.34    | 0.02   |
## | Residuals                        | 294.00 | 239.53 | 0.81    |         |        |
</pre></div><div class="source"><pre class="knitr">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.47  1.06   2.03 0.021
</pre></div></div></div>


The subsample of 308 papers was large enough to include a few additional covariates: number of authors and citation history of the last author.  Including these important covariates decreased the estimated effect to 18% with a confidence interval that spanned a *loss* of 17% citations to a boost of 66%. 

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfit_prev_more</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                           | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |-------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)             | 2.00   | 5.55   | 2.78    | 3.60    | 0.03   |
## | rcs(journal.impact.factor.tr, 3)          | 2.00   | 66.95  | 33.47   | 43.35   | 0.00   |
## | rcs(num.authors.tr, 3)                    | 2.00   | 12.97  | 6.49    | 8.40    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3) | 2.00   | 9.46   | 4.73    | 6.12    | 0.00   |
## | factor(country.usa)                       | 1.00   | 0.13   | 0.13    | 0.17    | 0.68   |
## | factor(dataset.in.geo.or.ae)              | 1.00   | 0.66   | 0.66    | 0.85    | 0.36   |
## | Residuals                                 | 283.00 | 218.53 | 0.77    |         |        |
</pre></div><div class="source"><pre class="knitr">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfit_prev_more</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.18  0.83   1.66 0.357
</pre></div></div></div>




### Manual review of citation context

To provide evidence on the proportion of the citation boost that may be caused by data reuse, we report the observed frequency with which papers that shared gene expression microarray data were cited in the context of data attribution.  Citations to papers that describe 100 datasets deposited into GEO in 2005 were collected using Web of Science.  A sample of 138 citations were randomly selected and manually reviewed.  

Of the <code class="knitr inline">138</code> reviewed citations to articles with archived gene expression data, <code class="knitr inline">8</code> were in the context of data reuse
<code class="knitr inline">6</code>%
with 95% confidence intervals [<code class="knitr inline">3</code>%
, <code class="knitr inline">11</code>% ]


### Data reuse patterns from accession number attribution


Finally, to provide evidence on the timeline of data attribution, we report  data reuse activity attributed through direct dataset mentions.  This is only a subset of all data reuse (it doesn't include attribution through citations, for example), but the patterns of reuse are likely similar across methods of attribution.

We found <code class="knitr inline">9274</code> mentions of GEO datasets in papers published between 2000 and 2010 within PubMed Central, including <!-- round(sum(subset(dfCountReusePapers, thirdPartyReuse==TRUE, count)), 0) --> by author teams that do not overlap those that deposited the data.  Extrapolating this to all of PubMed, we estimate there may be about <!-- round(sum(subset(dfCountReusePapers, thirdPartyReuse==TRUE, extrap)), 0)--> third-party reuses of GEO data attributed through accession numbers in all of PubMed, in papers published between 2000 and 2010.

The number of reuse papers started to grow rapidly only after several years of dataset publication.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">dfCountUnique3rdpartyPapers</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfMentions</span><span class="keyword">,</span> <span class="symbol">thirdPartyReuse</span>==<span class="number">TRUE</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">.</span><span class="keyword">(</span><span class="symbol">paperPublishedYear</span><span class="keyword">,</span> <span class="symbol">pmc_pmid_ratio</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">summarise</span><span class="keyword">,</span> <span class="argument">count</span><span class="argument">=</span><span class="functioncall">length</span><span class="keyword">(</span><span class="functioncall">unique</span><span class="keyword">(</span><span class="symbol">reuse_pmcid</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">$</span><span class="symbol">extrap</span> <span class="assignement">=</span> <span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">,</span> <span class="symbol">count</span><span class="keyword">/</span><span class="symbol">pmc_pmid_ratio</span><span class="keyword">)</span>

<span class="symbol">dfCountUnique3rdpartyPapers</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">,</span> <span class="functioncall">.</span><span class="keyword">(</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">transform</span><span class="keyword">,</span> <span class="argument">cumul_extrap</span><span class="argument">=</span><span class="functioncall">cumsum</span><span class="keyword">(</span><span class="symbol">extrap</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">dfCountUnique3rdpartyPapers</span> <span class="assignement">=</span> <span class="functioncall">merge</span><span class="keyword">(</span><span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">,</span> <span class="symbol">dfPubmedGseCount</span><span class="keyword">,</span> <span class="argument">by.x</span><span class="argument">=</span><span class="string">"paperPublishedYear"</span><span class="keyword">,</span> <span class="argument">by.y</span><span class="argument">=</span><span class="string">"year"</span><span class="keyword">)</span>

<span class="symbol">dfCountUnique3rdpartyPapers</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">,</span> <span class="functioncall">.</span><span class="keyword">(</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">transform</span><span class="keyword">,</span> <span class="argument">cumul_gse</span><span class="argument">=</span><span class="functioncall">cumsum</span><span class="keyword">(</span><span class="symbol">num_gse_ids</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="comment">#not log</span>
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCountUnique3rdpartyPapers</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">paperPublishedYear</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="symbol">cumul_gse</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_point</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_line</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"datasets\n"</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">"\nyear of data or paper publication"</span><span class="keyword">,</span> <span class="argument">limits</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">2001</span><span class="keyword">,</span> <span class="number">2010</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">"Cumulative count\n"</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="functioncall">comma_format</span><span class="keyword">(</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">scale_color_hue</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">""</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">theme_bw</span><span class="keyword">(</span><span class="argument">base_size</span><span class="argument">=</span><span class="number">16</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">geom_line</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">y</span><span class="argument">=</span><span class="symbol">cumul_extrap</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="string">"reuse papers,\nattribution by accession"</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_point</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">y</span><span class="argument">=</span><span class="symbol">cumul_extrap</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div></div><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/growthOfReusePapers.png" class="plot" /></div></div>


In recent years both the number of datasets and the number of reuse papers are growing rapidly, at about the same rate.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/growthOfReusePapersLog.png" class="plot" /></div></div>


Almost all reuse papers by authors who collect and archive a given dataset (as estimated by surname overlap with data submission record) are published within two years of dataset publication.  This pattern contrasts sharply with data reuse by outside authors.

A panel displays the reuse of data published in the panel year, vs an x-axis of paper publication date.
<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_authorVThirdParty.png" class="plot" /></div></div>



Figure A shows the cumulative number of third-party reuse papers, illustrating growth over time.  Separate lines are displayed for different dataset publication years.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_accessionReuse_cumulative.png" class="plot" /></div></div>


Because the number of datasets published has grown dramatically with time, it is interesting to see the cumulative number of third-party reuses normalized by the number of datasets deposited each year.  Early years, 2001-2002, had relatively few data deposits but they have received a large amount of reuse.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_accessionReuse_cumulative_normalized.png" class="plot" /></div></div>


We exclude the early years from the next plot to examine the pattern of data reuse once gene expression datasets became more common.  Figure B shows cumulative third-party reuse, normalized by number of datasets deposited each year, plotted as elapsed years since data publication.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_accessionReuse_cumulative_normalized_2003_elapsed.png" class="plot" /></div></div>



The number of datasets used in a reuse paper was found to increase over time. Each panel reports analysis for reuse papers published that year, reusing data from any year.  In 2002-2004 almost all reuse papers only used one or two datasets.  By 2010, 25% of reuse papers used 3 or more datasets. 

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/numberDatasetsInReusePaper.png" class="plot" /></div></div>


Reuse was not limited to just a few papers. Almost all datasets published in 2001 and 2002 have been reused at least once.  Newer datasets have been used less often, but we observed reuse of at least 20% of the datasets deposited in 2007.  The actual rate, across all methods of attribution and extrapolated to all of PubMed, is likely much higher. 

Distribution of reuse across individual datasets.  One panel for every year of reuse study publication.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/display_distAcrossDatasets.png" class="plot" /></div></div>


Finally, what is the distribution of the age of datasets used by data reuse studies?  We found the authors of data reuse papers are most likely to use data that is 3-6 years old by the time their paper is published, normalized for how many datasets were deposited each year.  

One panel for every year of publication, with papers published that year.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/distOfDatasetAge.png" class="plot" /></div></div>





## Discussion





Studies with publicly available datasets received more citations than similar studies without available datasets, even after controlling for many variables known to influence citation rate.  We found the open data citation boost for this sample to be <code class="knitr inline">9</code>% overall
(95% confidence interval: [<code class="knitr inline">5</code>%
to <code class="knitr inline">13</code>%).  The specific boost depended heavily on the year the dataset was made available.  Datasets deposited in the last few years received no (or few) additional citations, while those deposited in 2004-2005 showed a clear boost of about 30% (confidence intervals 15% to 48%).  Older datasets also received a boost, though the confidence intervals were too wide to be very informative.

These new estimates are lower than those found by previous studies.  The most similar study, Piwowar 2007, found a citation boost of 69% (95% confidence intervals of 18 to 143%) for human cancer gene expression microarray studies published before 2003.  The high estimate of Piwowar 2007 could be because it analyzed particularly impactful datasets (clinically relevant, released early in the history of microarray analysis). Alternatively, the estimate be artifically high because the analysis in Piwowar 2007 omitted several important citation covariates (e.g. number of authors).  To investigate these possibilities we conducted a secondary analysis with our much larger dataset, roughly reproducing the inclusion criteria and methods for Piwowar 2007.  We found a similar citation boost to Piwowar 2007 with this restricted dataset and analysis (a citation increase of 47%, 95% CI 6% to 103%).  When we added two covariates to this analysis -- number of authors and citation history of last author -- the citation boost estimate decreased to 18% with wide confidence intervals (a *loss* of 17% citations to a boost of 66%).  This reinforces the importance of accounting for covariates to calculate accurate estimates, and the need for large samples to support full analysis: the 69% estimate is probably too high, even for its high-impact sample.

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

We note that while an open data citation boost is likely largely driven by citation for data reuse, open data may directly or indirectly inspire citations for other reasons as well.  The literature on "Open Access Citation Benefit" has articulated several possible sources of OA citation boost, including Selection Bias and Early View ["Craig2007"].  Inspired by this work, we suggest several possible sources for an "Open Data Citation Benefit":

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

See references in [Mendeley library](http://www.mendeley.com/groups/2223913/11k-citation/papers/) 

- Barrett, Dennis B Troup, Stephen E Wilhite, Pierre Ledoux, Carlos Evangelista, Irene F Kim, Maxim Tomashevsky, Kimberly A Marshall, Katherine H Phillippy, Patti M Sherman, Rolf N Muertter, Michelle Holko, Oluwabukunmi Ayanbule, Andrey Yefanov, Alexandra Soboleva (2011) NCBI GEO: archive for functional genomics data sets--10 years on.   Nucleic acids research 39 (Database issue) p. D1005-10
- Bollen J, Van de Sompel H, Hagberg A, Chute R (2009) A Principal Component Analysis of 39 Scientific Impact Measures. PLoS ONE 4(6): e6022. doi:10.1371/journal.pone.0006022
- Chavan, V. S., & Ingwersen, P. (2009). Towards a data publishing framework for primary biodiversity data: challenges and potentials for the biodiversity informatics community. BMC Bioinformatics, 10(Suppl 14), S2. Retrieved from http://www.biomedcentral.com/1471-2105/10/S14/S2
- Dudley JT, Robert Tibshirani, Tarangini Deshpande, Atul J Butte (2009) Disease signatures are robust across tissues and experiments.  Molecular systems biology 5 p. 307
- Ibanez, A., Larrañaga, P. and Bielza, C.  Bioinformatics, 25, 3303-3309 (2009). "Predicting citation count of Bioinformatics papers within four years of publication." http://bioinformatics.oxfordjournals.org/content/25/24/3303.full
- Ochsner, S. A., Steffen, D. L., Stoeckert, C. J., & McKenna, N. J. (2008). Much room for improvement in deposition rates of expression microarray datasets. Nature Methods. Retrieved from http://dx.doi.org/10.1038/nmeth1208-991
- Piwowar HA (2011) Who shares? Who doesn’t? Factors associated with openly archiving raw research data. PLoS ONE 6(7): e18657. doi:10.1371/journal.pone.0018657
- Piwowar HA (2011) Data from: Who shares? Who doesn’t? Factors associated with openly archiving raw research data. Dryad Digital Repository. doi:10.5061/dryad.mf1sd
- Piwowar, Chapman (2010)  Recall and bias of retrieving gene expression microarray datasets through PubMed identifiers  Journal of Biomedical Discovery and Collaboration.  J Biomed Discov Collab. 2010; 5: 7–20.
- Piwowar; Jonathan D. Carlson; and Todd J. Vision. Beginning to Track 1000 Datasets from Public Repositories into the Published Literature.  ASIS&T 2011.
- Piwowar, H. A., Vision, T. J., & Whitlock, M. C. (2011). Data archiving is a good investment. Nature, 473(7347), 285-285. Nature Publishing Group, a division of Macmillan Publishers Limited. All Rights Reserved. Retrieved from http://dx.doi.org/10.1038/473285a
- Tenopir C, Allard S, Douglass K, Aydinoglu AU, Wu L, et al. (2011) Data Sharing by Scientists: Practices and Perceptions. PLoS ONE 6(6): e21101. doi:10.1371/journal.pone.0021101

Other studies of citation benefit:

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

References for knitr libraries:

<p>Wickham H (2007).
&ldquo;Reshaping Data with the reshape Package.&rdquo;
<EM>Journal of Statistical Software</EM>, <B>21</B>(12), pp. 1&ndash;20.
<a href="http://www.jstatsoft.org/v21/i12/">http://www.jstatsoft.org/v21/i12/</a>.

<p>Wickham H (2011).
&ldquo;The Split-Apply-Combine Strategy for Data Analysis.&rdquo;
<EM>Journal of Statistical Software</EM>, <B>40</B>(1), pp. 1&ndash;29.
<a href="http://www.jstatsoft.org/v40/i01/">http://www.jstatsoft.org/v40/i01/</a>.

<p>Jr FEH (2012).
<EM>rms: Regression Modeling Strategies</EM>.
R package version 3.5-0, <a href="http://CRAN.R-project.org/package=rms">http://CRAN.R-project.org/package=rms</a>.

<p>Fox J (2010).
<EM>polycor: Polychoric and Polyserial Correlations</EM>.
R package version 0.7-8, <a href="http://CRAN.R-project.org/package=polycor">http://CRAN.R-project.org/package=polycor</a>.

<p>Hajage D (2011).
<EM>ascii: Export R objects to several markup languages</EM>.
R package version 2.1, <a href="http://CRAN.R-project.org/package=ascii">http://CRAN.R-project.org/package=ascii</a>.

<p>Wickham H (2009).
<EM>ggplot2: elegant graphics for data analysis</EM>.
Springer New York.
ISBN 978-0-387-98140-6, <a href="http://had.co.nz/ggplot2/book">http://had.co.nz/ggplot2/book</a>.

<p>Bolker GRWIRscadcbB, Bonebakker L, Gentleman R, Liaw WHA, Lumley T, Maechler M, Magnusson A, Moeller S, Schwartz M and Venables B (2012).
<EM>gplots: Various R programming tools for plotting data</EM>.
R package version 2.11.0, <a href="http://CRAN.R-project.org/package=gplots">http://CRAN.R-project.org/package=gplots</a>.

<p>Xie Y (2012).
<EM>knitr: A general-purpose package for dynamic report generation in R</EM>.
R package version 0.6.3, <a href="http://CRAN.R-project.org/package=knitr">http://CRAN.R-project.org/package=knitr</a>.

<p>Boettiger C (2012).
<EM>knitcitations: Citations for knitr markdown files</EM>.
R package version 0.1-0, <a href="https://github.com/cboettig/knitcitations">https://github.com/cboettig/knitcitations</a>.










## Abstract

(hasn't been updated to reflect all analyses)

### Background
Attribution upon reuse of scientific data is important to reward data creators and document the provenance of research findings.  In many fields, data attribution commonly takes the form of citation to the paper that described the primary data collection.  Previous studies have found that papers with publicly available datasets do indeed receive a higher number of citations than similar studies without available data.  However, previous studies were relatively small and did not control for many variables known to predict citation rate.  In this analysis we look at citation rates while controlling for many known citation predictors, and investigate whether the estimated citation boost is consistent with evidence of data reuse.

### Methods and Results
In a multivariate linear regression on <code class="knitr inline">10555</code> studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 
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



