




# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <code class="knitr inline">Wed Jun  6 07:36:49 2012</code>

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line

    R -e "library(knitr); knit('stats_knit_.md')"; pandoc -r markdown -w html -H header.html stats.md > stats.html
    view in browser: file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/stats.html

to see just the R code in a separate .R file called stats_knit_.R, run 
    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"














# Data availability citation boost consistent with observed rates of data reuse


## Goal
1. Is there an association between data availability and citation rate, independently of important known citation predictors?
1. Is there evidence any increase in citations is related to data reuse?

## Abstract

See the [end of this document](#abstract-1) (at the end so it can pull in results from the R analysis).

## Introduction

"Sharing information facilitates science. Publicly sharing detailed research data–sample attributes, clinical factors, patient outcomes, DNA sequences, raw mRNA microarray measurements–with other researchers allows these valuable resources to contribute far beyond their original analysis[1]. In addition to being used to confirm original results, raw data can be used to explore related or new hypotheses, particularly when combined with other publicly available data sets. Real data is indispensable when investigating and developing study methods, analysis techniques, and software implementations. The larger scientific community also benefits: sharing data encourages multiple perspectives, helps to identify errors, discourages fraud, is useful for training new researchers, and increases efficient use of funding and patient population resources by avoiding duplicate data collection." [Piwowar, Sharing] 

When research data is made publicly available, is there a demonstrable benefit to scientific progress and the study investigators?  

Citations are often used as a proxy for the scientific contribution of a paper.  Citations are also used in research funding and promotion decisions; Boosting citation rate is thus is a potentially important motivator for publication authors.

Previous studies have explored the relationship between the citation rate of a publication and whether its data was made publicly available.  The first study we know about..... In 2007, co-authors and I published a report that found … .  Others have also found correlations between citation rate and data availability.

Here, we report an analysis based on a large cohort of relatively homogenious studies.  The size our cohort has facilitated controlling for many more variables than previous studies, allowing us to make further progress in isolating the citation rate relationship with data archiving itself.

Clinical microarray data provides a useful environment for the investigation: despite being valuable for reuse valuable for reuse [butte] and well-supported by data sharing standards and infrastructure [], fewer than half of the studies that collect this data make it publicly available [Ochsner, Piwowar]

## Methods

Analysis run on <code class="knitr inline">Wed Jun  6 07:36:49 2012</code>.

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

<pre class="knitr"><div class="source"><span class="symbol">dfAttributes</span> <span class="assignement">=</span> <span class="functioncall">read.csv</span><span class="keyword">(</span><span class="string">"data/PLoSONE2011_rawdata.txt"</span><span class="keyword">,</span> <span class="argument">sep</span><span class="argument">=</span><span class="string">"\t"</span><span class="keyword">,</span> <span class="argument">header</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">stringsAsFactors</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">)</span>
</div></pre>


Got the citations from Scopus:

<pre class="knitr"><div class="source"><span class="symbol">dfCitations</span> <span class="assignement">=</span> <span class="functioncall">read.csv</span><span class="keyword">(</span><span class="string">"data/scopus_all.csv"</span><span class="keyword">,</span> <span class="argument">header</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">stringsAsFactors</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">)</span>
</div></pre>


Now merge together attributes with citation information.

<pre class="knitr"><div class="source"><span class="symbol">dfCitationsAttributesRaw</span> <span class="assignement">=</span> <span class="functioncall">merge</span><span class="keyword">(</span><span class="symbol">dfAttributes</span><span class="keyword">,</span> <span class="symbol">dfCitations</span><span class="keyword">,</span> <span class="argument">by.x</span><span class="argument">=</span><span class="string">"pmid"</span><span class="keyword">,</span> <span class="argument">by.y</span><span class="argument">=</span><span class="string">"PubMed.ID"</span><span class="keyword">)</span>
</div></pre>


The dataset has <code class="knitr inline">1.0694 &times; 10<sup>4</sup></code> rows and <code class="knitr inline">196</code>  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

### Statistical analysis


## Results

### Analysis of 11k PLoS articles based on automated determination of data availability

#### Description of cohort


We begin with articles that have been identified as collecting gene expression microarray data by automatic algorithms looking for keywords in article full text (Piwowar 2011).  

<pre class="knitr"><div class="output">## [1] 10555    86
</div></pre>


For this analysis of citation behaviour, we retain articles published between 2001 and 2009: <code class="knitr inline">1.0555 &times; 10<sup>4</sup></code> articles.

The composition of this sample is spread across XXX journals, with the top N journals accounting for XXX% of the papers.

<pre class="knitr"><div class="source"><span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">:</span><span class="number">10</span><span class="keyword">]</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## | Cancer Res               | 0.04 |
## | Proc Natl Acad Sci U S A | 0.04 |
## | J Biol Chem              | 0.04 |
## | BMC Genomics             | 0.03 |
## | Physiol Genomics         | 0.03 |
## | PLoS One                 | 0.02 |
## | J Bacteriol              | 0.02 |
## | J Immunol                | 0.02 |
## | Blood                    | 0.02 |
## | Clin Cancer Res          | 0.02 |
</div></pre>


Collecting gene expression micorarray data became more popular over time: XX% of articles in our sample were published in 2001, compared to YY% in 2009.

<pre class="knitr"><div class="source"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_year_published</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
</div></pre>



Searching for associated datasets in the GEO and ArrayExpress repository uncovered links between XXX% of papers in this sample and publicly available data.  Articles published more recently were more likely to have associated datasets.
<pre class="knitr"><div class="source"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
</div><div class="source">
<span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span>
</div><div class="output">## 
##    0    1 
## 7938 2617 
</div><div class="source">
<span class="symbol">archiving_over_time</span> <span class="assignement">=</span> <span class="functioncall">as.data.frame</span><span class="keyword">(</span><span class="functioncall">prop.table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">pubmed.year.published</span><span class="keyword">,</span> <span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">Var1</span><span class="keyword">,</span> <span class="symbol">Freq</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">archiving_over_time</span><span class="keyword">,</span> <span class="argument">geom</span> <span class="argument">=</span> <span class="string">"line"</span><span class="keyword">,</span> <span class="argument">colour</span> <span class="argument">=</span> <span class="symbol">Var2</span><span class="keyword">,</span> <span class="argument">group</span> <span class="argument">=</span> <span class="symbol">Var2</span><span class="keyword">)</span>
</div><img src="figure/unnamed-chunk-8.png" class="plot" />
</pre>


The articles in our sample were cited between 0 and 2640 times, with an average of 32 citations per paper and a median of 16.  

Without accounting for any confounding factors, the mean number of citations between papers with available data and those without are the same, and there is little visible difference in the distribution of citations between these two groups.

<pre class="knitr"><div class="source"><span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span>
</div><div class="output">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.5    35.0  2640.0 
</div><div class="source">
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span> <span class="symbol">summary</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
</div><div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_density</span><span class="keyword">(</span><span class="argument">alpha</span><span class="argument">=</span><span class="number">0.2</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/unnamed-chunk-9.png" class="plot" />
</pre>


#### Multivariate visualization

The number of citations a paper has recieved is strongly correlated to the date it was published: older papers have had more time to accumulate citations.  Because data archiving was relatively infrequent for articles published earlier, a difference in citation behaviour may be confounded with publication date.

Indeed, we can see that for any given publication date, papers with associated data recieve more citations than those without.
<pre class="knitr"><div class="output">## 2001 2002 2003 2004 2005 2006 2007 2008 2009 
## 76.0 54.0 40.0 30.0 24.0 18.0 14.0  9.5  5.0 
</div><img src="figure/univariateqplots.png" class="plot" />
</pre>

    
This difference in citation is not driven by outliers: as shown by the distribution of citations over time, the distribution of citations for older papers with available data is centered at a higher median than citations for papers without data available.

<pre class="knitr"><img src="figure/unnamed-chunk-10.png" class="plot" />
</pre>


These differences could be because journals with high impact are more likely to require data archiving.  To investigate this, we consider the most common 12 journals in our subset.  Journal by journal, the mean citation rate for papers with data available is not always greater tahn the citation rate of papers without data available.

<pre class="knitr"><img src="figure/byjournal.png" class="plot" />
</pre>


We turn again to the distribution of citaiton rates to understand the patterns in more depth.  Considering only papers published in 2005, we see that papers with available data do tend to receive more citations than those without.  Molecular Cell Biology and Blood are perhaps exceptions to this trend.

<pre class="knitr"><div class="source"><span class="functioncall">ggplot</span><span class="keyword">(</span><span class="argument">data</span><span class="argument">=</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dat_most_common_journals</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed_year_published</span>==<span class="string">"2005"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_density</span><span class="keyword">(</span><span class="argument">alpha</span><span class="argument">=</span><span class="number">0.2</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">facet_grid</span><span class="keyword">(</span><span class="symbol">pubmed_journal</span> <span class="keyword">~</span> <span class="symbol">.</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/unnamed-chunk-11.png" class="plot" />
<div class="source">
<span class="functioncall">with</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dat_most_common_journals</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed_year_published</span>==<span class="string">"2005"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">prop.table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">pubmed_journal</span><span class="keyword">,</span> <span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">margin</span><span class="argument">=</span><span class="number">1</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">##                           in_ae_or_geo
## pubmed_journal                  0      1
##   Blood                    0.8750 0.1250
##   Cancer Res               0.7797 0.2203
##   Clin Cancer Res          0.8571 0.1429
##   J Bacteriol              0.8400 0.1600
##   J Biol Chem              0.7660 0.2340
##   J Immunol                0.8125 0.1875
##   Mol Cell Biol            0.7931 0.2069
##   Physiol Genomics         0.1875 0.8125
##   Plant Physiol            0.7037 0.2963
##   Proc Natl Acad Sci U S A 0.8125 0.1875
</div></pre>


#### Multivariate regression

Other factors are also known or suspected to be correlated with citation rate, including number of authors, author experience, author institution, open access status, and subject area.  Regression analysis can be useful to identify the relationship between data availability and citation rate, independently of these other variables.

<pre class="knitr"><div class="source">
<span class="symbol">fit_w_journal</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">)</span> <span class="keyword">+</span>
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
          <span class="comment">#rcs(journal.impact.factor.tr, 3) +               </span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.animals</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.plants</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.core.clinical.journal</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
           <span class="keyword">,</span> <span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span>

<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">fit_w_journal</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |                                              | Df      | Sum Sq  | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|---------|---------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00    | 165.11  | 82.56   | 164.95  | 0.00   |
## | factor(journal.impact.factor.tr)             | 413.00  | 1631.64 | 3.95    | 7.89    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1282.44 | 641.22  | 1281.17 | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 1.25    | 0.62    | 1.25    | 0.29   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 24.19   | 12.10   | 24.17   | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 0.82    | 0.41    | 0.82    | 0.44   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 5.65    | 2.83    | 5.65    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 10.64   | 5.32    | 10.63   | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 1.37    | 0.69    | 1.37    | 0.25   |
## | country.usa                                  | 1.00    | 1.10    | 1.10    | 2.21    | 0.14   |
## | pubmed.is.open.access                        | 1.00    | 0.19    | 0.19    | 0.38    | 0.54   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 0.53    | 0.26    | 0.52    | 0.59   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00    | 5.04    | 2.52    | 5.04    | 0.01   |
## | rcs(journal.cited.halflife, 3)               | 2.00    | 2.78    | 1.39    | 2.78    | 0.06   |
## | factor(pubmed.is.cancer)                     | 1.00    | 0.10    | 0.10    | 0.21    | 0.65   |
## | factor(pubmed.is.animals)                    | 1.00    | 19.50   | 19.50   | 38.97   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 3.78    | 3.78    | 7.55    | 0.01   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 9.34    | 9.34    | 18.66   | 0.00   |
## | Residuals                                    | 3931.00 | 1967.45 | 0.50    |         |        |
</div><div class="source">
<span class="comment"># fit_w_journal</span>
<span class="symbol">citation.boost.coefs.journal</span> <span class="assignement">=</span> <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">fit_w_journal</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
<span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">citation.boost.coefs.journal</span><span class="keyword">)</span>
</div><div class="output">##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  1.05   1.13 0
</div></pre>


Estimate of citation boost is 
<code class="knitr inline">9</code>%
with 95% confidence intervals [<code class="knitr inline">5</code>%
, <code class="knitr inline">13</code>% ]
(p=<code class="knitr inline">0.00</code>)

Because publication rate is such as strong correlate with both citation rate and data availability, we also ran regressions for each publication year individually.

<pre class="knitr"><div class="source">
<span class="comment"># has a few less covariates than full model</span>
<span class="symbol">do_analysis</span> <span class="assignement">=</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">mydat</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">myfit</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="symbol">pubmed.is.open.access</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.num.articles.2008.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">)</span> <span class="keyword">+</span>
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
  <span class="symbol">dat.subset.year</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="symbol">pubmed.year.published</span>==<span class="symbol">year</span><span class="keyword">)</span>
  <span class="symbol">results</span> <span class="assignement">=</span> <span class="functioncall">do_analysis</span><span class="keyword">(</span><span class="symbol">dat.subset.year</span><span class="keyword">)</span>
  <span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">results</span><span class="keyword">)</span>
  <span class="symbol">estimates_by_year</span> <span class="assignement">=</span> <span class="functioncall">rbind</span><span class="keyword">(</span><span class="symbol">estimates_by_year</span><span class="keyword">,</span> <span class="functioncall">cbind</span><span class="keyword">(</span><span class="argument">year</span><span class="argument">=</span><span class="symbol">year</span><span class="keyword">,</span> <span class="symbol">results</span><span class="keyword">)</span><span class="keyword">)</span>
<span class="keyword">}</span>
</div><div class="output">## |                                              | Df    | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|-------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00  | 10.07  | 5.03    | 8.33    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00  | 0.49   | 0.24    | 0.40    | 0.67   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00  | 2.52   | 1.26    | 2.09    | 0.13   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00  | 14.09  | 7.04    | 11.66   | 0.00   |
## | pubmed.is.open.access                        | 1.00  | 0.02   | 0.02    | 0.03    | 0.87   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00  | 5.78   | 2.89    | 4.78    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00  | 0.96   | 0.48    | 0.79    | 0.46   |
## | factor(journal.impact.factor.tr)             | 36.00 | 20.74  | 0.58    | 0.95    | 0.55   |
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
## | factor(journal.impact.factor.tr)             | 84.00  | 107.20 | 1.28    | 2.39    | 0.00   |
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
## | factor(journal.impact.factor.tr)             | 123.00 | 105.18 | 0.86    | 1.75    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.02   | 1.02    | 2.09    | 0.15   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.80   | 2.80    | 5.74    | 0.02   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.34   | 0.34    | 0.69    | 0.41   |
## | Residuals                                    | 234.00 | 114.31 | 0.49    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  0.89   1.35 0.407
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.77  | 12.39   | 23.47   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.73   | 2.87    | 5.43    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 22.94  | 11.47   | 21.73   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 23.95  | 11.97   | 22.70   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 6.66   | 6.66    | 12.63   | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.72   | 1.36    | 2.58    | 0.08   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 9.60   | 4.80    | 9.10    | 0.00   |
## | factor(journal.impact.factor.tr)             | 161.00 | 171.10 | 1.06    | 2.01    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.16   | 0.16    | 0.30    | 0.58   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.11   | 0.11    | 0.22    | 0.64   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 4.44   | 4.44    | 8.42    | 0.00   |
## | Residuals                                    | 333.00 | 175.71 | 0.53    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.24  1.07   1.43 0.004
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 25.81  | 12.90   | 28.11   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 0.60   | 0.30    | 0.66    | 0.52   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 23.89  | 11.94   | 26.02   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 12.34  | 6.17    | 13.44   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.04   | 0.04    | 0.10    | 0.76   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 7.80   | 3.90    | 8.49    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 15.58  | 7.79    | 16.97   | 0.00   |
## | factor(journal.impact.factor.tr)             | 187.00 | 157.41 | 0.84    | 1.83    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.34   | 1.34    | 2.93    | 0.09   |
## | factor(pubmed.is.animals)                    | 1.00   | 1.07   | 1.07    | 2.33    | 0.13   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 7.21   | 7.21    | 15.70   | 0.00   |
## | Residuals                                    | 383.00 | 175.81 | 0.46    |         |        |
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
## | factor(journal.impact.factor.tr)             | 181.00 | 191.32 | 1.06    | 2.19    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.14   | 0.14    | 0.28    | 0.59   |
## | factor(pubmed.is.animals)                    | 1.00   | 8.09   | 8.09    | 16.76   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 1.15   | 1.15    | 2.37    | 0.12   |
## | Residuals                                    | 383.00 | 184.77 | 0.48    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  0.98   1.23 0.124
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.19  | 12.10   | 26.64   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.35   | 2.67    | 5.89    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 11.75  | 5.88    | 12.94   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 11.00  | 5.50    | 12.11   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.01   | 0.01    | 0.01    | 0.90   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.76   | 1.38    | 3.04    | 0.05   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 5.52   | 2.76    | 6.08    | 0.00   |
## | factor(journal.impact.factor.tr)             | 212.00 | 189.94 | 0.90    | 1.97    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.07   | 0.07    | 0.15    | 0.70   |
## | factor(pubmed.is.animals)                    | 1.00   | 1.68   | 1.68    | 3.70    | 0.06   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.14   | 0.14    | 0.30    | 0.58   |
## | Residuals                                    | 502.00 | 227.95 | 0.45    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.03  0.94   1.13 0.581
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 40.91  | 20.46   | 37.00   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.79    | 14.08   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 6.76   | 3.38    | 6.11    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 16.74  | 8.37    | 15.14   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.13   | 2.13    | 3.86    | 0.05   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.44   | 2.72    | 4.92    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 10.35  | 5.18    | 9.36    | 0.00   |
## | factor(journal.impact.factor.tr)             | 221.00 | 193.90 | 0.88    | 1.59    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.00   | 0.00    | 0.00    | 0.98   |
## | factor(pubmed.is.animals)                    | 1.00   | 5.28   | 5.28    | 9.55    | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.05   | 0.05    | 0.08    | 0.77   |
## | Residuals                                    | 448.00 | 247.66 | 0.55    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.02  0.91   1.13 0.774
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 43.96  | 21.98   | 50.25   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.78    | 17.80   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 7.31   | 3.65    | 8.35    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 10.94  | 5.47    | 12.51   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.57   | 0.57    | 1.30    | 0.26   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 8.23   | 4.11    | 9.40    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 7.82   | 3.91    | 8.94    | 0.00   |
## | factor(journal.impact.factor.tr)             | 202.00 | 182.24 | 0.90    | 2.06    | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.01   | 0.01    | 0.02    | 0.90   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.41   | 2.41    | 5.52    | 0.02   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.40   | 0.40    | 0.91    | 0.34   |
## | Residuals                                    | 333.00 | 145.66 | 0.44    |         |        |
##                                   param  est ciLow ciHigh    p
## Estimate factor(dataset.in.geo.or.ae).L 0.95  0.85   1.06 0.34
</div></pre>


The estimates of citation boost for papers published in each year, with 95% confidence intervals:

<pre class="knitr"><div class="source">
<span class="symbol">estimates_by_year</span>
</div><div class="output">##           year                          param  est ciLow ciHigh     p
## Estimate  2001 factor(dataset.in.geo.or.ae).L 1.31  0.68   2.54 0.422
## Estimate1 2002 factor(dataset.in.geo.or.ae).L 1.09  0.82   1.45 0.559
## Estimate2 2003 factor(dataset.in.geo.or.ae).L 1.09  0.89   1.35 0.407
## Estimate3 2004 factor(dataset.in.geo.or.ae).L 1.24  1.07   1.43 0.004
## Estimate4 2005 factor(dataset.in.geo.or.ae).L 1.30  1.14   1.48 0.000
## Estimate5 2006 factor(dataset.in.geo.or.ae).L 1.09  0.98   1.23 0.124
## Estimate6 2007 factor(dataset.in.geo.or.ae).L 1.03  0.94   1.13 0.581
## Estimate7 2008 factor(dataset.in.geo.or.ae).L 1.02  0.91   1.13 0.774
## Estimate8 2009 factor(dataset.in.geo.or.ae).L 0.95  0.85   1.06 0.340
</div><div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">estimates_by_year</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">year</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="symbol">est</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_line</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_errorbar</span><span class="keyword">(</span><span class="argument">width</span><span class="argument">=</span><span class="number">.1</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">ymin</span><span class="argument">=</span><span class="symbol">ciLow</span><span class="keyword">,</span> <span class="argument">ymax</span><span class="argument">=</span><span class="symbol">ciHigh</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">'year of publication'</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">limits</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">0</span><span class="keyword">,</span> <span class="number">3.0</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">name</span><span class="argument">=</span><span class="string">'citations proportion for \n(papers with available data)/(those without)'</span><span class="keyword">)</span>
</div><img src="figure/unnamed-chunk-14.png" class="plot" />
</pre>


    

##### Comparison with old study

These results are slightly different than 

<pre class="knitr"><div class="source">
<span class="comment"># Using analysis method of splines, consistent with current study</span>

  <span class="symbol">dat.subset.previous.study</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed.year.published</span><span class="keyword">&lt;</span><span class="number">2003</span><span class="keyword">)</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span>==<span class="number">1</span><span class="keyword">)</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">pubmed.is.humans</span>==<span class="number">1</span><span class="keyword">)</span><span class="keyword">)</span>

  <span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>
</div><div class="output">## [1] 308  86
</div><div class="source">
  <span class="symbol">myfitprev</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span>
    <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
    <span class="symbol">country.usa</span> <span class="keyword">+</span>
    <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
    <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
               <span class="keyword">,</span> <span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>

  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |                                  | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------|--------|--------|---------|---------|--------|
## | rcs(pubmed.date.in.pubmed, 3)    | 2.00   | 5.33   | 2.67    | 3.27    | 0.04   |
## | country.usa                      | 1.00   | 0.00   | 0.00    | 0.01    | 0.94   |
## | rcs(journal.impact.factor.tr, 3) | 2.00   | 68.86  | 34.43   | 42.26   | 0.00   |
## | factor(dataset.in.geo.or.ae)     | 1.00   | 4.35   | 4.35    | 5.34    | 0.02   |
## | Residuals                        | 294.00 | 239.53 | 0.81    |         |        |
</div><div class="source">
  <span class="symbol">myfitprev</span>
</div><div class="output">## 
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
</div><div class="source">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</div><div class="output">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.47  1.06   2.03 0.021
</div><div class="source">
<span class="comment"># Using analysis method of linear fit, consistent with previous study</span>

  <span class="symbol">myfitprev</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span>
    <span class="symbol">pubmed.date.in.pubmed</span> <span class="keyword">+</span>
    <span class="symbol">country.usa</span> <span class="keyword">+</span>
    <span class="symbol">journal.impact.factor.tr</span> <span class="keyword">+</span>
    <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
               <span class="keyword">,</span> <span class="symbol">dat.subset.previous.study</span><span class="keyword">)</span>

  <span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |------------------------------|--------|--------|---------|---------|--------|
## | pubmed.date.in.pubmed        | 1.00   | 4.87   | 4.87    | 6.01    | 0.01   |
## | country.usa                  | 1.00   | 0.00   | 0.00    | 0.01    | 0.94   |
## | journal.impact.factor.tr     | 1.00   | 68.74  | 68.74   | 84.83   | 0.00   |
## | factor(dataset.in.geo.or.ae) | 1.00   | 4.60   | 4.60    | 5.67    | 0.02   |
## | Residuals                    | 296.00 | 239.87 | 0.81    |         |        |
</div><div class="source">
  <span class="symbol">myfitprev</span>
</div><div class="output">## 
## Call:
## lm(formula = nCitedBy.log ~ pubmed.date.in.pubmed + country.usa + 
##     journal.impact.factor.tr + factor(dataset.in.geo.or.ae), 
##     data = dat.subset.previous.study)
## 
## Coefficients:
##                    (Intercept)           pubmed.date.in.pubmed  
##                      20.818070                       -0.000519  
##                  country.usa.L        journal.impact.factor.tr  
##                       0.016077                        0.800118  
## factor(dataset.in.geo.or.ae).L  
##                       0.392178  
## 
</div><div class="source">
  <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">myfitprev</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
</div><div class="output">##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.48  1.07   2.04 0.018
</div></pre>



### Subset, manual classification of data availability 

<pre class="knitr"><div class="source">
<span class="symbol">dfAnnotations</span> <span class="assignement">=</span> <span class="functioncall">read.csv</span><span class="keyword">(</span><span class="string">"data/Mendeley_annotated_250_of_11k.csv"</span><span class="keyword">,</span> <span class="argument">header</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">stringsAsFactors</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">)</span>

<span class="comment"># Get subset that has been annotated</span>
<span class="symbol">dfAnnotationsAnnotated</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfAnnotations</span><span class="keyword">,</span> <span class="symbol">TAG.annotated</span> == <span class="string">"11k-subset-reviewed"</span><span class="keyword">)</span>

