




# knitr citation11k manuscript
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <code class="knitr inline">Mon Jul  2 21:45:12 2012</code>

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line

    R -e "library(knitr); knit('stats_knit_.md')"; pandoc --toc -r markdown -w html -H static/header.html stats.md > stats.html
    view in browser: file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/stats.html

to see just the R code in a separate .R file called stats_knit_.R, run 
    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"














# Data Reuse and the Open Data Citation Advantage
*Piwowar, Carlson, Vision*


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there supporting evidence that additional citations are due to data reuse?

## Abstract

See the [end of this document](#abstract-1) (at the end so it can pull in results from the R analysis).

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection." [Piwowar, 2007]

Making research data publicly available also has costs. Data archives must be created and maintained. Data must be documented, formatted, and uploaded. Data-collecting investigators may be asked to answer questions when others try to use their data.

Scientists report that receiving more citations would be an important motivator for publicly archiving their data [Tenopir].

Several studies across several disciplines have found an association between data availability and number of citations recieved by a publication [cite studies below]. This evidence has been <a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">frequently referenced</a>, including in new policies that encourage and require data archiving [<a href="http://scholar.google.com/scholar?cites=10688057049876523086&amp;as_sdt=5,39&amp;sciodt=0,39&amp;hl=en">http://datadryad.org/jdap</a>]. It is important, therefore, to continue to strive for an accurate estimate of possible citation benefit.

The present study hopes to improve previous estimates in several ways. First, the present study is large enough to inluce many key covariates that may have conflated estimates of citation boost in previous, smaller studies: Number of authors, author publication experience, institution, open access availability, and subject area. Second, the current analysis estimates how citation boost levels may change over time. Third, the current analysis includes evidence on the nubmer of citations that may be due to data reuse.

Clinical microarray data provides a useful environment for the investigation: despite being valuable for reuse [Dudley] and well-supported by data sharing standards and infrastructure [Barrett], fewer than half of the studies that collect this data make it publicly available [Ochsner, Piwowar 2011].



## Methods


### Identification of relevant studies




The primary analysis in this paper examines the citation count of a gene expression microarray experiment, relative to availability of the experiment's data.

The sample of microarray experiments used in the current analysis was previously determined (Piwowar 2011 PLoS ONE, data from Piwowar 2011 Dryad).  Briefly, a full-text query uncovered papers with keywords associated with relevant wet-lab methods.  The full-text query had been characterized with high precision (90%, 95% confidence interval 86% to 93%) and a moderate recall (56%, 52% to 61%) for this task.  Running the query in PubMed Central, HighWire Press, and Google Scholar revealed <code class="knitr inline">11603</code> distinct gene expression microarray papers.  The papers were published between 2000 and 2009.

The current analysis retained papers published between 2001 and 2009.


### Assessment of data availability

The independent variable of interest in this analysis is the availability of gene expression microarray data.  Data availability had been previously determined for our sample articles in Piwowar 2011, so we directly reused that dataset [Piwowar Dryad 2011].  This study limited its data hunt to just the two predominant gene expression microarray databases: NCBI's Gene Expression Omnibus (GEO), and EBI's ArrayExpress.

"An earlier evaluation found that querying GEO and ArrayExpress with article PubMed identifiers located a representative 77% of all associated publicly available datasets [Piwowar 2010]. [We] used the same method for finding datasets associated with published articles in this study: [we] queried GEO for links to the PubMed identifiers in the analysis sample using the “pubmed_gds [filter]” and queried ArrayExpress by searching for each PubMed identifier in a downloaded copy of the ArrayExpress database. Articles linked from a dataset in either of these two centralized repositories were considered to have [publicly available data] for the endpoint of this study, and those without such a link were considered not to have [available] data." [Piwowar 2011]

### Study attributes

Piwowar 2011 collected 124 attributes for each of the gene expression microarray studies in our sample.  The subset of attributes previously shown or suspected to correlate with citation rate were included in the current analysis:

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
* institution mean citation score
* study topic (human/animal study, cancer/not cancer, etc.)
* NIH funding of the study, if applicable

### Citation data

We needed citation counts for thousands of articles based on identification through PubMed identifiers.  At the time of data collection, neither Thomson Reuter's Web of Science nor Google Scholar supported this type of query.  It was supported by Elsevier's Scopus citation database, but none of our affiliated institutions subscribed to Scopus.

One author (HAP) attempted to use the British Library's walk-in access of Scopus on its Reading Room computers during a trip overseas.  Unfortunately, the British Library did not permit electronic transfer of our PubMed identifier list onto the Reading Room computers, whether through internet document access or a USB drive text file transfer (see http://www.bl.uk/reshelp/inrrooms/stp/cond/conditions.html).  The Library was not willing to permit an exception to these policies, and we were unwilling to manually type ten thousand PubMed idenfiers in the Reading Room.  A personal email to someone at Scopus went unanswered.  HAP eventually obtained Scopus access through a Research Worker agreement with Canada's National Research Library (NRC-CISTI).

At the time of data collection the authors were not aware of any way to access Scopus data through researcher-developed computer programs, so we queried and exported Scopus citation data through manual interaction with the Scopus website.  The Scopus website had a limit to the length of query and the number of citations that could be exported at once.  To work within these restrictions we concatenated up to 500 PubMed IDs at a time into 22 queries, where each query took the form "PMID(1234) OR PMID(5678) OR ..."




Citation counts for <code class="knitr inline">10694</code>  papers were gathered from Scopus in November 2011. 


### Statistical methods

Analysis run on <code class="knitr inline">Mon Jul  2 21:45:28 2012</code>.

### Data and script availability

Raw data and statistical scripts are available in the Dryad data repository at [url and citation to be supplied upon article acceptance].  Dryad and GitHub also include the markdown version of this manuscript with interleaved statistical scripts using knitr[cite].


## Results

### Primary analysis of relationship between data availability and citation

#### Description of cohort

We begin with articles that have been identified as collecting gene expression microarray data by automatic algorithms looking for keywords in article full text (Piwowar 2011).  

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## [1] 10555    86
</pre></div></div></div>


For this analysis of citation behaviour, we retain articles published between 2001 and 2009: <code class="knitr inline">10555</code> articles.

The composition of this sample is spread across XXX journals, with the top 12 journals accounting for XXX% of the papers.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">:</span><span class="number">12</span><span class="keyword">]</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## | Cancer Res               | 0.04 |
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


Collecting gene expression micorarray data became more popular over time: XX% of articles in our sample were published in 2001, compared to YY% in 2009.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_year_published</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
</pre></div></div></div>



Searching for associated datasets in the GEO and ArrayExpress repository uncovered links between XXX% of papers in this sample and publicly available data.  
<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
##    0    1 
## 7938 2617 
</pre></div><div class="source"><pre class="knitr">
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
</pre></div></div></div>



Articles published more recently were more likely to have associated datasets.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="functioncall">library</span><span class="keyword">(</span><span class="symbol">ggplot2</span><span class="keyword">)</span>

<span class="symbol">df.long</span> <span class="assignement">=</span> <span class="functioncall">melt</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="argument">measure.vars</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="string">'pubmed.year.published'</span><span class="keyword">)</span><span class="keyword">)</span>
<span class="symbol">df.long.summary</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="symbol">df.long</span><span class="keyword">,</span> <span class="functioncall">.</span><span class="keyword">(</span><span class="symbol">variable</span><span class="keyword">,</span> <span class="symbol">value</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">summarize</span><span class="keyword">,</span> <span class="argument">proportion</span><span class="argument">=</span><span class="functioncall">sum</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae.int</span> <span class="keyword">&gt;</span> <span class="number">0</span><span class="keyword">)</span> <span class="keyword">/</span> <span class="functioncall">length</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="error"><pre class="knitr">## Error: 'by' is missing
</pre></div><div class="source"><pre class="knitr">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="argument">data</span><span class="argument">=</span><span class="symbol">df.long.summary</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">value</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="symbol">proportion</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">facet_wrap</span><span class="keyword">(</span><span class="keyword">~</span><span class="symbol">variable</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">formatter</span><span class="argument">=</span><span class="string">'percent'</span><span class="keyword">)</span>
</pre></div><div class="error"><pre class="knitr">## Error: object 'df.long.summary' not found
</pre></div></div></div>


The articles in our sample were cited between 0 and 2640 times, with an average of 32 citations per paper and a median of 16.  


<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.5    35.0  2640.0 
</pre></div></div></div>


Without accounting for any confounding factors, the mean number of citations between papers with available data and those without are the same, and there is little visible difference in the distribution of citations between these two groups.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span> <span class="symbol">summary</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_density</span><span class="keyword">(</span><span class="argument">alpha</span><span class="argument">=</span><span class="number">0.2</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</pre></div></div><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/sharingVCitations_breakdown.png" class="plot" /></div></div>



The number of citations a paper has recieved is strongly correlated to the date it was published: older papers have had more time to accumulate citations.  Because data archiving was relatively infrequent for articles published earlier, a difference in citation behaviour may be confounded with publication date.

Indeed, we saw that for any given publication date, papers with associated data recieve more citations than those without.

<div class="chunk"><div class="rcode"><div class="output"><pre class="knitr">## 2001 2002 2003 2004 2005 2006 2007 2008 2009 
## 76.0 54.0 40.0 30.0 24.0 18.0 14.0  9.5  5.0 
</pre></div></div></div>

    
This difference in citation is not driven by outliers: as shown by the distribution of citations over time, the distribution of citations for older papers with available data is centered at a higher median than citations for papers without data available.

<div class="chunk"><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/citationDist.png" class="plot" /></div></div>


#### Multivariate regression

Other factors have been previously shown to be correlated with citation rate, including number of authors, author experience, author institution, open access status, and subject area [cite].  Regression analysis can be useful to identify the relationship between data availability and citation rate, independently of these other variables.


<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="symbol">dfCitationsAttributes_with_journal</span> <span class="assignement">=</span> <span class="functioncall">merge</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">[</span><span class="keyword">,</span><span class="functioncall">c</span><span class="keyword">(</span><span class="string">"pmid"</span><span class="keyword">,</span> <span class="string">"pubmed_journal"</span><span class="keyword">)</span><span class="keyword">]</span><span class="keyword">,</span> <span class="argument">by</span><span class="argument">=</span><span class="string">"pmid"</span><span class="keyword">,</span> <span class="keyword">)</span>
<span class="symbol">fit_w_journal</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.year.first.pub.ago.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.year.first.pub.ago.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="symbol">country.usa</span> <span class="keyword">+</span>
          <span class="symbol">pubmed.is.open.access</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.num.articles.2008.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.cited.halflife</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.animals</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.plants</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.core.clinical.journal</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
           <span class="keyword">,</span> <span class="symbol">dfCitationsAttributes_with_journal</span><span class="keyword">)</span>

<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">fit_w_journal</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                              | Df      | Sum Sq  | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|---------|---------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00    | 165.79  | 82.90   | 164.83  | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00    | 995.77  | 497.89  | 990.00  | 0.00   |
## | factor(pubmed_journal)                       | 427.00  | 650.85  | 1.52    | 3.03    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1280.36 | 640.18  | 1272.94 | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 1.39    | 0.69    | 1.38    | 0.25   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 23.34   | 11.67   | 23.21   | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 0.94    | 0.47    | 0.94    | 0.39   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 5.53    | 2.76    | 5.50    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 10.53   | 5.26    | 10.47   | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 1.35    | 0.67    | 1.34    | 0.26   |
## | country.usa                                  | 1.00    | 1.13    | 1.13    | 2.25    | 0.13   |
## | pubmed.is.open.access                        | 1.00    | 0.44    | 0.44    | 0.88    | 0.35   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 0.58    | 0.29    | 0.57    | 0.56   |
## | factor(pubmed.is.cancer)                     | 1.00    | 0.13    | 0.13    | 0.26    | 0.61   |
## | factor(pubmed.is.animals)                    | 1.00    | 19.65   | 19.65   | 39.08   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 3.17    | 3.17    | 6.29    | 0.01   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 9.55    | 9.55    | 18.99   | 0.00   |
## | Residuals                                    | 3921.00 | 1971.93 | 0.50    |         |        |
</pre></div><div class="source"><pre class="knitr">
<span class="comment"># fit_w_journal</span>
<span class="symbol">citation.boost.coefs.journal</span> <span class="assignement">=</span> <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">fit_w_journal</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
<span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">citation.boost.coefs.journal</span><span class="keyword">)</span>
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

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="comment"># has a few less covariates than full model</span>
<span class="symbol">do_analysis</span> <span class="assignement">=</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">mydat</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">myfit</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="symbol">pubmed.is.open.access</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.num.articles.2008.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.animals</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
             <span class="keyword">,</span> <span class="symbol">mydat</span><span class="keyword">)</span>

  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfit</span><span class="keyword">)</span><span class="keyword">)</span>

  <span class="symbol">myfit</span>

  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfit</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
<span class="keyword">}</span>


<span class="symbol">estimates_by_year</span> <span class="assignement">=</span> <span class="functioncall">data.frame</span><span class="keyword">(</span><span class="keyword">)</span>
<span class="keyword">for</span> <span class="keyword">(</span><span class="symbol">year</span> <span class="keyword">in</span> <span class="functioncall">seq</span><span class="keyword">(</span><span class="number">2001</span><span class="keyword">,</span> <span class="number">2009</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">dat.subset.year</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes_with_journal</span><span class="keyword">,</span> <span class="symbol">pubmed.year.published</span>==<span class="symbol">year</span><span class="keyword">)</span>
  <span class="symbol">results</span> <span class="assignement">=</span> <span class="functioncall">do_analysis</span><span class="keyword">(</span><span class="symbol">dat.subset.year</span><span class="keyword">)</span>
  <span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">results</span><span class="keyword">)</span>
  <span class="symbol">estimates_by_year</span> <span class="assignement">=</span> <span class="functioncall">rbind</span><span class="keyword">(</span><span class="symbol">estimates_by_year</span><span class="keyword">,</span> <span class="functioncall">cbind</span><span class="keyword">(</span><span class="argument">year</span><span class="argument">=</span><span class="symbol">year</span><span class="keyword">,</span> <span class="symbol">results</span><span class="keyword">)</span><span class="keyword">)</span>
<span class="keyword">}</span>
</pre></div><div class="output"><pre class="knitr">## |                                              | Df    | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|-------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00  | 10.07  | 5.03    | 8.33    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00  | 0.49   | 0.24    | 0.40    | 0.67   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00  | 2.52   | 1.26    | 2.09    | 0.13   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00  | 14.09  | 7.04    | 11.66   | 0.00   |
## | pubmed.is.open.access                        | 1.00  | 0.02   | 0.02    | 0.03    | 0.87   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00  | 5.78   | 2.89    | 4.78    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00  | 0.96   | 0.48    | 0.79    | 0.46   |
## | rcs(journal.impact.factor.tr)                | 4.00  | 4.06   | 1.02    | 1.68    | 0.17   |
## | factor(pubmed_journal)                       | 32.00 | 16.68  | 0.52    | 0.86    | 0.67   |
## | factor(pubmed.is.cancer)                     | 1.00  | 0.24   | 0.24    | 0.40    | 0.53   |
## | factor(pubmed.is.animals)                    | 1.00  | 0.29   | 0.29    | 0.47    | 0.49   |
## | factor(dataset.in.geo.or.ae)                 | 1.00  | 0.40   | 0.40    | 0.66    | 0.42   |
## | Residuals                                    | 48.00 | 28.99  | 0.60    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.31  0.68   2.54 0.422
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 7.65   | 3.83    | 7.18    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.87   | 1.43    | 2.69    | 0.07   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 1.88   | 0.94    | 1.76    | 0.18   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.88  | 6.94    | 13.01   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.54   | 2.54    | 4.77    | 0.03   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.35   | 2.67    | 5.02    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 3.21   | 1.60    | 3.01    | 0.05   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 33.47  | 8.37    | 15.69   | 0.00   |
## | factor(pubmed_journal)                       | 80.00  | 73.73  | 0.92    | 1.73    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.13   | 1.13    | 2.11    | 0.15   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.54   | 0.54    | 1.01    | 0.32   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.18   | 0.18    | 0.34    | 0.56   |
## | Residuals                                    | 149.00 | 79.43  | 0.53    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  0.82   1.45 0.559
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 11.90  | 5.95    | 12.18   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 11.65  | 5.83    | 11.93   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 9.87   | 4.93    | 10.10   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.57  | 6.78    | 13.89   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.11   | 0.11    | 0.22    | 0.64   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.46   | 1.23    | 2.52    | 0.08   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 4.79   | 2.39    | 4.90    | 0.01   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 26.55  | 6.64    | 13.59   | 0.00   |
## | factor(pubmed_journal)                       | 119.00 | 78.63  | 0.66    | 1.35    | 0.03   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.02   | 1.02    | 2.09    | 0.15   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.80   | 2.80    | 5.74    | 0.02   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.34   | 0.34    | 0.69    | 0.41   |
## | Residuals                                    | 234.00 | 114.31 | 0.49    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  0.89   1.35 0.407
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.77  | 12.39   | 23.64   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.73   | 2.87    | 5.47    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 22.94  | 11.47   | 21.89   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 23.95  | 11.97   | 22.85   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 6.66   | 6.66    | 12.72   | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.72   | 1.36    | 2.60    | 0.08   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 9.60   | 4.80    | 9.16    | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 48.00  | 12.00   | 22.90   | 0.00   |
## | factor(pubmed_journal)                       | 160.00 | 126.10 | 0.79    | 1.50    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.23   | 0.23    | 0.44    | 0.51   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.07   | 0.07    | 0.14    | 0.71   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 4.21   | 4.21    | 8.04    | 0.00   |
## | Residuals                                    | 330.00 | 172.91 | 0.52    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.23  1.07   1.42 0.005
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 25.81  | 12.90   | 28.05   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 0.60   | 0.30    | 0.66    | 0.52   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 23.89  | 11.94   | 25.96   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 12.34  | 6.17    | 13.41   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.04   | 0.04    | 0.10    | 0.76   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 7.80   | 3.90    | 8.48    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 15.58  | 7.79    | 16.93   | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 52.61  | 13.15   | 28.59   | 0.00   |
## | factor(pubmed_journal)                       | 186.00 | 105.98 | 0.57    | 1.24    | 0.04   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.42   | 1.42    | 3.09    | 0.08   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.98   | 0.98    | 2.13    | 0.15   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 7.04   | 7.04    | 15.31   | 0.00   |
## | Residuals                                    | 380.00 | 174.80 | 0.46    |         |        |
##                                   param est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.3  1.14   1.48 0
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 35.85  | 17.92   | 37.15   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.45   | 1.23    | 2.54    | 0.08   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 19.51  | 9.75    | 20.22   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 17.65  | 8.83    | 18.30   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.23   | 0.23    | 0.48    | 0.49   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.80   | 1.40    | 2.91    | 0.06   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 8.04   | 4.02    | 8.33    | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 65.35  | 16.34   | 33.86   | 0.00   |
## | factor(pubmed_journal)                       | 177.00 | 125.97 | 0.71    | 1.48    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.14   | 0.14    | 0.28    | 0.59   |
## | factor(pubmed.is.animals)                    | 1.00   | 8.09   | 8.09    | 16.76   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 1.15   | 1.15    | 2.37    | 0.12   |
## | Residuals                                    | 383.00 | 184.77 | 0.48    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  0.98   1.23 0.124
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.19  | 12.10   | 26.67   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.35   | 2.67    | 5.90    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 11.75  | 5.88    | 12.96   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 11.00  | 5.50    | 12.13   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.01   | 0.01    | 0.01    | 0.90   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.76   | 1.38    | 3.05    | 0.05   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 5.52   | 2.76    | 6.09    | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 57.39  | 14.35   | 31.64   | 0.00   |
## | factor(pubmed_journal)                       | 210.00 | 133.80 | 0.64    | 1.41    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.11   | 0.11    | 0.24    | 0.63   |
## | factor(pubmed.is.animals)                    | 1.00   | 1.66   | 1.66    | 3.66    | 0.06   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.11   | 0.11    | 0.23    | 0.63   |
## | Residuals                                    | 500.00 | 226.72 | 0.45    |         |        |
##                                   param  est ciLow ciHigh    p
## Estimate factor(dataset.in.geo.or.ae).L 1.02  0.93   1.12 0.63
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 41.30  | 20.65   | 36.27   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.52  | 7.76    | 13.62   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 6.68   | 3.34    | 5.87    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 16.62  | 8.31    | 14.59   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.08   | 2.08    | 3.66    | 0.06   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.42   | 2.71    | 4.76    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 10.35  | 5.18    | 9.09    | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 59.85  | 14.96   | 26.28   | 0.00   |
## | factor(pubmed_journal)                       | 219.00 | 133.41 | 0.61    | 1.07    | 0.28   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.01   | 0.01    | 0.01    | 0.92   |
## | factor(pubmed.is.animals)                    | 1.00   | 5.79   | 5.79    | 10.16   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.06   | 0.06    | 0.10    | 0.75   |
## | Residuals                                    | 448.00 | 255.09 | 0.57    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.02  0.91   1.13 0.752
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 43.96  | 21.98   | 50.23   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.78    | 17.79   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 7.31   | 3.65    | 8.35    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 10.94  | 5.47    | 12.50   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.57   | 0.57    | 1.30    | 0.26   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 8.23   | 4.11    | 9.40    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 7.82   | 3.91    | 8.93    | 0.00   |
## | rcs(journal.impact.factor.tr)                | 4.00   | 59.57  | 14.89   | 34.04   | 0.00   |
## | factor(pubmed_journal)                       | 200.00 | 123.27 | 0.62    | 1.41    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.02   | 0.02    | 0.04    | 0.84   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.58   | 2.58    | 5.90    | 0.02   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.45   | 0.45    | 1.02    | 0.31   |
## | Residuals                                    | 331.00 | 144.84 | 0.44    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 0.95  0.85   1.05 0.314
</pre></div></div></div>


The estimate of citation boost was different for different years of publication.

The estimates of citation boost for papers published in each year, with 95% confidence intervals:

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="symbol">estimates_by_year</span>
</pre></div><div class="output"><pre class="knitr">##           year                          param  est ciLow ciHigh     p
## Estimate  2001 factor(dataset.in.geo.or.ae).L 1.31  0.68   2.54 0.422
## Estimate1 2002 factor(dataset.in.geo.or.ae).L 1.09  0.82   1.45 0.559
## Estimate2 2003 factor(dataset.in.geo.or.ae).L 1.09  0.89   1.35 0.407
## Estimate3 2004 factor(dataset.in.geo.or.ae).L 1.23  1.07   1.42 0.005
## Estimate4 2005 factor(dataset.in.geo.or.ae).L 1.30  1.14   1.48 0.000
## Estimate5 2006 factor(dataset.in.geo.or.ae).L 1.09  0.98   1.23 0.124
## Estimate6 2007 factor(dataset.in.geo.or.ae).L 1.02  0.93   1.12 0.630
## Estimate7 2008 factor(dataset.in.geo.or.ae).L 1.02  0.91   1.13 0.752
## Estimate8 2009 factor(dataset.in.geo.or.ae).L 0.95  0.85   1.05 0.314
</pre></div><div class="source"><pre class="knitr">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">estimates_by_year</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">year</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="symbol">est</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_line</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_errorbar</span><span class="keyword">(</span><span class="argument">width</span><span class="argument">=</span><span class="number">.1</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">ymin</span><span class="argument">=</span><span class="symbol">ciLow</span><span class="keyword">,</span> <span class="argument">ymax</span><span class="argument">=</span><span class="symbol">ciHigh</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">'year of publication'</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">limits</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">0</span><span class="keyword">,</span> <span class="number">3.0</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">name</span><span class="argument">=</span><span class="string">'estimated increase in citations\nfor papers with data available (95% confidence intervals)'</span><span class="keyword">)</span>
</pre></div></div><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/regressionEstimatesByYear.png" class="plot" /></div></div>




 

### Subset analysis to compare findings with Piwowar et al 2007

These estimates of citation boost found in the multivariate regression were different from those found by (Piwowar et al 2007), even though both studies looked at publicly available gene expression microarray data. There are several possible reasons for this difference.  

First, Piwowar et al 2007 included only data from human cancer microarray trials published between 1999 and 2003 <check>, whereas the current study uses all gene expression microarray data studies in PubMed from 2001 to 2009. 

Second, because the Piwowar et al 2007 sample was small, the previous analysis included only a few possible covariates: publication date, journal impact factor, and country of the corresponding author.

We attempted to reproduce that environment in the current study to see if we would find more comperable results.

Limiting the current sample to datasets with MeSH terms "human" and "cancer" published from 2001 to 2003 retained 308 papers.  Running this subsample with  covariates from the Piwowar 2007 paper found a comperable estimate to the 2007 paper: a citation increase of 47% (95% confidence intervals of 6% to 103%).

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">  <span class="symbol">dat.subset.previous.study</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed.year.published</span><span class="keyword">&lt;</span><span class="number">2003</span><span class="keyword">)</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span>==<span class="number">1</span><span class="keyword">)</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">pubmed.is.humans</span>==<span class="number">1</span><span class="keyword">)</span><span class="keyword">)</span>

  <span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## [1] 308  86