<span class="comment"># Merge together annotations with citation information</span>
<span class="symbol">dfCitationsAnnotated</span> <span class="assignement">=</span> <span class="functioncall">merge</span><span class="keyword">(</span><span class="symbol">dfAnnotationsAnnotated</span><span class="keyword">,</span> <span class="symbol">dfCitations</span><span class="keyword">,</span> <span class="argument">by.x</span><span class="argument">=</span><span class="string">"pmid"</span><span class="keyword">,</span> <span class="argument">by.y</span><span class="argument">=</span><span class="string">"PubMed.ID"</span><span class="keyword">)</span>

<span class="comment"># Clean the data, get variables in useful formats</span>
<span class="symbol">dfCitationsAnnotated</span><span class="keyword">$</span><span class="symbol">isCreated</span> <span class="assignement">=</span> <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">$</span><span class="symbol">TAG.created</span><span class="keyword">)</span>
<span class="symbol">dfCitationsAnnotated</span><span class="keyword">$</span><span class="symbol">nCitedBy</span> <span class="assignement">=</span> <span class="functioncall">as.numeric</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">$</span><span class="symbol">Cited.by</span><span class="keyword">)</span>
</div></pre>



<pre class="knitr"><div class="source">
<span class="comment"># Dig in to looking at annotated subset</span>