</pre></div><div class="source"><pre class="knitr">
  <span class="symbol">myfitprev</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span>
    <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
    <span class="symbol">country.usa</span> <span class="keyword">+</span>
    <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
    <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
               <span class="keyword">,</span> <span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>

  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                  | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)    | 2.00   | 5.33   | 2.67    | 3.27    | 0.04   |
## | country.usa                      | 1.00   | 0.00   | 0.00    | 0.01    | 0.94   |
## | rcs(journal.impact.factor.tr, 3) | 2.00   | 68.86  | 34.43   | 42.26   | 0.00   |
## | factor(dataset.in.geo.or.ae)     | 1.00   | 4.35   | 4.35    | 5.34    | 0.02   |
## | Residuals                        | 294.00 | 239.53 | 0.81    |         |        |
</pre></div><div class="source"><pre class="knitr">  <span class="symbol">myfitprev</span>
</pre></div><div class="output"><pre class="knitr">## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(pubmed.date.in.pubmed, 3) + country.usa + 
##     rcs(journal.impact.factor.tr, 3) + factor(dataset.in.geo.or.ae), 
##     data = dat.subset.previous.study)
## 
## Coefficients:
##                                               (Intercept)  
##                                                 26.970315  
##        rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                 -0.000699  
##       rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                  0.000211  
##                                             country.usa.L  
##                                                  0.015396  
##  rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                  0.908247  
## rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                 -0.080694  
##                            factor(dataset.in.geo.or.ae).L  
##                                                  0.383500  
## 
</pre></div><div class="source"><pre class="knitr">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.47  1.06   2.03 0.021
</pre></div></div></div>