<span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">)</span>
</div><div class="output">## [1] 230  62
</div><div class="source"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## isCreated
##     created-microarray-data created-microarray-data-not 
##                         210                          20 
</div><div class="source"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## nCitedBy    N=226, 4 Missing
## 
## +---------+---------------------------+---+--------+
## |         |                           |  N|nCitedBy|
## +---------+---------------------------+---+--------+
## |isCreated|    created-microarray-data|206|   31.86|
## |         |created-microarray-data-not| 20|   26.30|
## +---------+---------------------------+---+--------+
## |  Overall|                           |226|   31.37|
## +---------+---------------------------+---+--------+
</div><div class="source"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">summary</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## log(1 + nCitedBy)    N=226, 4 Missing
## 
## +---------+---------------------------+---+-----------------+
## |         |                           |  N|log(1 + nCitedBy)|
## +---------+---------------------------+---+-----------------+
## |isCreated|    created-microarray-data|206|            2.991|
## |         |created-microarray-data-not| 20|            2.632|
## +---------+---------------------------+---+-----------------+
## |  Overall|                           |226|            2.959|
## +---------+---------------------------+---+-----------------+
</div><div class="source">
<span class="comment">#library(ggplot2)</span>

<span class="comment"># Do they look different</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">)</span>
</div><img src="figure/unnamed-chunk-171.png" class="plot" />
<div class="source"><span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="symbol">isCreated</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="string">"density"</span><span class="keyword">,</span> <span class="argument">binwidth</span><span class="argument">=</span><span class="number">25</span><span class="keyword">)</span>
</div><img src="figure/unnamed-chunk-172.png" class="plot" />
<div class="source"><span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">isCreated</span><span class="keyword">,</span> <span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="string">"boxplot"</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="argument">position</span><span class="argument">=</span><span class="functioncall">position_jitter</span><span class="keyword">(</span><span class="argument">width</span><span class="argument">=</span><span class="number">.1</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="string">"blue"</span><span class="keyword">)</span>
</div><img src="figure/unnamed-chunk-173.png" class="plot" />
</pre>



<pre class="knitr"><div class="source">
<span class="comment"># Do they have different distributions</span>
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">t.test</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## 
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
</div><div class="source"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">t.test</span><span class="keyword">(</span><span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## 
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
</div><div class="source"><span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">wilcox.test</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">~</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  nCitedBy by isCreated 
## W = 2440, p-value = 0.1733
## alternative hypothesis: true location shift is not equal to 0 
## 
</div><div class="source">
<span class="comment"># Now look if just created has the same pattern </span>

<span class="symbol">dat.annotated.merged</span> <span class="assignement">=</span> <span class="functioncall">merge</span><span class="keyword">(</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="argument">by</span><span class="argument">=</span><span class="string">"pmid"</span><span class="keyword">)</span>
<span class="symbol">dat.annotated.merged.created</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dat.annotated.merged</span><span class="keyword">,</span> <span class="symbol">isCreated</span>==<span class="functioncall">levels</span><span class="keyword">(</span><span class="symbol">isCreated</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span><span class="keyword">)</span>

<span class="comment">#library(rms)</span>

<span class="symbol">fit.annotated.merged</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
<span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
 <span class="symbol">dataset.in.geo.or.ae</span>
           <span class="keyword">,</span> <span class="symbol">dat.annotated.merged.created</span><span class="keyword">)</span>