How is did this estimate change when we included additional covariates?  The subsample of 308 papers was large enough to include a few additional covariates:  number of authors and citation history of the last author.  Including these covariates returned  a smaller estimated effect: 18% with a confidence interval that spanned a *loss* of 17% citations to a boost of 66%.  This range is too wide to be instructive, other than to note its top end is close to the previous rough estimates.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">  <span class="symbol">myfit_prev_more</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="symbol">country.usa</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(first.author.num.prev.pmc.cites.tr, 3) +     </span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
             <span class="keyword">,</span> <span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>

  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfit_prev_more</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                           | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |-------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)             | 2.00   | 5.55   | 2.78    | 3.60    | 0.03   |
## | country.usa                               | 1.00   | 0.05   | 0.05    | 0.07    | 0.79   |
## | rcs(num.authors.tr, 3)                    | 2.00   | 37.81  | 18.90   | 24.48   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3) | 2.00   | 17.16  | 8.58    | 11.11   | 0.00   |
## | rcs(journal.impact.factor.tr, 3)          | 2.00   | 34.49  | 17.24   | 22.33   | 0.00   |
## | factor(dataset.in.geo.or.ae)              | 1.00   | 0.66   | 0.66    | 0.85    | 0.36   |
## | Residuals                                 | 283.00 | 218.53 | 0.77    |         |        |
</pre></div><div class="source"><pre class="knitr">  <span class="symbol">myfit_prev_more</span>
</pre></div><div class="output"><pre class="knitr">## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(pubmed.date.in.pubmed, 3) + country.usa + 
##     rcs(num.authors.tr, 3) + rcs(last.author.num.prev.pmc.cites.tr, 
##     3) + rcs(journal.impact.factor.tr, 3) + factor(dataset.in.geo.or.ae), 
##     data = dat.subset.previous.study)
## 
## Coefficients:
##                                                                 (Intercept)  
##                                                                  24.4893104  
##                          rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                  -0.0006343  
##                         rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                   0.0000496  
##                                                               country.usa.L  
##                                                                   0.0319357  
##                                        rcs(num.authors.tr, 3)num.authors.tr  
##                                                                   0.0030413  
##                                       rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                   0.4026870  
##  rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                  -0.0008419  
## rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                   0.0113416  
##                    rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                   0.8674805  
##                   rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                  -0.1908536  
##                                              factor(dataset.in.geo.or.ae).L  
##                                                                   0.1631734  
## 
</pre></div><div class="source"><pre class="knitr">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfit_prev_more</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.18  0.83   1.66 0.357
</pre></div></div></div>


### Subset analysis with manual classification of data availability 




Our method of identifying which articles create gene expression microarray data made a nontrivial number of errors: about 10% of the articles it identified as creating gene expression microarray data do not in fact create gene expression datasets [cite].

The papers that are erroniously included in our subset to not create gene expression data, so they certainly don''t have associated archived datasets: all  erroniously included papers were automatically classified in the "no archived data" group. 

If it were true that these erroniously-included articles recieved many more or many fewer citations than other articles in the group, their inclusion could influence the findings of this study.

To verify our assumption that the influence of these mistakenly-included articles is in fact small, we manually reviewed a random 226 of the 11k (get exact number) articles.

Of these manually reviewed articles, 206 did indeed create gene expression microarray data, and 20 did not (but satisfied the boolean-search query for other reasons).  

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="number">206</span><span class="keyword">/</span><span class="number">226</span>
</pre></div><div class="output"><pre class="knitr">## [1] 0.9115
</pre></div></div></div>


Examining the citations of the  20 articles that did not create gene expression data revealed that these studies were cited less often than those that did create data: a mean of 26 citations compared to a mean of 32 citations.  The overall distribution of citations for articles that did not create gene expression data is closer to zero than the distribution of citations for articles that did create gene expression data.

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
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_density</span><span class="keyword">(</span><span class="argument">alpha</span><span class="argument">=</span><span class="number">0.2</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</pre></div></div><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/manualAnnotationCreatedCitations.png" class="plot" /></div></div>


This difference, however, was found to be not statisitically significantly different at the p<0.05 level, using either a t-test on the log of the citation counts or a Wilcoxon rank sum test on the raw citation counts.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">t.test</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
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
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">t.test</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
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
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">wilcox.test</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  nCitedBy by isCreated 
## W = 2440, p-value = 0.1733
## alternative hypothesis: true location shift is not equal to 0 
## 
</pre></div></div></div>


To confirm that the erroniously-included articles were not driving the findings about the citation relationship with data availability, we ran a multivariate regresssino analysis on the subsample of 206 articles that we manually determined did in fact generate gene expression microarray data.  The estimated effect is statistically significant and similar to the findings from the whole sample.

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">annotated_merged_created</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="symbol">country.usa</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(first.author.num.prev.pmc.cites.tr, 3) +     </span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
             <span class="keyword">,</span> <span class="symbol">dat.annotated.merged.created</span><span class="keyword">)</span>

<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">annotated_merged_created</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## |                                           | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |-------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)             | 2.00   | 83.82  | 41.91   | 73.91   | 0.00   |
## | country.usa                               | 1.00   | 0.21   | 0.21    | 0.38    | 0.54   |
## | rcs(num.authors.tr, 3)                    | 2.00   | 11.18  | 5.59    | 9.86    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3) | 2.00   | 7.94   | 3.97    | 7.00    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)          | 2.00   | 8.23   | 4.11    | 7.26    | 0.00   |
## | factor(dataset.in.geo.or.ae)              | 1.00   | 5.68   | 5.68    | 10.03   | 0.00   |
## | Residuals                                 | 177.00 | 100.37 | 0.57    |         |        |
</pre></div><div class="source"><pre class="knitr"><span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">annotated_merged_created</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.32  1.11   1.57 0.002
</pre></div></div></div>



### Complementary evidence of data reuse from accession number attribution

Finally, to provide evidence on the timeline of data attribution, we report preliminary data on third-party data reuse.  Large-scale evidence is difficult to gather because it requires manual citation context classification, as described above.  A partial estimate is possible, however, due to attribution norms in some fields: count the number of times a dataset accession number is mentioned in the scientific literature. (Piwowar, Vision, Whitlock) 

A citation boost due to public data availability would come from authors who would not have otherwise had access to the data.  The timeline of third-party reuse can be estimated by identifying all papers that reuse data, then eliminating those with author names in common with the data collection team.  Results from tracking datasets deposited into GEO in 2007 were reported in (Piwowar, Vision, Whitlock).  As one can see from the figure, the rate of data reuse by third parties continues to increase three years after article publication.  