<span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">fit.annotated.merged</span><span class="keyword">)</span>
</div><div class="output">## Analysis of Variance Table
## 
## Response: nCitedBy.log
##                                   Df Sum Sq Mean Sq F value   Pr(>F)    
## rcs(num.authors.tr, 3)             2   11.1     5.6    9.62  0.00011 ***
## rcs(pubmed.date.in.pubmed, 3)      2   82.3    41.1   71.00  < 2e-16 ***
## rcs(journal.impact.factor.tr, 3)   2   13.6     6.8   11.76 0.000016 ***
## dataset.in.geo.or.ae               1    5.5     5.5    9.51  0.00235 ** 
## Residuals                        186  107.7     0.6                     
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
</div><div class="source"><span class="functioncall">print</span><span class="keyword">(</span><span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">fit.annotated.merged</span><span class="keyword">,</span> <span class="string">"dataset.in.geo.or.ae.L"</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">##                           param  est ciLow ciHigh     p
## Estimate dataset.in.geo.or.ae.L 1.31   1.1   1.55 0.002
</div><div class="source"><span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dat.annotated.merged.created</span><span class="keyword">)</span>
</div><div class="output">## [1] 210 147
</div></pre>



## Dig into tracking 1k

<pre class="knitr"><div class="source">
<span class="symbol">dfTracking1k</span> <span class="assignement">=</span> <span class="functioncall">read.csv</span><span class="keyword">(</span><span class="string">"data/tracking1k_20111008.csv"</span><span class="keyword">,</span> <span class="argument">sep</span><span class="argument">=</span><span class="string">","</span><span class="keyword">,</span> <span class="argument">header</span><span class="argument">=</span><span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">stringsAsFactors</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">)</span>