<img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/3rdpartygrowth.png" class="plot" height=300 />


### Complementary evidence of data reuse from citation context

To provide evidence on the proportion of the citation boost that may be caused by data reuse, we report the observed frequency with which papers that shared gene expression microarray data were cited in the context of data attribution.  Citations to papers that describe 100 datasets deposited into GEO in 2005 were collected using Web of Science: XXX total citations were found.  138 citations were randomly selected and manually reviewed.  

<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">dfTracking1k</span> <span class="assignement">=</span> <span class="functioncall">read.csv</span><span class="keyword">(</span><span class="string">"data/tracking1k_20111008.csv"</span><span class="keyword">,</span> <span class="argument">sep</span><span class="argument">=</span><span class="string">","</span><span class="keyword">,</span> <span class="argument">header</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">stringsAsFactors</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">)</span>
<span class="symbol">dfTracking1k.GEO.subset</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfTracking1k</span><span class="keyword">,</span> <span class="symbol">TAG.source</span>==<span class="string">"WoS"</span> <span class="keyword">&amp;</span> <span class="symbol">TAG.confidence</span><span class="keyword">!=</span><span class="string">"low confidence"</span> <span class="keyword">&amp;</span> <span class="functioncall">is.na</span><span class="keyword">(</span><span class="symbol">duplicates</span> <span class="keyword">&amp;</span> <span class="symbol">TAG.repository</span>==<span class="string">"GEO"</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset reused"</span> <span class="keyword">|</span> <span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset not reused"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">num.GEO.total</span> <span class="assignement">=</span> <span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfTracking1k.GEO.subset</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>
<span class="symbol">num.GEO.reused</span> <span class="assignement">=</span> <span class="functioncall">dim</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfTracking1k.GEO.subset</span><span class="keyword">,</span> <span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset reused"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>
<span class="symbol">annotated.prop</span> <span class="assignement">=</span> <span class="functioncall">binconf</span><span class="keyword">(</span><span class="symbol">num.GEO.reused</span><span class="keyword">,</span> <span class="symbol">num.GEO.total</span><span class="keyword">)</span>
<span class="symbol">num.GEO.total</span>
</pre></div><div class="output"><pre class="knitr">## [1] 138
</pre></div><div class="source"><pre class="knitr"><span class="symbol">num.GEO.reused</span>
</pre></div><div class="output"><pre class="knitr">## [1] 8
</pre></div><div class="source"><pre class="knitr"><span class="symbol">annotated.prop</span>
</pre></div><div class="output"><pre class="knitr">##  PointEst   Lower  Upper
##   0.05797 0.02966 0.1102
</pre></div></div></div>


Of the <code class="knitr inline">138</code> reviewed citations to articles with archived gene expression data, <code class="knitr inline">8</code> were in the context of data reuse
<code class="knitr inline">6</code>%
with 95% confidence intervals [<code class="knitr inline">3</code>%
, <code class="knitr inline">11</code>% ]


<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="comment">#experiment</span>

<span class="symbol">most_common_journals</span> <span class="assignement">=</span> <span class="functioncall">names</span><span class="keyword">(</span><span class="functioncall">sort</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">:</span><span class="number">12</span><span class="keyword">]</span><span class="keyword">)</span>
<span class="symbol">dat_most_common_journals</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed_journal</span> <span class="keyword">%in%</span> <span class="symbol">most_common_journals</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="symbol">dat_most_common_journals</span><span class="keyword">,</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="string">"pubmed_journal"</span><span class="keyword">,</span> <span class="string">"pubmed_year_published"</span><span class="keyword">,</span> <span class="string">"in_ae_or_geo"</span><span class="keyword">)</span><span class="keyword">,</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">df</span><span class="keyword">)</span> <span class="functioncall">mean</span><span class="keyword">(</span><span class="symbol">df</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">b</span> <span class="assignement">=</span> <span class="functioncall">ddply</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="string">"pubmed_journal"</span><span class="keyword">,</span> <span class="string">"pubmed_year_published"</span><span class="keyword">)</span><span class="keyword">,</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">df</span><span class="keyword">)</span> <span class="functioncall">median</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">df</span><span class="keyword">,</span> <span class="symbol">in_ae_or_geo</span>==<span class="number">1</span><span class="keyword">)</span><span class="keyword">$</span><span class="symbol">V1</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">median</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">df</span><span class="keyword">,</span> <span class="symbol">in_ae_or_geo</span>==<span class="number">0</span><span class="keyword">)</span><span class="keyword">$</span><span class="symbol">V1</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">pubmed_year_published</span><span class="keyword">,</span> <span class="symbol">V1</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">b</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="symbol">pubmed_journal</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="string">"point"</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span>
</pre></div></div><div class="rimage default"><img src="http://dl.dropbox.com/u/5485507/11kCitationStudy/paper/citation11k/analysis/figure/unnamed-chunk-1.png" class="plot" /></div><div class="rcode">
<div class="source"><pre class="knitr">
<span class="symbol">d</span> <span class="assignement">=</span> <span class="functioncall">melt</span><span class="keyword">(</span><span class="symbol">b</span><span class="keyword">,</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="string">"pubmed_journal"</span><span class="keyword">,</span> <span class="string">"pubmed_year_published"</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="functioncall">round</span><span class="keyword">(</span><span class="functioncall">cast</span><span class="keyword">(</span><span class="symbol">d</span><span class="keyword">,</span> <span class="symbol">pubmed_journal</span><span class="keyword">~</span><span class="symbol">pubmed_year_published</span><span class="keyword">~</span><span class="symbol">variable</span><span class="keyword">,</span> <span class="symbol">mean</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">)</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## , , variable = V1
## 
##                           pubmed_year_published
## pubmed_journal             2001 2002 2003 2004 2005 2006 2007 2008 2009
##   Blood                     NaN  NaN  1.1  0.6  0.8  1.8  1.2  1.2  1.0
##   BMC Genomics              NaN  NaN  NaN  NaN  NaN  NaN  0.7  0.9  1.0
##   Cancer Res                NaN  0.2  0.9  1.5  3.1  1.3  0.7  1.0  1.3
##   Clin Cancer Res           NaN  NaN  NaN  NaN  1.5  1.1  2.0  1.0  1.2
##   J Bacteriol               NaN  2.2  0.3  1.8  0.8  0.7  1.0  1.7  1.8
##   J Biol Chem               NaN  0.6  1.6  1.4  1.6  1.2  1.0  0.7  1.4
##   J Immunol                 NaN  1.9  0.8  0.9  1.4  2.6  1.0  1.0  0.8
##   Mol Cell Biol             NaN  NaN  NaN  1.2  0.9  1.9  1.4  1.9  1.5
##   Physiol Genomics          NaN  1.2  1.0  0.8  1.3  1.6  0.4  0.7  1.2
##   Plant Physiol             NaN  NaN  0.7  1.0  1.1  1.6  1.0  1.6  1.0
##   PLoS One                  NaN  NaN  NaN  NaN  NaN  1.2  1.4  1.9  1.1
##   Proc Natl Acad Sci U S A  3.5  1.1  1.1  2.1  1.5  1.1  0.6  1.6  1.0
## 
</pre></div></div></div>



### Additional analysis for reference during manuscript prep


<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="symbol">myhetcorr</span> <span class="assignement">=</span> <span class="functioncall">hetcor.modified</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="argument">use</span><span class="argument">=</span><span class="string">"pairwise.complete.obs"</span><span class="keyword">,</span> <span class="argument">std.err</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">,</span> <span class="argument">pd</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">)</span>
<span class="symbol">mycor</span> <span class="assignement">=</span> <span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span>
<span class="functioncall">colnames</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">)</span> <span class="assignement">=</span> <span class="functioncall">colnames</span><span class="keyword">(</span><span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span><span class="keyword">)</span>
<span class="functioncall">rownames</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">)</span> <span class="assignement">=</span> <span class="functioncall">rownames</span><span class="keyword">(</span><span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span><span class="keyword">)</span>
</pre></div></div></div>

    
<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="comment"># Correlations with data availability</span>
<span class="comment">## See if anything is so collinear it will cause problems in regression</span>
<span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"dataset.in.geo.or.ae.int"</span><span class="keyword">]</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## | dataset.in.geo                                | 1     |
## | dataset.in.geo.or.ae                          | 1     |
## | dataset.in.geo.or.ae.int                      | 1     |
## | institution.stanford                          | 0.3   |
## | pubmed.is.open.access                         | 0.23  |
## | pubmed.date.in.pubmed                         | 0.21  |
## | pmid                                          | 0.2   |
## | pubmed.year.published                         | 0.2   |
## | journal.microarray.creating.count.tr          | 0.14  |
## | journal.immediacy.index.log                   | 0.12  |
## | pubmed.is.funded.nih.intramural               | 0.12  |
## | has.U.funding                                 | 0.11  |
## | pubmed.is.funded.nih                          | 0.11  |
## | pubmed.is.bacteria                            | 0.11  |
## | journal.5yr.impact.factor.log                 | 0.1   |
## | journal.impact.factor.tr                      | 0.1   |
## | pubmed.num.cites.from.pmc.per.year            | 0.09  |
## | journal.impact.factor.log                     | 0.09  |
## | num.grants.via.nih.tr                         | 0.08  |
## | nih.cumulative.years.tr                       | 0.08  |
## | has.R.funding                                 | 0.08  |
## | institution.mean.norm.citation.score          | 0.08  |
## | pubmed.is.fungi                               | 0.08  |
## | has.T.funding                                 | 0.07  |
## | has.R01.funding                               | 0.07  |
## | last.author.num.prev.microarray.creations.tr  | 0.07  |
## | pubmed.is.geo.reuse                           | 0.07  |
## | institution.international.collaboration       | 0.07  |
## | last.author.num.prev.pmc.cites.tr             | 0.06  |
## | max.grant.duration.tr                         | 0.06  |
## | nih.sum.avg.dollars.tr                        | 0.06  |
## | institution.is.govnt                          | 0.06  |
## | nih.sum.sum.dollars.tr                        | 0.05  |
## | nih.max.max.dollars.tr                        | 0.05  |
## | pubmed.is.shared.other                        | 0.05  |
## | num.grant.numbers.tr                          | 0.05  |
## | pubmed.is.funded.non.us.govt                  | 0.05  |
## | pubmed.is.plants                              | 0.05  |
## | num.authors.tr                                | 0.05  |
## | institution.is.higher.ed                      | 0.04  |
## | first.author.num.prev.microarray.creations.tr | 0.04  |
## | country.canada                                | 0.04  |
## | has.K.funding                                 | 0.04  |
## | country.usa                                   | 0.04  |
## | country.uk                                    | 0.04  |
## | first.author.num.prev.pmc.cites.tr            | 0.03  |
## | country.france                                | 0.02  |
## | pubmed.is.animals                             | 0.02  |
## | pubmed.num.cites.from.pmc.tr                  | 0.02  |
## | first.author.female                           | 0.02  |
## | institution.mean.norm.impact.factor           | 0.02  |
## | last.author.female                            | 0.02  |
## | pubmed.is.prognosis                           | 0.02  |
## | pubmed.is.effectiveness                       | 0.01  |
## | pubmed.is.comparative.study                   | 0.01  |
## | institution.research.output.tr                | 0.01  |
## | nCitedBy.log                                  | 0     |
## | has.P.funding                                 | 0     |
## | country.australia                             | 0     |
## | nCitedBy                                      | 0     |
## | last.author.num.prev.pubs.tr                  | 0     |
## | pubmed.is.mice                                | 0     |
## | institution.rank                              | -0.01 |
## | first.author.num.prev.pubs.tr                 | -0.02 |
## | last.author.year.first.pub.ago.tr             | -0.02 |
## | journal.num.articles.2008.tr                  | -0.02 |
## | country.germany                               | -0.02 |
## | nih.last.year.ago.tr                          | -0.03 |
## | pubmed.is.core.clinical.journal               | -0.03 |
## | pubmed.is.diagnosis                           | -0.03 |
## | institution.harvard                           | -0.03 |
## | nih.first.year.ago.tr                         | -0.04 |
## | institution.is.medical                        | -0.04 |
## | first.author.year.first.pub.ago.tr            | -0.05 |
## | pubmed.is.viruses                             | -0.07 |
## | first.author.gender.not.found                 | -0.08 |
## | last.author.gender.not.found                  | -0.09 |
## | pubmed.is.humans                              | -0.1  |
## | journal.cited.halflife                        | -0.11 |
## | institution.nci                               | -0.11 |
## | pubmed.is.cultured.cells                      | -0.11 |
## | pubmed.is.cancer                              | -0.12 |
## | country.japan                                 | -0.14 |
## | country.china                                 | -0.14 |
## | country.korea                                 | -0.14 |
## | years.ago.tr                                  | -0.19 |
</pre></div></div></div>

    
<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">
<span class="comment"># Correlations with citation</span>
<span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"nCitedBy.log"</span><span class="keyword">]</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</pre></div><div class="output"><pre class="knitr">## | nCitedBy.log                                  | 1     |
## | pubmed.num.cites.from.pmc.tr                  | 0.76  |
## | years.ago.tr                                  | 0.59  |
## | pubmed.num.cites.from.pmc.per.year            | 0.59  |
## | nCitedBy                                      | 0.58  |
## | journal.impact.factor.log                     | 0.47  |
## | journal.impact.factor.tr                      | 0.45  |
## | journal.5yr.impact.factor.log                 | 0.45  |
## | journal.immediacy.index.log                   | 0.44  |
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
## | institution.mean.norm.impact.factor           | 0.18  |
## | num.authors.tr                                | 0.17  |
## | pubmed.is.core.clinical.journal               | 0.17  |
## | last.author.num.prev.pubs.tr                  | 0.15  |
## | nih.first.year.ago.tr                         | 0.15  |
## | institution.nci                               | 0.14  |
## | journal.cited.halflife                        | 0.14  |
## | pubmed.is.shared.other                        | 0.12  |
## | institution.research.output.tr                | 0.1   |
## | has.T.funding                                 | 0.1   |
## | num.grant.numbers.tr                          | 0.09  |
## | pubmed.is.prognosis                           | 0.09  |
## | has.R01.funding                               | 0.09  |
## | pubmed.is.humans                              | 0.08  |
## | max.grant.duration.tr                         | 0.08  |
## | pubmed.is.funded.nih                          | 0.07  |
## | has.R.funding                                 | 0.07  |
## | pubmed.is.plants                              | 0.07  |
## | pubmed.is.comparative.study                   | 0.06  |
## | first.author.num.prev.pubs.tr                 | 0.06  |
## | pubmed.is.cancer                              | 0.06  |
## | has.P.funding                                 | 0.06  |
## | nih.max.max.dollars.tr                        | 0.06  |
## | institution.international.collaboration       | 0.05  |
## | pubmed.is.diagnosis                           | 0.04  |
## | nih.cumulative.years.tr                       | 0.03  |
## | country.uk                                    | 0.03  |
## | has.U.funding                                 | 0.03  |
## | pubmed.is.effectiveness                       | 0.02  |
## | nih.sum.sum.dollars.tr                        | 0.02  |
## | num.grants.via.nih.tr                         | 0.02  |
## | nih.sum.avg.dollars.tr                        | 0.01  |
## | pubmed.is.bacteria                            | 0.01  |
## | last.author.num.prev.microarray.creations.tr  | 0.01  |
## | dataset.in.geo.or.ae                          | 0.01  |
## | pubmed.is.funded.non.us.govt                  | 0.01  |
## | dataset.in.geo.or.ae.int                      | 0     |
## | institution.is.medical                        | 0     |
## | country.france                                | 0     |
## | pubmed.is.fungi                               | 0     |
## | first.author.gender.not.found                 | -0.01 |
## | pubmed.is.cultured.cells                      | -0.01 |
## | institution.is.govnt                          | -0.01 |
## | first.author.num.prev.microarray.creations.tr | -0.01 |
## | pubmed.is.geo.reuse                           | -0.01 |
## | pubmed.is.mice                                | -0.02 |
## | pubmed.is.viruses                             | -0.02 |
## | dataset.in.geo                                | -0.02 |
## | country.germany                               | -0.02 |
## | country.australia                             | -0.02 |
## | pubmed.is.funded.nih.intramural               | -0.03 |
## | nih.last.year.ago.tr                          | -0.04 |
## | has.K.funding                                 | -0.04 |
## | last.author.gender.not.found                  | -0.04 |
## | country.canada                                | -0.05 |
## | institution.rank                              | -0.06 |
## | last.author.female                            | -0.07 |
## | institution.is.higher.ed                      | -0.07 |
## | first.author.female                           | -0.08 |
## | country.japan                                 | -0.1  |
## | pubmed.is.animals                             | -0.11 |
## | country.china                                 | -0.19 |
## | country.korea                                 | -0.26 |
## | pubmed.is.open.access                         | -0.3  |
## | pmid                                          | -0.58 |
## | pubmed.year.published                         | -0.58 |
## | pubmed.date.in.pubmed                         | -0.59 |
</pre></div></div></div>

    
<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="symbol">univarate.citation.predictors</span> <span class="assignement">=</span> <span class="functioncall">which</span><span class="keyword">(</span><span class="functioncall">abs</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"nCitedBy.log"</span><span class="keyword">]</span><span class="keyword">)</span> <span class="keyword">&gt;</span> <span class="number">0.1</span><span class="keyword">)</span><span class="comment">#univarate.citation.predictorslength(univarate.citation.predictors)    topcor = mycor[univarate.citation.predictors, univarate.citation.predictors]</span>
</pre></div></div></div>

    
<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr">    <span class="functioncall">heatmap.2</span><span class="keyword">(</span><span class="symbol">topcor</span><span class="keyword">,</span> <span class="argument">col</span><span class="argument">=</span><span class="functioncall">bluered</span><span class="keyword">(</span><span class="number">16</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">cexRow</span><span class="argument">=</span><span class="number">1</span><span class="keyword">,</span> <span class="argument">cexCol</span> <span class="argument">=</span> <span class="number">1</span><span class="keyword">,</span> <span class="argument">symm</span> <span class="argument">=</span> <span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">dend</span> <span class="argument">=</span> <span class="string">"row"</span><span class="keyword">,</span> <span class="argument">trace</span> <span class="argument">=</span> <span class="string">"none"</span><span class="keyword">,</span> <span class="argument">main</span> <span class="argument">=</span> <span class="string">"Thesis Data"</span><span class="keyword">,</span> <span class="argument">margins</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">15</span><span class="keyword">,</span><span class="number">15</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">key</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">,</span> <span class="argument">keysize</span><span class="argument">=</span><span class="number">0.1</span><span class="keyword">)</span>
</pre></div></div></div>


<div class="chunk"><div class="rcode"><div class="source"><pre class="knitr"><span class="comment">##Other breakdownsnum_authors_breaks = c(1, 5, 10, 20, 40)with(dat.subset, tapply(nCitedBy, cut(num.authors.tr, num_authors_breaks), median, na.rm=T))qplot(num.authors.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=num_authors_breaks, labels=num_authors_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(pubmed.is.core.clinical.journal, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(pubmed.is.open.access, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(pubmed.is.cancer, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(pubmed.is.humans, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(pubmed.is.cultured.cells, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(has.R.funding, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteggplot(dat.subset, aes(country.usa, 1+nCitedBy, color=factor(dataset.in.geo.or.ae)))  + geom_jitter() + geom_boxplot() + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPaletteqplot(num.grants.via.nih.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalettex_breaks = quantile(dat.subset$last.author.num.prev.microarray.creations.tr, na.rm=T)qplot(last.author.num.prev.microarray.creations.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalettex_breaks = quantile(dat.subset$first.author.num.prev.pubs.tr, na.rm=T)qplot(first.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalettex_breaks = quantile(dat.subset$last.author.num.prev.pubs.tr, na.rm=T)qplot(last.author.num.prev.pubs.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalettex_breaks = quantile(dat.subset$last.author.num.prev.pmc.cites.tr, na.rm=T)qplot(last.author.num.prev.pmc.cites.tr, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalettex_breaks = quantile(dat.subset$institution.mean.norm.citation.score, na.rm=T)qplot(institution.mean.norm.citation.score, 1+nCitedBy, color=factor(dataset.in.geo.or.ae), data=dat.subset) + geom_smooth(aes(color="black", fill=factor(dataset.in.geo.or.ae))) + scale_x_continuous(trans="log10", breaks=x_breaks, labels=x_breaks) + scale_y_continuous(trans="log10", breaks=citation_breaks, labels=citation_breaks) + cbgFillPalette + cbgColourPalette</span>
</pre></div></div></div>