<span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfTracking1k</span><span class="keyword">)</span>
</div><div class="output">## [1] 852  38
</div><div class="source"><span class="comment">#names(dfTracking1k)</span>

<span class="symbol">dfTracking1k.GEO.subset</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfTracking1k</span><span class="keyword">,</span> <span class="symbol">TAG.source</span>==<span class="string">"WoS"</span> <span class="keyword">&amp;</span> <span class="symbol">TAG.confidence</span><span class="keyword">!=</span><span class="string">"low confidence"</span> <span class="keyword">&amp;</span> <span class="functioncall">is.na</span><span class="keyword">(</span><span class="symbol">duplicates</span> <span class="keyword">&amp;</span> <span class="symbol">TAG.repository</span>==<span class="string">"GEO"</span> <span class="keyword">&amp;</span> <span class="keyword">(</span><span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset reused"</span> <span class="keyword">|</span> <span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset not reused"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="symbol">num.GEO.total</span> <span class="assignement">=</span> <span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfTracking1k.GEO.subset</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>
<span class="symbol">num.GEO.reused</span> <span class="assignement">=</span> <span class="functioncall">dim</span><span class="keyword">(</span><span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfTracking1k.GEO.subset</span><span class="keyword">,</span> <span class="symbol">TAG.dataset.reused</span>==<span class="string">"dataset reused"</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>

<span class="symbol">annotated.prop</span> <span class="assignement">=</span> <span class="functioncall">binconf</span><span class="keyword">(</span><span class="symbol">num.GEO.reused</span><span class="keyword">,</span> <span class="symbol">num.GEO.total</span><span class="keyword">)</span>
</div></pre>



Proportion of citations to datasets that were in the context of data use (n=<code class="knitr inline">138</code>):
<code class="knitr inline">6</code>%
with 95% confidence intervals [<code class="knitr inline">3</code>%
, <code class="knitr inline">11</code>% ]


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
<div class="output">[1] "(Boettiger, 2012)"
</div>


Now cite everyone! 
<div class="output">[1] "(Bollen _et. al._ 2009; Chavan & Ingwersen, 2009; Gleditsch & Strand, 2003; Ib\\'{a}\\~{n}ez _et. al._ 2009; Ioannidis _et. al._ 2009; Ochsner _et. al._ 2008; Pienta _et. al._ 2010; Pienta _et. al._ 2006; Piwowar _et. al._ 2007; Piwowar _et. al._ 2011; Piwowar, 2011; character(0); Piwowar _et. al._ 2011; Piwowar & Chapman, 2010; Sears, 2011)"
</div>


### demo bibliography

<div class="output">Boettiger C (2012). _knitcitations: Citations for knitr markdown
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
</div>


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
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.


#### Extra results

<pre class="knitr"><div class="source">
<span class="comment"># Number of papers vs Data availability</span>
<span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">&gt;=</span><span class="number">0</span><span class="keyword">,</span>
       <span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span>
       <span class="symbol">sum</span><span class="keyword">)</span>
</div><div class="output">##    0    1 
## 7938 2617 
</div><div class="source">
<span class="comment"># Number of citations vs Data availability</span>
<span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">,</span>
       <span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span>
       <span class="symbol">sum</span><span class="keyword">)</span>
</div><div class="output">##      0      1 
## 250620  81892 
</div><div class="source">
<span class="comment"># Number of citations vs Data availability</span>
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span> <span class="symbol">summary</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
</div><div class="source">
<span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span>
</div><div class="output">## 
##    0    1 
## 7938 2617 
</div></pre>

    
<pre class="knitr"><div class="source">
<span class="symbol">myhetcorr</span> <span class="assignement">=</span> <span class="functioncall">hetcor.modified</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">,</span> <span class="argument">use</span><span class="argument">=</span><span class="string">"pairwise.complete.obs"</span><span class="keyword">,</span> <span class="argument">std.err</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">,</span> <span class="argument">pd</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">)</span>
<span class="symbol">mycor</span> <span class="assignement">=</span> <span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span>
<span class="functioncall">colnames</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">)</span> <span class="assignement">=</span> <span class="functioncall">colnames</span><span class="keyword">(</span><span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span><span class="keyword">)</span>
<span class="functioncall">rownames</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">)</span> <span class="assignement">=</span> <span class="functioncall">rownames</span><span class="keyword">(</span><span class="symbol">myhetcorr</span><span class="keyword">$</span><span class="symbol">correlations</span><span class="keyword">)</span>

<span class="comment"># Correlations with data availability</span>
<span class="comment">## See if anything is so collinear it will cause problems in regression</span>
<span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"dataset.in.geo.or.ae.int"</span><span class="keyword">]</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## | dataset.in.geo                                | 1     |
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
</div><div class="source">
<span class="comment"># Correlations with citation</span>
<span class="symbol">a</span> <span class="assignement">=</span> <span class="functioncall">sort</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"nCitedBy.log"</span><span class="keyword">]</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">cbind</span><span class="keyword">(</span><span class="functioncall">names</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">)</span><span class="keyword">,</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">a</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## | nCitedBy.log                                  | 1     |
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
</div><div class="source">
<span class="symbol">univarate.citation.predictors</span> <span class="assignement">=</span> <span class="functioncall">which</span><span class="keyword">(</span><span class="functioncall">abs</span><span class="keyword">(</span><span class="symbol">mycor</span><span class="keyword">[</span><span class="keyword">,</span><span class="string">"nCitedBy.log"</span><span class="keyword">]</span><span class="keyword">)</span> <span class="keyword">&gt;</span> <span class="number">0.1</span><span class="keyword">)</span>
<span class="comment">#univarate.citation.predictors</span>
<span class="functioncall">length</span><span class="keyword">(</span><span class="symbol">univarate.citation.predictors</span><span class="keyword">)</span>
</div><div class="output">## [1] 36
</div><div class="source"><span class="symbol">topcor</span> <span class="assignement">=</span> <span class="symbol">mycor</span><span class="keyword">[</span><span class="symbol">univarate.citation.predictors</span><span class="keyword">,</span> <span class="symbol">univarate.citation.predictors</span><span class="keyword">]</span>
</div></pre>

    
<pre class="knitr"><div class="source">
<span class="functioncall">heatmap.2</span><span class="keyword">(</span><span class="symbol">topcor</span><span class="keyword">,</span> <span class="argument">col</span><span class="argument">=</span><span class="functioncall">bluered</span><span class="keyword">(</span><span class="number">16</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">cexRow</span><span class="argument">=</span><span class="number">1</span><span class="keyword">,</span> <span class="argument">cexCol</span> <span class="argument">=</span> <span class="number">1</span><span class="keyword">,</span> <span class="argument">symm</span> <span class="argument">=</span> <span class="number">TRUE</span><span class="keyword">,</span> <span class="argument">dend</span> <span class="argument">=</span> <span class="string">"row"</span><span class="keyword">,</span> <span class="argument">trace</span> <span class="argument">=</span> <span class="string">"none"</span><span class="keyword">,</span> <span class="argument">main</span> <span class="argument">=</span> <span class="string">"Thesis Data"</span><span class="keyword">,</span> <span class="argument">margins</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">15</span><span class="keyword">,</span><span class="number">15</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">key</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">,</span> <span class="argument">keysize</span><span class="argument">=</span><span class="number">0.1</span><span class="keyword">)</span>
</div><img src="figure/heatmap42.png" class="plot" />
<div class="error">## Error: figure margins too large
</div></pre>

<pre class="knitr"><div class="source">
<span class="comment">##Other breakdowns</span>

<span class="symbol">num_authors_breaks</span> <span class="assignement">=</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">,</span> <span class="number">5</span><span class="keyword">,</span> <span class="number">10</span><span class="keyword">,</span> <span class="number">20</span><span class="keyword">,</span> <span class="number">40</span><span class="keyword">)</span>
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="functioncall">cut</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="symbol">num_authors_breaks</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">median</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">##   (1,5]  (5,10] (10,20] (20,40] 
##      16      38      53      NA 
</div><div class="source">
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">num_authors_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">num_authors_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots31.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.core.clinical.journal</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots32.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.open.access</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots33.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots34.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.humans</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots35.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.cultured.cells</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots36.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">has.R.funding</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots37.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">country.usa</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots38.png" class="plot" />
<div class="source">
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">num.grants.via.nih.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots39.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.microarray.creations.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.microarray.creations.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots310.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">first.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots311.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots312.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">,</span> <span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">group</span><span class="argument">=</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span> <span class="keyword">+</span> <span class="functioncall">coord_flip</span><span class="keyword">(</span><span class="keyword">)</span>
</div><img src="figure/univariateqplots313.png" class="plot" />
<div class="source">

<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots314.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"black"</span><span class="keyword">,</span> <span class="argument">fill</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="figure/univariateqplots315.png" class="plot" />
</pre>