## Discussion

*1. summary of results*
- summary of results
- citation boost consistent with some previous findings.  Particularly consistent with multivariate analysis of (Milia et al).
"Our multivariate analysis showed that time since publication and impact factor are the main factor influencing the number of citations received by datasets (see Table S5). A slight increase (8.9%) in the number of citations was observed for shared datasets, with a more pronounced advantage (20.6%) for mtDNA (Table S6), but, again, no difference was found to be associated with a statistically significant result in our multivariate analysis."
- the number of papers that reused data was still increasing rapidly after three years.  This suggests that the relatively low level of citation boost we observe for papers published in 2007-2009 may be because not enough time has passed for reuse articles to have been written in large quantity. 


- potential for greater boost if authors always attributed data reuse through citations, rather than sometimes through in-text accession number (cite the "Beginning to Track 1k datasets" abstract for estimated breakdown of citations-to-papers vs attribution-through-accessionnumber for GEO data)  *this is parallel to one of the points in the limitations section.*
- put these findings in the context of the history of gene expression microarray data: Todd''s email.  *suggestions on the discussion angle for this?*
- unknown factor of how important poorly documented over time. documentation changes over time.  high citation early on, if real, may be true that high standardization is not a prereq for data reuse.  todd's email
- don't know if changes over time

- what is the citaiton boost
- how uniform accross year and journals
- changing standards like MIAME
- role of covariates, and other ones we didn't look like liek standards
- other caveates to results
- how to does it relate to previous
(variablility, belief, etc)

*2. timeline of data reuse*

*3. what is the cause of the boost*

What might be the cause of a citation boost for papers with publicly available data?  The most obvious source of is attribution for data reuse, but there may be additional contributions from other sources.  The literature on the "Open Access Citation Benefit" has articulated several possible sources of OA citation boost, including Selection Bias and Early View.citep(biblio["Craig2007"]).  We suggest the possible sources for an "Open Data Citation Benefit" include:

1. *Data Reuse*. Papers with available datasets can be used in more ways than papers without data, and therefore may receive additional attributions upon published data reuse.
1. *Credibility Signalling*. The credibility of research findings may be higher for research papers with available data. Such papers may be preferentially chosen background citations and/or the foundation of additional research.
1. *Increased Visibility*. Citing authors may be more likely to encounter a research project with available data. More artifacts associated with a research project gives the project a larger footprint, increasing the likelihood that someone finds an aspect of the research. Links from data to the research paper may also increase the search ranking of the research paper.
1. *Early View*. When data is made available before a paper is published, some citations may accrue earlier than otherwise because research methods and findings are encountered prior to paper publication.
1. *Selection Bias*. Authors may be more likely to publish data for papers they judge to be their best quality work, because they are most proud or confident in the results. ALTERNATIVELY, it is possible that author self-selection bias may have a negative correlation with research quality in the case of Open Data: authors may be less willing to share details for their most important and visible research in order to maintain a competitive edge and avoid the upheaval of error detection.

The estimated citation boost in the current study is consistent with observed data reuse alone, but the error bounds are large enough that other sources may also have contributed.  Unforuntaely, given the current dataset, it is difficult to establish which sources might have caused the observed boost.Further work, with additional data, will be needed to understand the relative contributions from each source.  For example, hypothetical examples could be provided to authors to determine whether they would be systematically more likely to cite a paper with available data in situations where they are considering the credibility of the findings.  Analyses within the pubication output of a selection of data-collecting authors may enable measurement of selection bias.  Observing search behaviour of researchers, and the returned search hit results, may provide evidence of increased visibility due to data availability.  The contribution of early views to citations would depend on the data availablily timeline within the domain and datatype of study.

*4. future work include this?*

Data reuse, and the attendant efficiencies and discoveries, is a primary motivation for requiring that research data be made available.  Consequently, accurate measurement of data reuse is particularly important.  Future work can improve on previous studies by considering all methods of data use attribution.  This holistic effort would include identifying citations to the paper that describes the data collection, mentions of the dataset identifier itself -- whether in full text, the references section, or supplementary information -- and even acknowledgements to the data collection investigators.  The citations and mentions would need classification based on context to ensure they are in the context of data reuse.

These estimates of data reuse could then be used to estimate the impact of policy decisions.  For example, do embargo periods decrease the level of data reuse?  Do restrictive or poorly articulated licencing terms decrease data reuse?  Which types of data reuse are facilitate by robust data standards and which types are unaffected?

Future work is also needed to assess other important metrics of reuse, beyond citation.  The impact on practitioners, education, data journalism, and industry research are not captured by attibution patterns in the scientific literature.  Altmetrics indicators uncover discussions in social social media, syallabi, patents, and theses: analyzing such indicators for datasets would provide valuable evidence of reuse beyond the scientific literature.


*5. implications.  wrap-up thoughts*

The findings of this study suggest that papers with available data make a bigger impact on the scientific literature than similar papers without available data.  Making an impact is important to funders, journals, and authors themselves.  A ten percent increase in the impact of a research project is noteworthy, given that today journals fight for journal impact factor scores to two decimal places.  As evaluators move away from assessing research based on journal impact factor and toward article-level metrics, post-publication citation rates are becoming key indicators of research impact.  

The strongest rationale for making research data broadly availble is not that it may increase one's citation count: full description of experimental process and findings is a tenant of science and publicly-funded science is a public resource[http://www.nature.com/news/open-your-minds-and-share-your-results-1.10895].  Nonetheless, robust evidence of personal benefit will help as science transitions to a culture that expects data to be widely available. 













*limitations.  work these into flow of discussion*

- automated methods were imperfect: full text to the scientific literature would permit more sophisticated and accurate retrieval techniques based on full-text.
- This is an underestimate of total reuse (some attribution through accession number, some attribution is in citations in supplementary information which is not indexed by Scopus, some papers that may cite aren''t indexed by Scopus) *maybe inlude this point in general discussion as mentioned below, rather than in limitations?*
- Due to mechanics of accessing so many citations through Scopus website, weren''t able to get detailed timing of each citation, so all citation counts were censored as of the collection date rather than a fixed time period after the date of publication.  Also, we can''t tell if low level of citation boost in recent articles is because they have yet to accumulate or because the number of available datasets is now so large that the reuse level of any specific article has decreased.
- (negative binomial is probably a better statistical technique than linear regression, but it isn''t standard)
- we didn't gather evidence about when the data was made available, though previous work suggested it was usually at the time of paper publication (Piwowar 2007)
- Correlation doesn''t imply causation.  Although this analysis includes more variables, other important ones are still missing: funder, funding levels, etc.

*fit these in?*

- Making data available doesn’t just increase the impact of research by a certain amount: opens it up to whole new *types* of use. 
- Archiving data has costs, but the hassle of archiving data is very small 
relative to all the work that goes into a research publication.


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

### Experimenting with knitr citations
Demo citing thank Carl for his great library! 
[1] "(Boettiger, 2012)"



Now cite everyone! 
[1] "(Bollen _et. al._ 2009; Chavan & Ingwersen, 2009; Gleditsch & Strand, 2003; Ib\\'{a}\\~{n}ez _et. al._ 2009; Ioannidis _et. al._ 2009; Ochsner _et. al._ 2008; Pienta _et. al._ 2010; Pienta _et. al._ 2006; Piwowar _et. al._ 2007; Piwowar _et. al._ 2011; Piwowar, 2011; character(0); Piwowar _et. al._ 2011; Piwowar & Chapman, 2010; Sears, 2011)"



### demo bibliography

Boettiger C (2012). _knitcitations: Citations for knitr markdown
files_. R package version 0.0-1.

Bollen J, Van de Sompel H, Hagberg A and Chute R (2009). "A principal
component analysis of 39 scientific impact measures." _PloS one_,
*4*(6), pp. e6022. ISSN 1932-6203, <URL:
http://dx.doi.org/10.1371/journal.pone.0006022>, <URL:
http://dx.plos.org/10.1371/journal.pone.0006022>.

Chavan VS and Ingwersen P (2009). "Towards a data publishing framework
for primary biodiversity data: challenges and potentials for the
biodiversity informatics community." _BMC bioinformatics_, *10 Suppl
1*(Suppl 14), pp. S2. ISSN 1471-2105, <URL:
http://dx.doi.org/10.1186/1471-2105-10-S14-S2>, <URL:
http://www.biomedcentral.com/1471-2105/10/S14/S2>.

Gleditsch NP and Strand H (2003). "Posting your data: will you be
scooped or will you be famous?" _International Studies Perspectives_,
*4*(1), pp. 89-97. <URL:
http://www.prio.no/Research-and-Publications/Publication/?oid=55406>.

Ibáñez A, Larrañaga P and Bielza C (2009). "Predicting citation count
of Bioinformatics papers within four years of publication."
_Bioinformatics (Oxford, England)_, *25*(24), pp. 3303-9. ISSN
1367-4811, <URL: http://dx.doi.org/10.1093/bioinformatics/btp585>,
<URL:
http://bioinformatics.oxfordjournals.org/cgi/content/abstract/25/24/3303>.

Ioannidis JPA, Allison DB, Ball CA, Coulibaly I, Cui X, Culhane AC,
Falchi M, Furlanello C, Game L, Jurman G, Mangion J, Mehta T, Nitzberg
M, Page GP, Petretto E and Noort Vv (2009). "Repeatability of published
microarray gene expression analyses." _Nature genetics_, *41*(2), pp.
149-55. ISSN 1546-1718, <URL: http://dx.doi.org/10.1038/ng.295>, <URL:
http://www.ncbi.nlm.nih.gov/pubmed/19174838>.

Ochsner SA, Steffen DL, Stoeckert CJ and McKenna NJ (2008). "Much room
for improvement in deposition rates of expression microarray datasets."
_Nature methods_, *5*(12), pp. 991. ISSN 1548-7105, <URL:
http://dx.doi.org/10.1038/nmeth1208-991>, <URL:
http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=2975491\&tool=pmcentrez\&rendertype=abstract>.

Pienta AM, Alter GC and Lyle JA (2010). "The Enduring Value of Social
Science Research: The Use and Reuse of Primary Research Data." _The
Organisation, Economics and Policy of Scientific Research workshop_.
<URL: http://hdl.handle.net/2027.42/78307>.

Pienta A, McNally J and Gutmann M (2006). "The Research Data Life Cycle
and the Probability of Secondary Use in Re-Analysis." <URL:
http://paa2006.princeton.edu/download.aspx?submissionId=61527>.

Piwowar HA, Day RB and Fridsma DS (2007). "Sharing detailed research
data is associated with increased citation rate." _PLoS ONE_, *2*(3).
<URL: http://dx.doi.org/10.1371%2Fjournal.pone.0000308>.

Piwowar HA, Vision TJ and Whitlock MC (2011). "Data archiving is a good
investment." _Nature_, *473*(7347), pp. 285. ISSN 1476-4687, <URL:
http://dx.doi.org/10.1038/473285a>, <URL:
http://dx.doi.org/10.1038/473285a>.

Piwowar HA (2011). "Who Shares? Who Doesn't? Factors Associated with
Openly Archiving Raw Research Data." _PLoS ONE_, *6*(7), pp. e18657.
ISSN 1932-6203, <URL: http://dx.doi.org/10.1371/journal.pone.0018657>,
<URL: http://dx.plos.org/10.1371/journal.pone.0018657>.

Piwowar HA (????). "Data from: Who shares? Who doesn't? Factors
associated with openly archiving raw research data." <URL:
http://dx.doi.org/10.5061/dryad.mf1sd>, <URL:
http://datadryad.org/handle/10255/dryad.33858>.

Piwowar HA, Carlson JD and Vision TJ (2011). "Beginning to track 1000
datasets from public repositories into the published literature."
_Proceedings of the American Society for Information Science and
Technology_, *48*(1), pp. 1-4. ISSN 00447870, <URL:
http://dx.doi.org/10.1002/meet.2011.14504801337>, <URL:
http://doi.wiley.com/10.1002/meet.2011.14504801337>.

Piwowar H and Chapman W (2010). "Recall and bias of retrieving gene
expression microarray datasets through PubMed identifiers." _Journal of
biomedical discovery and collaboration_, *5*, pp. 7-20. ISSN 1747-5333,
<URL: http://www.ncbi.nlm.nih.gov/pubmed/20349403>.

Sears J (2011). "Data Sharing Effect on Article Citation Rate in
Paleoceanography - KomFor." <URL:
http://www.komfor.net/blog/unbenanntemitteilung>.



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


## Abstract (hasn't been updated)

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
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.



