




# citation11k stats 
 * author Heather Piwowar, <hpiwowar@gmail.com>
 * license: CC0
 * Acknowledgements: thanks to Carl Boettiger and knitr for this literate programming framework!
 * Generated on <code class="knitr inline">Sat May 19 20:26:45 2012</code>

To run this I start R, set the working directory to match where this file is, then run the following in R:

    library(knitr)  
    knit("stats_knit_.md")

or, from the command line

    R -e "library(knitr); knit('stats_knit_.md')"
    pandoc -r markdown -w html -H header.html stats.md > stats.html
    file:///Users/hpiwowar/Documents/Projects/citation%20benefit%20in%2011k%20study/citation11k/analysis/stats.html

to see just the R code in a separate .R file called stats_knit_.R, run 
    R -e "library(knitr); knit('stats_knit_.md', tangle=T)"











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

Analysis run on <code class="knitr inline">Sat May 19 20:26:48 2012</code>.

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


The dataset has <code class="knitr inline">10694</code> rows and <code class="knitr inline">196</code>  columns.  

This is a lot of columns: all the columns from the PLoS study plus all of the Scopus columns.  We will only use a subset of them in this study.

### Statistical analysis


## Results

####Preprocessing


Limit to just those published after 2001 and before 2010.

<pre class="knitr"><div class="source"><span class="symbol">dfCitationsAttributesRaw</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_year_published</span> <span class="keyword">&gt;</span> <span class="number">2000</span><span class="keyword">)</span>
<span class="symbol">dfCitationsAttributesRaw</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_year_published</span> <span class="keyword">&lt;</span> <span class="number">2010</span><span class="keyword">)</span>
<span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span>
</div><div class="output">## [1] 10555   196
</div></pre>


Get citations into the right format

<pre class="knitr"><div class="source"><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">nCitedBy</span> <span class="assignement">=</span> <span class="functioncall">as.numeric</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">Cited.by</span><span class="keyword">)</span>
<span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">[</span><span class="functioncall">which</span><span class="keyword">(</span><span class="functioncall">is.na</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">,</span><span class="keyword">]</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="assignement">=</span><span class="number">0</span>
<span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span>
</div><div class="output">## [1] 10555   197
</div><div class="source">
<span class="symbol">dfCitationsAttributes</span> <span class="assignement">=</span> <span class="functioncall">preprocess.raw.data</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span>
<span class="functioncall">dim</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span>
</div><div class="output">## [1] 10555    86
</div><div class="source"><span class="functioncall">options</span><span class="keyword">(</span><span class="argument">scipen</span><span class="argument">=</span><span class="number">8</span><span class="keyword">)</span>
</div></pre>



The dataset has <code class="knitr inline">10555</code> rows and <code class="knitr inline">86</code>  columns. 




### Analysis of 11k PLoS articles based on automated determination of data availability

#### Description of cohort

The PLoS study had <code class="knitr inline">11603</code> rows.  For this study we exclude extreme years.

The dataset has <code class="knitr inline">10555</code> rows and <code class="knitr inline">86</code>  columns.  


Distribution by journal
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


Distribution by year
<pre class="knitr"><div class="source"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_year_published</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |   | 2001 | 2002 | 2003 | 2004 | 2005 | 2006 | 2007 | 2008 | 2009 |
## |---|------|------|------|------|------|------|------|------|------|
## | 1 | 0.02 | 0.05 | 0.08 | 0.11 | 0.13 | 0.12 | 0.17 | 0.18 | 0.15 |
</div><div class="source">
<span class="comment">#library(ggplot2)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed_year_published</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="string">"boxplot"</span><span class="keyword">,</span> <span class="argument">log</span><span class="argument">=</span><span class="string">"y"</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="argument">color</span><span class="argument">=</span><span class="string">"blue"</span><span class="keyword">,</span> <span class="argument">alpha</span><span class="argument">=</span><span class="number">0.1</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/D2uNQ.png" class="plot" />
</pre>


Distribution by data availability
<pre class="knitr"><div class="source"><span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |   | 0    | 1    |
## |---|------|------|
## | 1 | 0.75 | 0.25 |
</div></pre>


Distribution by citation

The dataset has <code class="knitr inline">10555</code> rows and <code class="knitr inline">86</code>  columns.  


<pre class="knitr"><div class="source">
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/72EYJ.png" class="plot" />
</pre>


<pre class="knitr"><div class="source"><span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributes</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">)</span>
</div><div class="output">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.5    35.0  2640.0 
</div></pre>


#### Univariate

<pre class="knitr"><div class="source">
<span class="symbol">dat</span> <span class="assignement">=</span> <span class="symbol">dfCitationsAttributes</span>

<span class="comment"># Number of papers vs Data availability</span>
<span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">dat</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">&gt;=</span><span class="number">0</span><span class="keyword">,</span>
       <span class="symbol">dat</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span>
       <span class="symbol">sum</span><span class="keyword">)</span>
</div><div class="output">##    0    1 
## 7938 2617 
</div><div class="source">
<span class="comment"># Number of citations vs Data availability</span>
<span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">dat</span><span class="keyword">$</span><span class="symbol">nCitedBy</span><span class="keyword">,</span>
       <span class="symbol">dat</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span>
       <span class="symbol">sum</span><span class="keyword">)</span>
</div><div class="output">##      0      1 
## 250620  81892 
</div><div class="source">
<span class="comment"># Number of citations vs Data availability</span>
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dat</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span> <span class="symbol">summary</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## $`0`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.6    35.0  2560.0 
## 
## $`1`
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.0    16.0    31.3    34.0  2640.0 
## 
</div><div class="source">
<span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dat</span><span class="keyword">$</span><span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">)</span>
</div><div class="output">## 
##    0    1 
## 7938 2617 
</div><div class="source"><span class="functioncall">boxplot</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">+</span><span class="number">1</span> <span class="keyword">~</span> <span class="symbol">dataset.in.geo.or.ae.int</span><span class="keyword">,</span>
        <span class="argument">data</span> <span class="argument">=</span> <span class="symbol">dat</span><span class="keyword">,</span>
        <span class="argument">boxwex</span> <span class="argument">=</span> <span class="number">0.5</span><span class="keyword">,</span>
        <span class="argument">names</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="string">"Data Not Shared"</span><span class="keyword">,</span> <span class="string">"Data Shared"</span><span class="keyword">)</span><span class="keyword">,</span>
        <span class="argument">ylab</span> <span class="argument">=</span> <span class="string">"Number of Citations"</span><span class="keyword">,</span> <span class="argument">outline</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">,</span> <span class="argument">notch</span><span class="argument">=</span><span class="symbol">F</span><span class="keyword">,</span> <span class="argument">log</span><span class="argument">=</span><span class="string">"y"</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/vfiwc.png" class="plot" />
</pre>

    
<pre class="knitr"><div class="source">
<span class="comment">#dat = dfCitationsAttributes</span>
<span class="symbol">myhetcorr</span> <span class="assignement">=</span> <span class="functioncall">hetcor.modified</span><span class="keyword">(</span><span class="symbol">dat</span><span class="keyword">,</span> <span class="argument">use</span><span class="argument">=</span><span class="string">"pairwise.complete.obs"</span><span class="keyword">,</span> <span class="argument">std.err</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">,</span> <span class="argument">pd</span><span class="argument">=</span><span class="number">FALSE</span><span class="keyword">)</span>
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
</div><img src="http://i.imgur.com/la0Ip.png" class="plot" />
<div class="error">## Error: figure margins too large
</div></pre>

    
<pre class="knitr"><div class="source">

<span class="symbol">dat.subset</span> <span class="assignement">=</span> <span class="symbol">dfCitationsAttributes</span>
<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="symbol">pubmed.year.published</span><span class="keyword">,</span> <span class="symbol">median</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## 2001 2002 2003 2004 2005 2006 2007 2008 2009 
## 76.0 54.0 40.0 30.0 24.0 18.0 14.0  9.5  5.0 
</div><div class="source">

<span class="symbol">num_authors_breaks</span> <span class="assignement">=</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">,</span> <span class="number">5</span><span class="keyword">,</span> <span class="number">10</span><span class="keyword">,</span> <span class="number">20</span><span class="keyword">,</span> <span class="number">40</span><span class="keyword">)</span>
<span class="symbol">citation_breaks</span> <span class="assignement">=</span> <span class="functioncall">c</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">,</span> <span class="number">10</span><span class="keyword">,</span> <span class="number">40</span><span class="keyword">,</span> <span class="number">100</span><span class="keyword">,</span> <span class="number">400</span><span class="keyword">,</span> <span class="number">1000</span><span class="keyword">)</span>

<span class="functioncall">with</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">tapply</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="functioncall">cut</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="symbol">num_authors_breaks</span><span class="keyword">)</span><span class="keyword">,</span> <span class="symbol">median</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">##   (1,5]  (5,10] (10,20] (20,40] 
##      16      38      53      NA 
</div><div class="source">
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">num_authors_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">num_authors_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/dGmOp.png" class="plot" />
<div class="source">

<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/U3WZw.png" class="plot" />
<div class="source">

<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/h2aGu.png" class="plot" />
<div class="source">

<span class="comment">##Distribution by journal</span>

<span class="symbol">most_common_journals</span> <span class="assignement">=</span> <span class="functioncall">names</span><span class="keyword">(</span><span class="functioncall">sort</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">$</span><span class="symbol">pubmed_journal</span><span class="keyword">)</span><span class="keyword">/</span><span class="functioncall">nrow</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">dec</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">:</span><span class="number">10</span><span class="keyword">]</span><span class="keyword">)</span>
<span class="symbol">dat_most_common_journals</span> <span class="assignement">=</span> <span class="functioncall">subset</span><span class="keyword">(</span><span class="symbol">dfCitationsAttributesRaw</span><span class="keyword">,</span> <span class="keyword">(</span><span class="symbol">pubmed_journal</span> <span class="keyword">%in%</span> <span class="symbol">most_common_journals</span><span class="keyword">)</span><span class="keyword">)</span>

<span class="functioncall">prop.table</span><span class="keyword">(</span><span class="functioncall">table</span><span class="keyword">(</span><span class="symbol">dat_most_common_journals</span><span class="keyword">$</span><span class="symbol">pubmed_journal</span><span class="keyword">,</span> <span class="symbol">dat_most_common_journals</span><span class="keyword">$</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">margin</span><span class="argument">=</span><span class="number">1</span><span class="keyword">)</span>
</div><div class="output">##                           
##                                 0      1
##   Blood                    0.6939 0.3061
##   BMC Genomics             0.5199 0.4801
##   Cancer Res               0.8171 0.1829
##   Clin Cancer Res          0.8588 0.1412
##   J Bacteriol              0.6696 0.3304
##   J Biol Chem              0.8237 0.1763
##   J Immunol                0.7264 0.2736
##   Physiol Genomics         0.3022 0.6978
##   PLoS One                 0.5579 0.4421
##   Proc Natl Acad Sci U S A 0.6546 0.3454
</div><div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="argument">data</span><span class="argument">=</span><span class="symbol">dat_most_common_journals</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">pubmed_date_in_pubmed</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">in_ae_or_geo</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_point</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span> <span class="keyword">+</span> <span class="functioncall">facet_wrap</span><span class="keyword">(</span><span class="keyword">~</span> <span class="symbol">pubmed_journal</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/tVtJA.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.core.clinical.journal</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/O0iJi.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.open.access</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/BQ0o1.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/FT567.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.humans</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/KYeG9.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">pubmed.is.cultured.cells</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/6kmKD.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">has.R.funding</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/tHiEO.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">country.usa</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/c8Pil.png" class="plot" />
<div class="source">
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">num.grants.via.nih.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/MwdQW.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.microarray.creations.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.microarray.creations.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/QoECK.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">first.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/0mnJT.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/vn7fy.png" class="plot" />
<div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">,</span> <span class="symbol">last.author.num.prev.pubs.tr</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_boxplot</span><span class="keyword">(</span><span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">group</span><span class="argument">=</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span>  <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span> <span class="keyword">+</span> <span class="functioncall">coord_flip</span><span class="keyword">(</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/OSuXL.png" class="plot" />
<div class="source">

<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/MhS2L.png" class="plot" />
<div class="source">
<span class="symbol">x_breaks</span> <span class="assignement">=</span> <span class="functioncall">quantile</span><span class="keyword">(</span><span class="symbol">dat.subset</span><span class="keyword">$</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="argument">na.rm</span><span class="argument">=</span><span class="symbol">T</span><span class="keyword">)</span>
<span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dat.subset</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_smooth</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">x_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">trans</span><span class="argument">=</span><span class="string">"log10"</span><span class="keyword">,</span> <span class="argument">breaks</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">,</span> <span class="argument">labels</span><span class="argument">=</span><span class="symbol">citation_breaks</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="symbol">cbgFillPalette</span> <span class="keyword">+</span> <span class="symbol">cbgColourPalette</span>
</div><img src="http://i.imgur.com/p7ZcY.png" class="plot" />
</pre>


#### Multivariate



##### All years

<pre class="knitr"><div class="source">
<span class="comment">###### ANALYSIS</span>

<span class="comment"># Some helper functions</span>
<span class="symbol">calcCI.exp</span><span class="assignement">=</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">res</span><span class="keyword">,</span> <span class="formalargs">param</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">coefs</span> <span class="assignement">=</span> <span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">res</span><span class="keyword">)</span><span class="keyword">$</span><span class="symbol">coeff</span>
  <span class="symbol">coeff</span> <span class="assignement">=</span> <span class="symbol">coefs</span><span class="keyword">[</span><span class="symbol">param</span><span class="keyword">,</span><span class="keyword">]</span>
  <span class="symbol">x</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>
  <span class="symbol">stderr</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">2</span><span class="keyword">]</span>
  <span class="symbol">p</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">4</span><span class="keyword">]</span>
  <span class="functioncall">return</span><span class="keyword">(</span><span class="functioncall">data.frame</span><span class="keyword">(</span><span class="argument">param</span> <span class="argument">=</span> <span class="symbol">param</span><span class="keyword">,</span>
              <span class="argument">est</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="functioncall">exp</span><span class="keyword">(</span><span class="symbol">x</span><span class="keyword">)</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">ciLow</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="functioncall">exp</span><span class="keyword">(</span><span class="symbol">x</span> <span class="keyword">-</span> <span class="number">1.96</span><span class="keyword">*</span><span class="symbol">stderr</span><span class="keyword">)</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">ciHigh</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="functioncall">exp</span><span class="keyword">(</span><span class="symbol">x</span> <span class="keyword">+</span> <span class="number">1.96</span><span class="keyword">*</span><span class="symbol">stderr</span><span class="keyword">)</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">p</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">p</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
<span class="keyword">}</span>

<span class="symbol">calcCI.noexp</span><span class="assignement">=</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">res</span><span class="keyword">,</span> <span class="formalargs">param</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">coefs</span> <span class="assignement">=</span> <span class="functioncall">summary</span><span class="keyword">(</span><span class="symbol">res</span><span class="keyword">)</span><span class="keyword">$</span><span class="symbol">coeff</span>
  <span class="symbol">coeff</span> <span class="assignement">=</span> <span class="symbol">coefs</span><span class="keyword">[</span><span class="symbol">param</span><span class="keyword">,</span><span class="keyword">]</span>
  <span class="symbol">x</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">1</span><span class="keyword">]</span>
  <span class="symbol">stderr</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">2</span><span class="keyword">]</span>
  <span class="symbol">p</span> <span class="assignement">=</span> <span class="symbol">coeff</span><span class="keyword">[</span><span class="number">4</span><span class="keyword">]</span>
  <span class="functioncall">return</span><span class="keyword">(</span><span class="functioncall">data.frame</span><span class="keyword">(</span><span class="argument">param</span> <span class="argument">=</span> <span class="symbol">param</span><span class="keyword">,</span>
              <span class="argument">est</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">x</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">ciLow</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">x</span> <span class="keyword">-</span> <span class="number">1.96</span><span class="keyword">*</span><span class="symbol">stderr</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">ciHigh</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">x</span> <span class="keyword">+</span> <span class="number">1.96</span><span class="keyword">*</span><span class="symbol">stderr</span><span class="keyword">,</span> <span class="number">2</span><span class="keyword">)</span><span class="keyword">,</span>
              <span class="argument">p</span> <span class="argument">=</span> <span class="functioncall">round</span><span class="keyword">(</span><span class="symbol">p</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span><span class="keyword">)</span><span class="keyword">)</span>
<span class="keyword">}</span>



<span class="comment">#### Looks like this is the analysis</span>
<span class="symbol">fit</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
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
          <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.animals</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.plants</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.core.clinical.journal</span><span class="keyword">)</span> <span class="keyword">+</span>
          <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">dataset.in.geo.or.ae</span><span class="keyword">)</span>
           <span class="keyword">,</span> <span class="symbol">dfCitationsAttributes</span><span class="keyword">)</span>


<span class="functioncall">gfm_table</span><span class="keyword">(</span><span class="functioncall">anova</span><span class="keyword">(</span><span class="symbol">fit</span><span class="keyword">)</span><span class="keyword">)</span>
</div><div class="output">## |                                              | Df      | Sum Sq  | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|---------|---------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00    | 165.11  | 82.56   | 154.71  | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00    | 1833.50 | 916.75  | 1717.97 | 0.00   |
## | rcs(first.author.num.prev.pubs.tr, 3)        | 2.00    | 6.08    | 3.04    | 5.70    | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00    | 186.36  | 93.18   | 174.61  | 0.00   |
## | rcs(first.author.year.first.pub.ago.tr, 3)   | 2.00    | 3.22    | 1.61    | 3.02    | 0.05   |
## | rcs(last.author.num.prev.pubs.tr, 3)         | 2.00    | 7.51    | 3.76    | 7.04    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00    | 122.47  | 61.24   | 114.76  | 0.00   |
## | rcs(last.author.year.first.pub.ago.tr, 3)    | 2.00    | 3.29    | 1.64    | 3.08    | 0.05   |
## | country.usa                                  | 1.00    | 4.13    | 4.13    | 7.74    | 0.01   |
## | pubmed.is.open.access                        | 1.00    | 4.45    | 4.45    | 8.34    | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00    | 10.68   | 5.34    | 10.00   | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00    | 41.15   | 20.57   | 38.55   | 0.00   |
## | rcs(journal.cited.halflife, 3)               | 2.00    | 4.25    | 2.13    | 3.98    | 0.02   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00    | 354.74  | 177.37  | 332.39  | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00    | 13.70   | 13.70   | 25.68   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00    | 13.38   | 13.38   | 25.08   | 0.00   |
## | factor(pubmed.is.plants)                     | 1.00    | 15.19   | 15.19   | 28.46   | 0.00   |
## | factor(pubmed.is.core.clinical.journal)      | 1.00    | 4.48    | 4.48    | 8.39    | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00    | 22.79   | 22.79   | 42.71   | 0.00   |
## | Residuals                                    | 4341.00 | 2316.46 | 0.53    |         |        |
</div><div class="source">
<span class="symbol">fit</span>
</div><div class="output">## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(num.authors.tr, 3) + rcs(pubmed.date.in.pubmed, 
##     3) + rcs(first.author.num.prev.pubs.tr, 3) + rcs(first.author.num.prev.pmc.cites.tr, 
##     3) + rcs(first.author.year.first.pub.ago.tr, 3) + rcs(last.author.num.prev.pubs.tr, 
##     3) + rcs(last.author.num.prev.pmc.cites.tr, 3) + rcs(last.author.year.first.pub.ago.tr, 
##     3) + country.usa + pubmed.is.open.access + rcs(institution.mean.norm.citation.score, 
##     3) + rcs(journal.num.articles.2008.tr, 3) + rcs(journal.cited.halflife, 
##     3) + rcs(journal.impact.factor.tr, 3) + factor(pubmed.is.cancer) + 
##     factor(pubmed.is.animals) + factor(pubmed.is.plants) + factor(pubmed.is.core.clinical.journal) + 
##     factor(dataset.in.geo.or.ae), data = dfCitationsAttributes)
## 
## Coefficients:
##                                                                       (Intercept)  
##                                                                         21.615597  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.231614  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                         -0.004523  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.000572  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                         -0.000229  
##                rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr  
##                                                                         -0.025957  
##               rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr'  
##                                                                          0.002993  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.040807  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                         -0.036931  
##      rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr  
##                                                                         -0.064497  
##     rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr'  
##                                                                          0.027324  
##                  rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr  
##                                                                         -0.025988  
##                 rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr'  
##                                                                          0.024304  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                          0.008248  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                         -0.004732  
##        rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr  
##                                                                          0.033737  
##       rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr'  
##                                                                         -0.055195  
##                                                                     country.usa.L  
##                                                                          0.034038  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.071783  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.085859  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.070439  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.002509  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.005606  
##                              rcs(journal.cited.halflife, 3)journal.cited.halflife  
##                                                                          0.003019  
##                             rcs(journal.cited.halflife, 3)journal.cited.halflife'  
##                                                                          0.009822  
##                          rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr  
##                                                                          0.923689  
##                         rcs(journal.impact.factor.tr, 3)journal.impact.factor.tr'  
##                                                                         -0.489480  
##                                                        factor(pubmed.is.cancer).L  
##                                                                         -0.060094  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.056189  
##                                                        factor(pubmed.is.plants).L  
##                                                                          0.168610  
##                                         factor(pubmed.is.core.clinical.journal).L  
##                                                                         -0.082508  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.122251  
## 
</div><div class="source"><span class="symbol">citation.boost.coefs</span> <span class="assignement">=</span> <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">fit</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
<span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">citation.boost.coefs</span><span class="keyword">)</span>
</div><div class="output">##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.13  1.09   1.17 0
</div></pre>


Estimate of citation boost is 
<code class="knitr inline">13</code>%
with 95% confidence intervals [<code class="knitr inline">9</code>%
, <code class="knitr inline">17</code>% ]
(p=<code class="knitr inline">0.00</code>)


##### now with journal covariates

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
<span class="symbol">fit_w_journal</span>
</div><div class="output">## 
## Call:
## lm(formula = nCitedBy.log ~ rcs(num.authors.tr, 3) + factor(journal.impact.factor.tr) + 
##     rcs(pubmed.date.in.pubmed, 3) + rcs(first.author.num.prev.pubs.tr, 
##     3) + rcs(first.author.num.prev.pmc.cites.tr, 3) + rcs(first.author.year.first.pub.ago.tr, 
##     3) + rcs(last.author.num.prev.pubs.tr, 3) + rcs(last.author.num.prev.pmc.cites.tr, 
##     3) + rcs(last.author.year.first.pub.ago.tr, 3) + country.usa + 
##     pubmed.is.open.access + rcs(institution.mean.norm.citation.score, 
##     3) + rcs(journal.num.articles.2008.tr, 3) + rcs(journal.cited.halflife, 
##     3) + factor(pubmed.is.cancer) + factor(pubmed.is.animals) + 
##     factor(pubmed.is.plants) + factor(pubmed.is.core.clinical.journal) + 
##     factor(dataset.in.geo.or.ae), data = dfCitationsAttributes)
## 
## Coefficients:
##                                                                       (Intercept)  
##                                                                         23.288219  
##                                              rcs(num.authors.tr, 3)num.authors.tr  
##                                                                          0.214018  
##                                             rcs(num.authors.tr, 3)num.authors.tr'  
##                                                                          0.008942  
##                                   factor(journal.impact.factor.tr)1.3228756555323  
##                                                                         -1.534113  
##                                  factor(journal.impact.factor.tr)1.41067359796659  
##                                                                         -1.640624  
##                                  factor(journal.impact.factor.tr)1.43352711868315  
##                                                                         -2.085640  
##                                  factor(journal.impact.factor.tr)1.44429913799047  
##                                                                         -0.350846  
##                                  factor(journal.impact.factor.tr)1.47783625615289  
##                                                                         -1.307518  
##                                  factor(journal.impact.factor.tr)1.49197855212466  
##                                                                         -1.480246  
##                                  factor(journal.impact.factor.tr)1.50565600320923  
##                                                                         -3.467558  
##                                  factor(journal.impact.factor.tr)1.51095995976068  
##                                                                         -2.565496  
##                                  factor(journal.impact.factor.tr)1.53525242224202  
##                                                                         -1.188882  
##                                  factor(journal.impact.factor.tr)1.54434452114805  
##                                                                         -0.665285  
##                                  factor(journal.impact.factor.tr)1.54596248337403  
##                                                                         -1.542946  
##                                  factor(journal.impact.factor.tr)1.56652481627327  
##                                                                         -1.356960  
##                                  factor(journal.impact.factor.tr)1.56716304193278  
##                                                                         -1.383712  
##                                  factor(journal.impact.factor.tr)1.56748205731358  
##                                                                         -1.347094  
##                                  factor(journal.impact.factor.tr)1.57384878562078  
##                                                                         -2.065764  
##                                  factor(journal.impact.factor.tr)1.57543644746464  
##                                                                         -1.550949  
##                                  factor(journal.impact.factor.tr)1.57702251093635  
##                                                                         -1.114287  
##                                  factor(journal.impact.factor.tr)1.60717142831746  
##                                                                         -0.050686  
##                                  factor(journal.impact.factor.tr)1.61833247511134  
##                                                                         -2.470791  
##                                  factor(journal.impact.factor.tr)1.62542302186231  
##                                                                         -1.737251  
##                                  factor(journal.impact.factor.tr)1.62696035600134  
##                                                                         -2.005654  
##                                  factor(journal.impact.factor.tr)1.63340135912763  
##                                                                         -0.401778  
##                                   factor(journal.impact.factor.tr)1.6346253393362  
##                                                                         -2.605724  
##                                  factor(journal.impact.factor.tr)1.63584840373428  
##                                                                         -1.518722  
##                                   factor(journal.impact.factor.tr)1.6583123951777  
##                                                                         -1.288295  
##                                  factor(journal.impact.factor.tr)1.65861387911714  
##                                                                         -0.467246  
##                                  factor(journal.impact.factor.tr)1.65891530826622  
##                                                                         -1.178896  
##                                   factor(journal.impact.factor.tr)1.6607227342335  
##                                                                         -0.751890  
##                                  factor(journal.impact.factor.tr)1.66252819524963  
##                                                                         -0.228433  
##                                  factor(journal.impact.factor.tr)1.66583312489577  
##                                                                          0.275894  
##                                  factor(journal.impact.factor.tr)1.66943104080402  
##                                                                         -1.475641  
##                                  factor(journal.impact.factor.tr)1.69646691685986  
##                                                                          0.027474  
##                                  factor(journal.impact.factor.tr)1.69764542823288  
##                                                                         -0.578118  
##                                               factor(journal.impact.factor.tr)1.7  
##                                                                         -0.919945  
##                                  factor(journal.impact.factor.tr)1.70088212407562  
##                                                                         -0.738843  
##                                  factor(journal.impact.factor.tr)1.70499266860594  
##                                                                         -0.649986  
##                                  factor(journal.impact.factor.tr)1.70997075998392  
##                                                                         -1.189106  
##                                  factor(journal.impact.factor.tr)1.71172427686237  
##                                                                         -1.375039  
##                                  factor(journal.impact.factor.tr)1.71435118922582  
##                                                                         -1.839031  
##                                  factor(journal.impact.factor.tr)1.71639156371732  
##                                                                         -1.027252  
##                                  factor(journal.impact.factor.tr)1.71784749032037  
##                                                                         -0.925113  
##                                    factor(journal.impact.factor.tr)1.719302184027  
##                                                                         -1.684139  
##                                   factor(journal.impact.factor.tr)1.7239489551608  
##                                                                         -0.697754  
##                                  factor(journal.impact.factor.tr)1.72481883106603  
##                                                                         -0.034216  
##                                  factor(journal.impact.factor.tr)1.72626765016321  
##                                                                         -0.258532  
##                                  factor(journal.impact.factor.tr)1.72742583053513  
##                                                                          0.174976  
##                                   factor(journal.impact.factor.tr)1.7303178898688  
##                                                                         -1.389604  
##                                  factor(journal.impact.factor.tr)1.73205080756888  
##                                                                         -1.765158  
##                                  factor(journal.impact.factor.tr)1.73579952759528  
##                                                                         -1.637300  
##                                  factor(journal.impact.factor.tr)1.73781471969828  
##                                                                         -0.603592  
##                                  factor(journal.impact.factor.tr)1.73810241355336  
##                                                                         -0.718566  
##                                  factor(journal.impact.factor.tr)1.73867765845196  
##                                                                         -1.114031  
##                                  factor(journal.impact.factor.tr)1.74126390877431  
##                                                                          0.976278  
##                                  factor(journal.impact.factor.tr)1.74183810958424  
##                                                                         -0.243847  
##                                  factor(journal.impact.factor.tr)1.74327278416202  
##                                                                          0.191011  
##                                  factor(journal.impact.factor.tr)1.74384632350445  
##                                                                         -1.273772  
##                                  factor(journal.impact.factor.tr)1.74671119536116  
##                                                                          0.049951  
##                                  factor(journal.impact.factor.tr)1.74957137608044  
##                                                                         -0.396553  
##                                  factor(journal.impact.factor.tr)1.74985713702576  
##                                                                         -1.951960  
##                                   factor(journal.impact.factor.tr)1.7541379649275  
##                                                                         -1.532389  
##                                  factor(journal.impact.factor.tr)1.75527775579821  
##                                                                         -2.606299  
##                                  factor(journal.impact.factor.tr)1.75840837122666  
##                                                                         -0.769836  
##                                   factor(journal.impact.factor.tr)1.7606816861659  
##                                                                         -1.522805  
##                                    factor(journal.impact.factor.tr)1.764086165696  
##                                                                         -1.173187  
##                                  factor(journal.impact.factor.tr)1.76720117700278  
##                                                                          1.599217  
##                                  factor(journal.impact.factor.tr)1.77087548969429  
##                                                                         -1.190740  
##                                  factor(journal.impact.factor.tr)1.77623196683316  
##                                                                          0.747311  
##                                  factor(journal.impact.factor.tr)1.78605710994918  
##                                                                         -0.697619  
##                                  factor(journal.impact.factor.tr)1.78885438199983  
##                                                                         -3.146757  
##                                  factor(journal.impact.factor.tr)1.78941331167509  
##                                                                         -1.091076  
##                                  factor(journal.impact.factor.tr)1.79276323032351  
##                                                                         -1.206501  
##                                  factor(journal.impact.factor.tr)1.79359973238178  
##                                                                         -1.172931  
##                                  factor(journal.impact.factor.tr)1.79916647367607  
##                                                                          0.172515  
##                                  factor(journal.impact.factor.tr)1.79944435868409  
##                                                                         -1.208354  
##                                  factor(journal.impact.factor.tr)1.80111076838711  
##                                                                         -0.424434  
##                                  factor(journal.impact.factor.tr)1.80554700852678  
##                                                                         -0.895146  
##                                  factor(journal.impact.factor.tr)1.81135308540328  
##                                                                         -0.244144  
##                                  factor(journal.impact.factor.tr)1.81356003484858  
##                                                                         -0.888731  
##                                  factor(journal.impact.factor.tr)1.82181228451232  
##                                                                         -0.905287  
##                                  factor(journal.impact.factor.tr)1.82236110581849  
##                                                                         -1.176347  
##                                  factor(journal.impact.factor.tr)1.82290976189168  
##                                                                         -0.274434  
##                                  factor(journal.impact.factor.tr)1.82565056897534  
##                                                                         -0.917206  
##                                  factor(journal.impact.factor.tr)1.82811378201686  
##                                                                         -0.635462  
##                                  factor(journal.impact.factor.tr)1.83030052177231  
##                                                                         -1.172219  
##                                  factor(journal.impact.factor.tr)1.83439363278441  
##                                                                         -1.286540  
##                                  factor(journal.impact.factor.tr)1.83575597506858  
##                                                                         -1.109081  
##                                  factor(journal.impact.factor.tr)1.83738945245694  
##                                                                         -1.542699  
##                                  factor(journal.impact.factor.tr)1.83929334256393  
##                                                                         -0.706972  
##                                   factor(journal.impact.factor.tr)1.8411952639522  
##                                                                         -1.780884  
##                                  factor(journal.impact.factor.tr)1.84634774622767  
##                                                                         -1.456730  
##                                  factor(journal.impact.factor.tr)1.85175592344132  
##                                                                         -1.340034  
##                                  factor(journal.impact.factor.tr)1.85229587269421  
##                                                                         -0.521767  
##                                  factor(journal.impact.factor.tr)1.85391477689779  
##                                                                         -0.914950  
##                                  factor(journal.impact.factor.tr)1.85714835164022  
##                                                                         -0.514948  
##                                  factor(journal.impact.factor.tr)1.85903200617956  
##                                                                         -0.149795  
##                                  factor(journal.impact.factor.tr)1.86010752377383  
##                                                                         -0.834636  
##                                  factor(journal.impact.factor.tr)1.86118241986109  
##                                                                         -0.669775  
##                                  factor(journal.impact.factor.tr)1.86359866924185  
##                                                                         -0.889745  
##                                  factor(journal.impact.factor.tr)1.86708328684073  
##                                                                         -0.093929  
##                                  factor(journal.impact.factor.tr)1.86922443810261  
##                                                                         -1.699510  
##                                  factor(journal.impact.factor.tr)1.87456661658102  
##                                                                         -0.852527  
##                                  factor(journal.impact.factor.tr)1.87989361401118  
##                                                                         -0.449740  
##                                  factor(journal.impact.factor.tr)1.88042548376691  
##                                                                          0.299378  
##                                   factor(journal.impact.factor.tr)1.8806913622389  
##                                                                         -0.678402  
##                                  factor(journal.impact.factor.tr)1.88255146012001  
##                                                                         -0.126294  
##                                  factor(journal.impact.factor.tr)1.88759105740624  
##                                                                         -1.478390  
##                                  factor(journal.impact.factor.tr)1.88917971617313  
##                                                                         -0.864146  
##                                  factor(journal.impact.factor.tr)1.89129585205488  
##                                                                         -0.342326  
##                                   factor(journal.impact.factor.tr)1.8915602025841  
##                                                                         -0.180479  
##                                   factor(journal.impact.factor.tr)1.8918245161748  
##                                                                         -0.668050  
##                                   factor(journal.impact.factor.tr)1.8928814014618  
##                                                                         -0.615526  
##                                  factor(journal.impact.factor.tr)1.90315527480025  
##                                                                         -0.377649  
##                                  factor(journal.impact.factor.tr)1.90420587122296  
##                                                                         -0.281540  
##                                  factor(journal.impact.factor.tr)1.90630532706595  
##                                                                         -1.215351  
##                                  factor(journal.impact.factor.tr)1.90997382181013  
##                                                                         -5.596598  
##                                  factor(journal.impact.factor.tr)1.91049731745428  
##                                                                         -0.746129  
##                                  factor(journal.impact.factor.tr)1.91337398330802  
##                                                                         -0.979752  
##                                  factor(journal.impact.factor.tr)1.92067696398952  
##                                                                         -1.226319  
##                                  factor(journal.impact.factor.tr)1.92924855837707  
##                                                                         -0.678921  
##                                  factor(journal.impact.factor.tr)1.93313217344288  
##                                                                         -0.853275  
##                                  factor(journal.impact.factor.tr)1.93390796058137  
##                                                                         -0.467408  
##                                  factor(journal.impact.factor.tr)1.93597520645281  
##                                                                         -0.728551  
##                                  factor(journal.impact.factor.tr)1.93726611491555  
##                                                                         -0.318224  
##                                  factor(journal.impact.factor.tr)1.93778223750761  
##                                                                          0.287907  
##                                  factor(journal.impact.factor.tr)1.93958758502935  
##                                                                         -0.415177  
##                                  factor(journal.impact.factor.tr)1.94293592277254  
##                                                                         -1.009340  
##                                  factor(journal.impact.factor.tr)1.94602158261413  
##                                                                         -2.484658  
##                                  factor(journal.impact.factor.tr)1.94704904920241  
##                                                                         -0.492278  
##                                  factor(journal.impact.factor.tr)1.94756257922563  
##                                                                         -2.617698  
##                                  factor(journal.impact.factor.tr)1.94807597387782  
##                                                                         -0.630465  
##                                  factor(journal.impact.factor.tr)1.94961534667739  
##                                                                         -0.671174  
##                                  factor(journal.impact.factor.tr)1.95192212959431  
##                                                                         -0.933864  
##                                  factor(journal.impact.factor.tr)1.95524934471284  
##                                                                         -0.159580  
##                                  factor(journal.impact.factor.tr)1.95627196473292  
##                                                                         -0.710473  
##                                  factor(journal.impact.factor.tr)1.95780489324141  
##                                                                         -0.462154  
##                                  factor(journal.impact.factor.tr)1.95857090757521  
##                                                                         -0.511966  
##                                  factor(journal.impact.factor.tr)1.95908141739949  
##                                                                         -0.956558  
##                                  factor(journal.impact.factor.tr)1.95984693279858  
##                                                                         -0.554285  
##                                  factor(journal.impact.factor.tr)1.96214168703486  
##                                                                         -0.293348  
##                                   factor(journal.impact.factor.tr)1.9641792178923  
##                                                                         -1.031882  
##                                  factor(journal.impact.factor.tr)1.96443376065471  
##                                                                         -0.387107  
##                                  factor(journal.impact.factor.tr)1.96748570515773  
##                                                                         -0.008666  
##                                  factor(journal.impact.factor.tr)1.96900990347941  
##                                                                         -0.264198  
##                                  factor(journal.impact.factor.tr)1.97610728453695  
##                                                                         -0.405025  
##                                  factor(journal.impact.factor.tr)1.97914122790669  
##                                                                         -0.425880  
##                                  factor(journal.impact.factor.tr)1.97964643307839  
##                                                                         -0.786192  
##                                  factor(journal.impact.factor.tr)1.97989898732233  
##                                                                         -0.614652  
##                                    factor(journal.impact.factor.tr)1.981918262694  
##                                                                         -0.832059  
##                                  factor(journal.impact.factor.tr)1.98292712927127  
##                                                                         -0.199678  
##                                  factor(journal.impact.factor.tr)1.98393548282196  
##                                                                          0.258363  
##                                  factor(journal.impact.factor.tr)1.98645412733343  
##                                                                          0.438584  
##                                  factor(journal.impact.factor.tr)1.98771225281729  
##                                                                          0.010745  
##                                  factor(journal.impact.factor.tr)1.98922095303664  
##                                                                         -1.250709  
##                                  factor(journal.impact.factor.tr)1.99248588451713  
##                                                                         -1.303068  
##                                  factor(journal.impact.factor.tr)1.99323857076869  
##                                                                         -1.320095  
##                                  factor(journal.impact.factor.tr)1.99524434593861  
##                                                                          0.278041  
##                                                 factor(journal.impact.factor.tr)2  
##                                                                         -0.433018  
##                                  factor(journal.impact.factor.tr)2.00124960961895  
##                                                                         -0.843461  
##                                  factor(journal.impact.factor.tr)2.00449494885869  
##                                                                         -0.933149  
##                                  factor(journal.impact.factor.tr)2.00922870773837  
##                                                                         -0.794155  
##                                  factor(journal.impact.factor.tr)2.00947754403974  
##                                                                         -0.416526  
##                                  factor(journal.impact.factor.tr)2.01022386813011  
##                                                                         -0.809821  
##                                  factor(journal.impact.factor.tr)2.01519229851645  
##                                                                         -1.122203  
##                                  factor(journal.impact.factor.tr)2.01668044072431  
##                                                                         -2.810714  
##                                  factor(journal.impact.factor.tr)2.01717624415915  
##                                                                         -0.800862  
##                                  factor(journal.impact.factor.tr)2.01816748561659  
##                                                                         -0.592644  
##                                  factor(journal.impact.factor.tr)2.01866292381863  
##                                                                         -0.179357  
##                                  factor(journal.impact.factor.tr)2.01965343561711  
##                                                                          0.030171  
##                                  factor(journal.impact.factor.tr)2.02163300329214  
##                                                                         -0.936557  
##                                  factor(journal.impact.factor.tr)2.02188031297602  
##                                                                         -0.247944  
##                                  factor(journal.impact.factor.tr)2.02286924935845  
##                                                                         -0.405264  
##                                   factor(journal.impact.factor.tr)2.0339616515559  
##                                                                         -1.223652  
##                                  factor(journal.impact.factor.tr)2.03519040878243  
##                                                                         -0.215270  
##                                  factor(journal.impact.factor.tr)2.03887223729198  
##                                                                         -0.594824  
##                                  factor(journal.impact.factor.tr)2.03936264553414  
##                                                                         -1.069488  
##                                  factor(journal.impact.factor.tr)2.03960780543711  
##                                                                         -0.868570  
##                                  factor(journal.impact.factor.tr)2.03985293587553  
##                                                                         -0.017424  
##                                  factor(journal.impact.factor.tr)2.04230262204209  
##                                                                         -0.291619  
##                                  factor(journal.impact.factor.tr)2.04450483002609  
##                                                                         -1.296844  
##                                  factor(journal.impact.factor.tr)2.04474937339518  
##                                                                         -0.881652  
##                                  factor(journal.impact.factor.tr)2.04890214505232  
##                                                                         -1.026753  
##                                  factor(journal.impact.factor.tr)2.05012194759239  
##                                                                         -1.190891  
##                                  factor(journal.impact.factor.tr)2.05085348087083  
##                                                                         -0.223867  
##                                  factor(journal.impact.factor.tr)2.05548047910945  
##                                                                         -1.144198  
##                                  factor(journal.impact.factor.tr)2.05621010599598  
##                                                                         -0.403751  
##                                  factor(journal.impact.factor.tr)2.05961161387287  
##                                                                         -0.397986  
##                                  factor(journal.impact.factor.tr)2.06131026291531  
##                                                                         -0.564088  
##                                  factor(journal.impact.factor.tr)2.06494551986245  
##                                                                         -0.933578  
##                                  factor(journal.impact.factor.tr)2.06688170924221  
##                                                                         -0.863780  
##                                  factor(journal.impact.factor.tr)2.06712360539954  
##                                                                         -0.140122  
##                                  factor(journal.impact.factor.tr)2.07050718424255  
##                                                                         -0.313798  
##                                  factor(journal.impact.factor.tr)2.07099010137663  
##                                                                         -1.140968  
##                                   factor(journal.impact.factor.tr)2.0714729059295  
##                                                                         -1.783936  
##                                  factor(journal.impact.factor.tr)2.07316183642281  
##                                                                         -1.536932  
##                                  factor(journal.impact.factor.tr)2.07894203863407  
##                                                                         -0.382921  
##                                  factor(journal.impact.factor.tr)2.08278659492517  
##                                                                         -1.064407  
##                                  factor(journal.impact.factor.tr)2.08422647521808  
##                                                                         -0.228480  
##                                  factor(journal.impact.factor.tr)2.08901890848312  
##                                                                         -0.386687  
##                                  factor(journal.impact.factor.tr)2.09356155868415  
##                                                                         -0.601355  
##                                  factor(journal.impact.factor.tr)2.09809437347322  
##                                                                          0.454162  
##                                  factor(journal.impact.factor.tr)2.09880918618154  
##                                                                         -0.104218  
##                                  factor(journal.impact.factor.tr)2.10023808174216  
##                                                                         -0.534229  
##                                  factor(journal.impact.factor.tr)2.10618137870412  
##                                                                         -0.678935  
##                                  factor(journal.impact.factor.tr)2.10997630318447  
##                                                                         -1.326051  
##                                  factor(journal.impact.factor.tr)2.11021325936503  
##                                                                          0.125801  
##                                  factor(journal.impact.factor.tr)2.11400094607358  
##                                                                          0.216562  
##                                  factor(journal.impact.factor.tr)2.11541958013062  
##                                                                         -1.271965  
##                                  factor(journal.impact.factor.tr)2.11896201004171  
##                                                                          0.263554  
##                                  factor(journal.impact.factor.tr)2.11919796149392  
##                                                                         -0.619765  
##                                  factor(journal.impact.factor.tr)2.12226294318117  
##                                                                         -1.396419  
##                                  factor(journal.impact.factor.tr)2.12532350478698  
##                                                                          0.022210  
##                                   factor(journal.impact.factor.tr)2.1304929007157  
##                                                                         -0.725654  
##                                  factor(journal.impact.factor.tr)2.13096222397301  
##                                                                         -0.042630  
##                                  factor(journal.impact.factor.tr)2.13119684684451  
##                                                                         -0.538802  
##                                   factor(journal.impact.factor.tr)2.1342445970413  
##                                                                          0.091881  
##                                  factor(journal.impact.factor.tr)2.13447885911292  
##                                                                         -1.288435  
##                                  factor(journal.impact.factor.tr)2.14056067421599  
##                                                                         -1.315327  
##                                  factor(journal.impact.factor.tr)2.14172827408147  
##                                                                          0.015613  
##                                  factor(journal.impact.factor.tr)2.14615936034582  
##                                                                         -0.519970  
##                                  factor(journal.impact.factor.tr)2.14732391594748  
##                                                                         -0.848877  
##                                  factor(journal.impact.factor.tr)2.14755675128738  
##                                                                         -0.800808  
##                                  factor(journal.impact.factor.tr)2.14778956138631  
##                                                                         -1.082387  
##                                  factor(journal.impact.factor.tr)2.15313724597388  
##                                                                         -0.747690  
##                                  factor(journal.impact.factor.tr)2.15476216785055  
##                                                                         -0.502848  
##                                   factor(journal.impact.factor.tr)2.1559220765139  
##                                                                         -1.493090  
##                                  factor(journal.impact.factor.tr)2.15824002372303  
##                                                                          0.542744  
##                                  factor(journal.impact.factor.tr)2.16471707158234  
##                                                                         -0.335823  
##                                  factor(journal.impact.factor.tr)2.16910119634839  
##                                                                          0.213739  
##                                  factor(journal.impact.factor.tr)2.17990825495019  
##                                                                         -0.388061  
##                                  factor(journal.impact.factor.tr)2.18105479069188  
##                                                                         -0.387134  
##                                  factor(journal.impact.factor.tr)2.18471966164998  
##                                                                         -0.070258  
##                                  factor(journal.impact.factor.tr)2.18654979362465  
##                                                                         -0.614440  
##                                  factor(journal.impact.factor.tr)2.18883530673278  
##                                                                         -1.152115  
##                                  factor(journal.impact.factor.tr)2.19111843586786  
##                                                                         -1.342274  
##                                   factor(journal.impact.factor.tr)2.1936271333114  
##                                                                         -0.601439  
##                                  factor(journal.impact.factor.tr)2.19772609758359  
##                                                                         -0.264524  
##                                   factor(journal.impact.factor.tr)2.1988633427296  
##                                                                         -0.572433  
##                                               factor(journal.impact.factor.tr)2.2  
##                                                                         -0.758625  
##                                  factor(journal.impact.factor.tr)2.20340645365307  
##                                                                         -0.285881  
##                                  factor(journal.impact.factor.tr)2.20771374956084  
##                                                                         -2.087229  
##                                   factor(journal.impact.factor.tr)2.2113344387496  
##                                                                         -0.509962  
##                                  factor(journal.impact.factor.tr)2.21314256205966  
##                                                                         -0.541541  
##                                  factor(journal.impact.factor.tr)2.21697992773954  
##                                                                         -1.271842  
##                                  factor(journal.impact.factor.tr)2.21900878772483  
##                                                                         -0.811667  
##                                  factor(journal.impact.factor.tr)2.21945939363621  
##                                                                         -0.304795  
##                                  factor(journal.impact.factor.tr)2.22126090318089  
##                                                                         -1.187220  
##                                  factor(journal.impact.factor.tr)2.22373559579371  
##                                                                         -1.472986  
##                                  factor(journal.impact.factor.tr)2.22441003414389  
##                                                                         -0.026578  
##                                  factor(journal.impact.factor.tr)2.22957395033222  
##                                                                         -0.386746  
##                                  factor(journal.impact.factor.tr)2.23024662313386  
##                                                                         -0.962957  
##                                  factor(journal.impact.factor.tr)2.23315919719128  
##                                                                         -0.443525  
##                                  factor(journal.impact.factor.tr)2.23629157311832  
##                                                                         -0.436262  
##                                  factor(journal.impact.factor.tr)2.23651514638287  
##                                                                          0.052341  
##                                  factor(journal.impact.factor.tr)2.23740921603537  
##                                                                         -1.063717  
##                                   factor(journal.impact.factor.tr)2.2414281161795  
##                                                                         -1.093036  
##                                  factor(journal.impact.factor.tr)2.24276614920058  
##                                                                         -0.346299  
##                                   factor(journal.impact.factor.tr)2.2454398232863  
##                                                                         -0.074763  
##                                  factor(journal.impact.factor.tr)2.24722050542442  
##                                                                          0.214647  
##                                  factor(journal.impact.factor.tr)2.25432916851111  
##                                                                         -0.554254  
##                                  factor(journal.impact.factor.tr)2.26274169979695  
##                                                                         -0.682338  
##                                  factor(journal.impact.factor.tr)2.26406713681375  
##                                                                         -0.809346  
##                                  factor(journal.impact.factor.tr)2.26539179834306  
##                                                                         -1.365823  
##                                  factor(journal.impact.factor.tr)2.26627447587445  
##                                                                         -1.033011  
##                                  factor(journal.impact.factor.tr)2.26803880037357  
##                                                                         -0.902682  
##                                  factor(journal.impact.factor.tr)2.26825924444275  
##                                                                         -0.200163  
##                                  factor(journal.impact.factor.tr)2.27310360520589  
##                                                                         -0.386539  
##                                  factor(journal.impact.factor.tr)2.27376340018041  
##                                                                         -1.223972  
##                                  factor(journal.impact.factor.tr)2.27552191815416  
##                                                                          0.179039  
##                                  factor(journal.impact.factor.tr)2.28691932520585  
##                                                                         -0.447630  
##                                  factor(journal.impact.factor.tr)2.29085137012422  
##                                                                          0.408075  
##                                  factor(journal.impact.factor.tr)2.29390496751718  
##                                                                         -0.999428  
##                                   factor(journal.impact.factor.tr)2.3032585612562  
##                                                                         -0.399511  
##                                  factor(journal.impact.factor.tr)2.30412673262562  
##                                                                         -0.335190  
##                                  factor(journal.impact.factor.tr)2.30824608740056  
##                                                                         -1.045950  
##                                   factor(journal.impact.factor.tr)2.3134389985474  
##                                                                         -1.204010  
##                                  factor(journal.impact.factor.tr)2.31754180113326  
##                                                                         -0.164225  
##                                  factor(journal.impact.factor.tr)2.32572569319772  
##                                                                         -0.410125  
##                                  factor(journal.impact.factor.tr)2.32723011324622  
##                                                                         -0.305241  
##                                  factor(journal.impact.factor.tr)2.33302378899145  
##                                                                         -0.197407  
##                                  factor(journal.impact.factor.tr)2.33987179135952  
##                                                                         -1.086897  
##                                  factor(journal.impact.factor.tr)2.34029912618024  
##                                                                         -0.818130  
##                                  factor(journal.impact.factor.tr)2.34051276433178  
##                                                                         -0.746542  
##                                  factor(journal.impact.factor.tr)2.34520787991171  
##                                                                         -0.333512  
##                                  factor(journal.impact.factor.tr)2.35223298165807  
##                                                                         -0.959822  
##                                  factor(journal.impact.factor.tr)2.36220236220354  
##                                                                          0.051564  
##                                  factor(journal.impact.factor.tr)2.36347202225878  
##                                                                         -0.195847  
##                                  factor(journal.impact.factor.tr)2.36664319237185  
##                                                                         -0.899651  
##                                  factor(journal.impact.factor.tr)2.36748812035034  
##                                                                         -0.592907  
##                                  factor(journal.impact.factor.tr)2.37465787009413  
##                                                                         -0.965772  
##                                  factor(journal.impact.factor.tr)2.37676250391157  
##                                                                          0.311939  
##                                  factor(journal.impact.factor.tr)2.38285542994115  
##                                                                         -1.137427  
##                                  factor(journal.impact.factor.tr)2.38976986339689  
##                                                                         -0.304284  
##                                  factor(journal.impact.factor.tr)2.39081576036298  
##                                                                         -0.841428  
##                                  factor(journal.impact.factor.tr)2.39457720694072  
##                                                                         -0.134421  
##                                  factor(journal.impact.factor.tr)2.40208242989286  
##                                                                         -1.018900  
##                                  factor(journal.impact.factor.tr)2.41619535634021  
##                                                                         -0.455510  
##                                   factor(journal.impact.factor.tr)2.4178502848605  
##                                                                         -0.885302  
##                                  factor(journal.impact.factor.tr)2.41909073827337  
##                                                                         -0.136794  
##                                  factor(journal.impact.factor.tr)2.43515913237718  
##                                                                         -0.231701  
##                                  factor(journal.impact.factor.tr)2.43823706804732  
##                                                                         -0.495076  
##                                  factor(journal.impact.factor.tr)2.44948974278318  
##                                                                         -0.260153  
##                                  factor(journal.impact.factor.tr)2.45010203869145  
##                                                                         -0.291884  
##                                  factor(journal.impact.factor.tr)2.45316122584717  
##                                                                          0.431486  
##                                  factor(journal.impact.factor.tr)2.46008129946959  
##                                                                          0.129481  
##                                  factor(journal.impact.factor.tr)2.46048775652308  
##                                                                          0.350258  
##                                   factor(journal.impact.factor.tr)2.4688053791257  
##                                                                         -0.783907  
##                                   factor(journal.impact.factor.tr)2.4726503998746  
##                                                                          0.819240  
##                                  factor(journal.impact.factor.tr)2.47406548013588  
##                                                                         -0.493526  
##                                  factor(journal.impact.factor.tr)2.47850761548154  
##                                                                         -0.955057  
##                                  factor(journal.impact.factor.tr)2.48072570027401  
##                                                                          0.096321  
##                                  factor(journal.impact.factor.tr)2.49258901546163  
##                                                                         -0.211684  
##                                  factor(journal.impact.factor.tr)2.49719843024138  
##                                                                          0.127120  
##                                  factor(journal.impact.factor.tr)2.50019999200064  
##                                                                         -0.584692  
##                                   factor(journal.impact.factor.tr)2.5115732121521  
##                                                                         -2.592973  
##                                  factor(journal.impact.factor.tr)2.51495526799186  
##                                                                          0.294116  
##                                  factor(journal.impact.factor.tr)2.52230053720805  
##                                                                         -0.512908  
##                                  factor(journal.impact.factor.tr)2.52764712727074  
##                                                                          0.129924  
##                                  factor(journal.impact.factor.tr)2.52962447805994  
##                                                                         -0.661430  
##                                  factor(journal.impact.factor.tr)2.53673017879316  
##                                                                         -0.656078  
##                                  factor(journal.impact.factor.tr)2.55342906696074  
##                                                                         -7.933855  
##                                   factor(journal.impact.factor.tr)2.5551907952245  
##                                                                         -2.071973  
##                                  factor(journal.impact.factor.tr)2.55831976109321  
##                                                                          0.357917  
##                                  factor(journal.impact.factor.tr)2.56085923080516  
##                                                                          0.142895  
##                                  factor(journal.impact.factor.tr)2.56495613997589  
##                                                                         -0.396033  
##                                  factor(journal.impact.factor.tr)2.56963032360688  
##                                                                         -0.685084  
##                                  factor(journal.impact.factor.tr)2.58495647932417  
##                                                                         -0.159670  
##                                  factor(journal.impact.factor.tr)2.58534330408942  
##                                                                         -0.677604  
##                                    factor(journal.impact.factor.tr)2.587856255668  
##                                                                         -0.073274  
##                                  factor(journal.impact.factor.tr)2.59094577326504  
##                                                                         -0.852843  
##                                  factor(journal.impact.factor.tr)2.59634358281026  
##                                                                         -0.248005  
##                                  factor(journal.impact.factor.tr)2.62583320110018  
##                                                                          0.531309  
##                                  factor(journal.impact.factor.tr)2.62811719677795  
##                                                                         -0.524864  
##                                  factor(journal.impact.factor.tr)2.63476754192851  
##                                                                         -0.332957  
##                                  factor(journal.impact.factor.tr)2.63799166033557  
##                                                                         -0.331045  
##                                  factor(journal.impact.factor.tr)2.64575131106459  
##                                                                         -4.075843  
##                                  factor(journal.impact.factor.tr)2.65141471671257  
##                                                                         -1.564263  
##                                  factor(journal.impact.factor.tr)2.66645832519468  
##                                                                          0.004935  
##                                  factor(journal.impact.factor.tr)2.66889490238938  
##                                                                         -0.296789  
##                                  factor(journal.impact.factor.tr)2.67450930078772  
##                                                                         -0.014093  
##                                  factor(journal.impact.factor.tr)2.69202525991121  
##                                                                         -0.016503  
##                                  factor(journal.impact.factor.tr)2.70647372054487  
##                                                                         -0.724355  
##                                  factor(journal.impact.factor.tr)2.72360055808483  
##                                                                         -0.233738  
##                                  factor(journal.impact.factor.tr)2.72818621065352  
##                                                                         -0.908470  
##                                  factor(journal.impact.factor.tr)2.73642102023793  
##                                                                         -1.531473  
##                                  factor(journal.impact.factor.tr)2.73733446988124  
##                                                                         -0.140209  
##                                  factor(journal.impact.factor.tr)2.73843020725378  
##                                                                          0.095296  
##                                  factor(journal.impact.factor.tr)2.79499552772451  
##                                                                          0.259093  
##                                  factor(journal.impact.factor.tr)2.79910700045568  
##                                                                         -0.366413  
##                                  factor(journal.impact.factor.tr)2.80321244289476  
##                                                                         -0.544391  
##                                  factor(journal.impact.factor.tr)2.80677751166707  
##                                                                         -1.532662  
##                                  factor(journal.impact.factor.tr)2.83707595950479  
##                                                                         -0.204659  
##                                  factor(journal.impact.factor.tr)2.83830935593709  
##                                                                         -1.291318  
##                                  factor(journal.impact.factor.tr)2.84059852847952  
##                                                                         -0.640338  
##                                  factor(journal.impact.factor.tr)2.84587420663669  
##                                                                         -0.358092  
##                                  factor(journal.impact.factor.tr)2.86146815463671  
##                                                                         -0.776636  
##                                  factor(journal.impact.factor.tr)2.86635657237546  
##                                                                         -0.967277  
##                                  factor(journal.impact.factor.tr)2.87210724033766  
##                                                                         -0.162516  
##                                  factor(journal.impact.factor.tr)2.87749891398763  
##                                                                         -0.162793  
##                                  factor(journal.impact.factor.tr)2.89274955708233  
##                                                                          0.071564  
##                                  factor(journal.impact.factor.tr)2.90447929928929  
##                                                                          0.593901  
##                                  factor(journal.impact.factor.tr)2.90723236085456  
##                                                                         -2.445889  
##                                  factor(journal.impact.factor.tr)2.91787593978908  
##                                                                         -2.148441  
##                                  factor(journal.impact.factor.tr)2.92369629065674  
##                                                                         -0.347748  
##                                   factor(journal.impact.factor.tr)2.9565182225043  
##                                                                          0.540725  
##                                  factor(journal.impact.factor.tr)2.98010066944055  
##                                                                         -2.605782  
##                                  factor(journal.impact.factor.tr)3.04877024388523  
##                                                                          0.522518  
##                                  factor(journal.impact.factor.tr)3.06561576196365  
##                                                                          0.024747  
##                                  factor(journal.impact.factor.tr)3.10386855391784  
##                                                                         -1.057931  
##                                  factor(journal.impact.factor.tr)3.10998392278803  
##                                                                          0.477541  
##                                  factor(journal.impact.factor.tr)3.13592091737021  
##                                                                          0.025837  
##                                  factor(journal.impact.factor.tr)3.14372390645235  
##                                                                          0.188517  
##                                  factor(journal.impact.factor.tr)3.18119474411737  
##                                                                          0.572018  
##                                  factor(journal.impact.factor.tr)3.18198051533946  
##                                                                          0.439427  
##                                  factor(journal.impact.factor.tr)3.20873806970903  
##                                                                          0.297829  
##                                   factor(journal.impact.factor.tr)3.2218007387174  
##                                                                         -7.216189  
##                                  factor(journal.impact.factor.tr)3.25622480796397  
##                                                                         -0.101134  
##                                  factor(journal.impact.factor.tr)3.28115833205287  
##                                                                          0.236164  
##                                  factor(journal.impact.factor.tr)3.28222485518588  
##                                                                         -1.323214  
##                                  factor(journal.impact.factor.tr)3.28511795830835  
##                                                                         -0.153163  
##                                   factor(journal.impact.factor.tr)3.3149660631747  
##                                                                          0.120358  
##                                  factor(journal.impact.factor.tr)3.33961075576181  
##                                                                          0.534512  
##                                  factor(journal.impact.factor.tr)3.34305249734431  
##                                                                          0.119463  
##                                  factor(journal.impact.factor.tr)3.38112407344067  
##                                                                         -2.330649  
##                                  factor(journal.impact.factor.tr)3.43176339510754  
##                                                                          0.495365  
##                                  factor(journal.impact.factor.tr)3.46222471829891  
##                                                                         -0.173825  
##                                  factor(journal.impact.factor.tr)3.63909329366533  
##                                                                         -0.087197  
##                                  factor(journal.impact.factor.tr)3.67926623119339  
##                                                                         -1.600859  
##                                  factor(journal.impact.factor.tr)3.68659734714818  
##                                                                         -0.049534  
##                                  factor(journal.impact.factor.tr)3.69905393310235  
##                                                                          0.712596  
##                                  factor(journal.impact.factor.tr)3.72585560643458  
##                                                                          0.279981  
##                                  factor(journal.impact.factor.tr)3.72867268609086  
##                                                                          0.489606  
##                                  factor(journal.impact.factor.tr)3.82400313807403  
##                                                                          0.834615  
##                                  factor(journal.impact.factor.tr)3.82766247205785  
##                                                                          1.596228  
##                                  factor(journal.impact.factor.tr)3.88600051466801  
##                                                                         -0.510740  
##                                  factor(journal.impact.factor.tr)3.89486841883009  
##                                                                          0.582471  
##                                  factor(journal.impact.factor.tr)3.94905051879563  
##                                                                         -0.272993  
##                                  factor(journal.impact.factor.tr)3.99161621401657  
##                                                                          0.466779  
##                                   factor(journal.impact.factor.tr)4.0574622610691  
##                                                                          0.866765  
##                                   factor(journal.impact.factor.tr)4.1360609279845  
##                                                                          0.698115  
##                                  factor(journal.impact.factor.tr)4.19034604776264  
##                                                                          1.021534  
##                                  factor(journal.impact.factor.tr)4.22208479308505  
##                                                                          1.165336  
##                                  factor(journal.impact.factor.tr)4.26110314355332  
##                                                                         -0.244339  
##                                  factor(journal.impact.factor.tr)4.33289741397139  
##                                                                          1.003705  
##                                  factor(journal.impact.factor.tr)4.64532022577561  
##                                                                          1.444628  
##                                  factor(journal.impact.factor.tr)5.09529194453075  
##                                                                          0.728855  
##                                  factor(journal.impact.factor.tr)5.11008806186351  
##                                                                          0.111547  
##                                  factor(journal.impact.factor.tr)5.34350072518008  
##                                                                          1.591525  
##                                   factor(journal.impact.factor.tr)5.3947196405374  
##                                                                          0.713769  
##                                  factor(journal.impact.factor.tr)5.59097487027084  
##                                                                          0.696479  
##                                  factor(journal.impact.factor.tr)5.67917247492978  
##                                                                          1.496836  
##                                  factor(journal.impact.factor.tr)5.69508560076141  
##                                                                          0.930573  
##                                  factor(journal.impact.factor.tr)5.71996503485817  
##                                                                          0.820095  
##                                   factor(journal.impact.factor.tr)7.1426185674443  
##                                                                          1.900645  
##                                rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed  
##                                                                         -0.000546  
##                               rcs(pubmed.date.in.pubmed, 3)pubmed.date.in.pubmed'  
##                                                                         -0.000283  
##                rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr  
##                                                                         -0.046563  
##               rcs(first.author.num.prev.pubs.tr, 3)first.author.num.prev.pubs.tr'  
##                                                                          0.037663  
##      rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr  
##                                                                          0.034736  
##     rcs(first.author.num.prev.pmc.cites.tr, 3)first.author.num.prev.pmc.cites.tr'  
##                                                                         -0.029711  
##      rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr  
##                                                                         -0.042125  
##     rcs(first.author.year.first.pub.ago.tr, 3)first.author.year.first.pub.ago.tr'  
##                                                                          0.014134  
##                  rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr  
##                                                                         -0.030997  
##                 rcs(last.author.num.prev.pubs.tr, 3)last.author.num.prev.pubs.tr'  
##                                                                          0.035799  
##        rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr  
##                                                                          0.009035  
##       rcs(last.author.num.prev.pmc.cites.tr, 3)last.author.num.prev.pmc.cites.tr'  
##                                                                         -0.007564  
##        rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr  
##                                                                          0.038196  
##       rcs(last.author.year.first.pub.ago.tr, 3)last.author.year.first.pub.ago.tr'  
##                                                                         -0.057990  
##                                                                     country.usa.L  
##                                                                          0.019532  
##                                                           pubmed.is.open.access.L  
##                                                                         -0.073592  
##  rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score  
##                                                                          0.050566  
## rcs(institution.mean.norm.citation.score, 3)institution.mean.norm.citation.score'  
##                                                                         -0.014356  
##                  rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr  
##                                                                         -0.050800  
##                 rcs(journal.num.articles.2008.tr, 3)journal.num.articles.2008.tr'  
##                                                                          0.316060  
##                              rcs(journal.cited.halflife, 3)journal.cited.halflife  
##                                                                          0.156135  
##                             rcs(journal.cited.halflife, 3)journal.cited.halflife'  
##                                                                         -0.218984  
##                                                        factor(pubmed.is.cancer).L  
##                                                                          0.005610  
##                                                       factor(pubmed.is.animals).L  
##                                                                         -0.105151  
##                                                        factor(pubmed.is.plants).L  
##                                                                          0.130774  
##                                         factor(pubmed.is.core.clinical.journal).L  
##                                                                                NA  
##                                                    factor(dataset.in.geo.or.ae).L  
##                                                                          0.084393  
## 
</div><div class="source"><span class="symbol">citation.boost.coefs.journal</span> <span class="assignement">=</span> <span class="functioncall">calcCI.exp</span><span class="keyword">(</span><span class="symbol">fit_w_journal</span><span class="keyword">,</span> <span class="string">"factor(dataset.in.geo.or.ae).L"</span><span class="keyword">)</span>
<span class="functioncall">print</span><span class="keyword">(</span><span class="symbol">citation.boost.coefs.journal</span><span class="keyword">)</span>
</div><div class="output">##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.09  1.05   1.13 0
</div></pre>


Estimate of citation boost is 
<code class="knitr inline">9</code>%
with 95% confidence intervals [<code class="knitr inline">5</code>%
, <code class="knitr inline">13</code>% ]
(p=<code class="knitr inline">0.00</code>)

##### Now by year

<pre class="knitr"><div class="source">
<span class="symbol">do_analysis</span> <span class="assignement">=</span> <span class="keyword">function</span><span class="keyword">(</span><span class="formalargs">mydat</span><span class="keyword">)</span> <span class="keyword">{</span>
  <span class="symbol">myfit</span> <span class="assignement">=</span> <span class="functioncall">lm</span><span class="keyword">(</span><span class="symbol">nCitedBy.log</span> <span class="keyword">~</span> <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">num.authors.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">pubmed.date.in.pubmed</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(first.author.num.prev.pubs.tr, 3) +           </span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">first.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(first.author.year.first.pub.ago.tr, 3) +     </span>
  <span class="comment">#rcs(last.author.num.prev.pubs.tr, 3) +           </span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">last.author.num.prev.pmc.cites.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(last.author.year.first.pub.ago.tr, 3) +</span>
  <span class="comment">#country.usa +              </span>
  <span class="symbol">pubmed.is.open.access</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">institution.mean.norm.citation.score</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.num.articles.2008.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#rcs(journal.cited.halflife, 3) +                 </span>
  <span class="functioncall">rcs</span><span class="keyword">(</span><span class="symbol">journal.impact.factor.tr</span><span class="keyword">,</span> <span class="number">3</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.cancer</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">factor</span><span class="keyword">(</span><span class="symbol">pubmed.is.animals</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="comment">#factor(pubmed.is.plants) +</span>
  <span class="comment">#factor(pubmed.is.core.clinical.journal) +</span>
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
## | rcs(num.authors.tr, 3)                       | 2.00  | 10.07  | 5.03    | 9.18    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00  | 0.49   | 0.24    | 0.44    | 0.64   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00  | 2.52   | 1.26    | 2.30    | 0.11   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00  | 14.09  | 7.04    | 12.84   | 0.00   |
## | pubmed.is.open.access                        | 1.00  | 0.02   | 0.02    | 0.03    | 0.86   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00  | 5.78   | 2.89    | 5.27    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00  | 0.96   | 0.48    | 0.87    | 0.42   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00  | 3.99   | 1.99    | 3.63    | 0.03   |
## | factor(pubmed.is.cancer)                     | 1.00  | 0.07   | 0.07    | 0.12    | 0.73   |
## | factor(pubmed.is.animals)                    | 1.00  | 0.77   | 0.77    | 1.41    | 0.24   |
## | factor(dataset.in.geo.or.ae)                 | 1.00  | 0.85   | 0.85    | 1.54    | 0.22   |
## | Residuals                                    | 82.00 | 44.98  | 0.55    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.37  0.83   2.25 0.218
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 7.65   | 3.83    | 5.71    | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.87   | 1.43    | 2.14    | 0.12   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 1.88   | 0.94    | 1.40    | 0.25   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.88  | 6.94    | 10.35   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.54   | 2.54    | 3.79    | 0.05   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.35   | 2.67    | 3.99    | 0.02   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 3.21   | 1.60    | 2.39    | 0.09   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 32.42  | 16.21   | 24.19   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.38   | 0.38    | 0.57    | 0.45   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.14   | 0.14    | 0.21    | 0.65   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.75   | 0.75    | 1.11    | 0.29   |
## | Residuals                                    | 231.00 | 154.78 | 0.67    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.15  0.89   1.49 0.292
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 11.90  | 5.95    | 10.92   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 11.65  | 5.83    | 10.70   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 9.87   | 4.93    | 9.06    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 13.57  | 6.78    | 12.46   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.11   | 0.11    | 0.20    | 0.65   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.46   | 1.23    | 2.26    | 0.11   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 4.79   | 2.39    | 4.39    | 0.01   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 26.20  | 13.10   | 24.05   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.57   | 1.57    | 2.88    | 0.09   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.34   | 0.34    | 0.62    | 0.43   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 2.22   | 2.22    | 4.08    | 0.04   |
## | Residuals                                    | 355.00 | 193.32 | 0.54    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.19  1.01   1.41 0.044
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.77  | 12.39   | 20.71   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.73   | 2.87    | 4.79    | 0.01   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 22.94  | 11.47   | 19.18   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 23.95  | 11.97   | 20.03   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 6.66   | 6.66    | 11.14   | 0.00   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.72   | 1.36    | 2.28    | 0.10   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 9.60   | 4.80    | 8.03    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 43.34  | 21.67   | 36.24   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 4.04   | 4.04    | 6.75    | 0.01   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.14   | 0.14    | 0.23    | 0.63   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 9.82   | 9.82    | 16.43   | 0.00   |
## | Residuals                                    | 492.00 | 294.18 | 0.60    |         |        |
##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.29  1.14   1.45 0
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 25.81  | 12.90   | 27.77   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 0.60   | 0.30    | 0.65    | 0.52   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 23.89  | 11.94   | 25.70   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 12.34  | 6.17    | 13.28   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.04   | 0.04    | 0.10    | 0.76   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 7.80   | 3.90    | 8.39    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 15.58  | 7.79    | 16.76   | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 51.76  | 25.88   | 55.70   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 11.58  | 11.58   | 24.93   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.03   | 2.03    | 4.36    | 0.04   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 13.58  | 13.58   | 29.22   | 0.00   |
## | Residuals                                    | 568.00 | 263.90 | 0.46    |         |        |
##                                   param  est ciLow ciHigh p
## Estimate factor(dataset.in.geo.or.ae).L 1.33   1.2   1.47 0
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 35.85  | 17.92   | 33.66   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 2.45   | 1.23    | 2.30    | 0.10   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 19.51  | 9.75    | 18.32   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 17.65  | 8.83    | 16.58   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.23   | 0.23    | 0.43    | 0.51   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.80   | 1.40    | 2.63    | 0.07   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 8.04   | 4.02    | 7.55    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 64.29  | 32.14   | 60.37   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 9.53   | 9.53    | 17.90   | 0.00   |
## | factor(pubmed.is.animals)                    | 1.00   | 7.44   | 7.44    | 13.97   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 4.96   | 4.96    | 9.31    | 0.00   |
## | Residuals                                    | 562.00 | 299.25 | 0.53    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.16  1.06   1.28 0.002
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 24.19  | 12.10   | 23.96   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 5.35   | 2.67    | 5.30    | 0.01   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 11.75  | 5.88    | 11.64   | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 11.00  | 5.50    | 10.90   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.01   | 0.01    | 0.01    | 0.91   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 2.76   | 1.38    | 2.74    | 0.07   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 5.52   | 2.76    | 5.47    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 56.28  | 28.14   | 55.76   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 1.27   | 1.27    | 2.51    | 0.11   |
## | factor(pubmed.is.animals)                    | 1.00   | 0.85   | 0.85    | 1.69    | 0.19   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 2.03   | 2.03    | 4.02    | 0.05   |
## | Residuals                                    | 712.00 | 359.35 | 0.50    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.08     1   1.17 0.045
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 40.91  | 20.46   | 36.33   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.79    | 13.83   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 6.76   | 3.38    | 6.00    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 16.74  | 8.37    | 14.87   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 2.13   | 2.13    | 3.79    | 0.05   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 5.44   | 2.72    | 4.83    | 0.01   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 10.35  | 5.18    | 9.20    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 59.59  | 29.80   | 52.92   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 3.16   | 3.16    | 5.61    | 0.02   |
## | factor(pubmed.is.animals)                    | 1.00   | 6.81   | 6.81    | 12.10   | 0.00   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 1.83   | 1.83    | 3.25    | 0.07   |
## | Residuals                                    | 667.00 | 375.50 | 0.56    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.08  0.99   1.18 0.072
## |                                              | Df     | Sum Sq | Mean Sq | F value | Pr(>F) |
## |----------------------------------------------|--------|--------|---------|---------|--------|
## | rcs(num.authors.tr, 3)                       | 2.00   | 43.96  | 21.98   | 43.45   | 0.00   |
## | rcs(pubmed.date.in.pubmed, 3)                | 2.00   | 15.57  | 7.78    | 15.39   | 0.00   |
## | rcs(first.author.num.prev.pmc.cites.tr, 3)   | 2.00   | 7.31   | 3.65    | 7.22    | 0.00   |
## | rcs(last.author.num.prev.pmc.cites.tr, 3)    | 2.00   | 10.94  | 5.47    | 10.82   | 0.00   |
## | pubmed.is.open.access                        | 1.00   | 0.57   | 0.57    | 1.12    | 0.29   |
## | rcs(institution.mean.norm.citation.score, 3) | 2.00   | 8.23   | 4.11    | 8.13    | 0.00   |
## | rcs(journal.num.articles.2008.tr, 3)         | 2.00   | 7.82   | 3.91    | 7.73    | 0.00   |
## | rcs(journal.impact.factor.tr, 3)             | 2.00   | 58.49  | 29.24   | 57.81   | 0.00   |
## | factor(pubmed.is.cancer)                     | 1.00   | 0.09   | 0.09    | 0.19    | 0.67   |
## | factor(pubmed.is.animals)                    | 1.00   | 2.48   | 2.48    | 4.90    | 0.03   |
## | factor(dataset.in.geo.or.ae)                 | 1.00   | 0.02   | 0.02    | 0.04    | 0.84   |
## | Residuals                                    | 533.00 | 269.64 | 0.51    |         |        |
##                                   param  est ciLow ciHigh     p
## Estimate factor(dataset.in.geo.or.ae).L 1.01  0.92   1.11 0.838
</div><div class="source">
<span class="symbol">estimates_by_year</span>
</div><div class="output">##           year                          param  est ciLow ciHigh     p
## Estimate  2001 factor(dataset.in.geo.or.ae).L 1.37  0.83   2.25 0.218
## Estimate1 2002 factor(dataset.in.geo.or.ae).L 1.15  0.89   1.49 0.292
## Estimate2 2003 factor(dataset.in.geo.or.ae).L 1.19  1.01   1.41 0.044
## Estimate3 2004 factor(dataset.in.geo.or.ae).L 1.29  1.14   1.45 0.000
## Estimate4 2005 factor(dataset.in.geo.or.ae).L 1.33  1.20   1.47 0.000
## Estimate5 2006 factor(dataset.in.geo.or.ae).L 1.16  1.06   1.28 0.002
## Estimate6 2007 factor(dataset.in.geo.or.ae).L 1.08  1.00   1.17 0.045
## Estimate7 2008 factor(dataset.in.geo.or.ae).L 1.08  0.99   1.18 0.072
## Estimate8 2009 factor(dataset.in.geo.or.ae).L 1.01  0.92   1.11 0.838
</div><div class="source">
<span class="functioncall">ggplot</span><span class="keyword">(</span><span class="symbol">estimates_by_year</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">x</span><span class="argument">=</span><span class="symbol">year</span><span class="keyword">,</span> <span class="argument">y</span><span class="argument">=</span><span class="symbol">est</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span> <span class="functioncall">geom_line</span><span class="keyword">(</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_errorbar</span><span class="keyword">(</span><span class="argument">width</span><span class="argument">=</span><span class="number">.1</span><span class="keyword">,</span> <span class="functioncall">aes</span><span class="keyword">(</span><span class="argument">ymin</span><span class="argument">=</span><span class="symbol">ciLow</span><span class="keyword">,</span> <span class="argument">ymax</span><span class="argument">=</span><span class="symbol">ciHigh</span><span class="keyword">)</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_x_continuous</span><span class="keyword">(</span><span class="argument">name</span><span class="argument">=</span><span class="string">'year of publication'</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">scale_y_continuous</span><span class="keyword">(</span><span class="argument">limits</span><span class="argument">=</span><span class="functioncall">c</span><span class="keyword">(</span><span class="number">0</span><span class="keyword">,</span> <span class="number">2.5</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">name</span><span class="argument">=</span><span class="string">'citations proportion for \n(papers with available data)/(those without)'</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/TuLdT.png" class="plot" />
</pre>


##### Now by year

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
</div><img src="http://i.imgur.com/LLZoI.png" class="plot" />
<div class="source"><span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">nCitedBy</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="symbol">isCreated</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="string">"density"</span><span class="keyword">,</span> <span class="argument">binwidth</span><span class="argument">=</span><span class="number">25</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/QYhbG.png" class="plot" />
<div class="source"><span class="functioncall">qplot</span><span class="keyword">(</span><span class="symbol">isCreated</span><span class="keyword">,</span> <span class="functioncall">log</span><span class="keyword">(</span><span class="number">1</span><span class="keyword">+</span><span class="symbol">nCitedBy</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">data</span><span class="argument">=</span><span class="symbol">dfCitationsAnnotated</span><span class="keyword">,</span> <span class="argument">geom</span><span class="argument">=</span><span class="string">"boxplot"</span><span class="keyword">)</span> <span class="keyword">+</span>
  <span class="functioncall">geom_jitter</span><span class="keyword">(</span><span class="argument">position</span><span class="argument">=</span><span class="functioncall">position_jitter</span><span class="keyword">(</span><span class="argument">width</span><span class="argument">=</span><span class="number">.1</span><span class="keyword">)</span><span class="keyword">,</span> <span class="argument">color</span><span class="argument">=</span><span class="string">"blue"</span><span class="keyword">)</span>
</div><img src="http://i.imgur.com/rcCAa.png" class="plot" />
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
In a multivariate linear regression on <code class="knitr inline">10555</code> studies that created gene expression microarray data, we found that studies with data in centralized public repositories received 
<code class="knitr inline">13</code>%
(95% confidence interval: [<code class="knitr inline">9</code>%
to <code class="knitr inline">17</code>%)
more citations than similar studies without available data.  Date of publication, journal impact factor, journal citation half-life, journal size, number of authors, first and last author number of previous publications and citations, corresponding author country, institution citation mean score, and study topic were included as covariates.  A small independent investigation of citations to microarray studies with publicly available data found that about 
<code class="knitr inline">6</code>%
(95% CI: <code class="knitr inline">3</code>%
to <code class="knitr inline">11</code>%, 
n=<code class="knitr inline">138</code>)
of citations to those studies were in the context of data reuse attribution.

### Discussion
This analysis reveals a modest but substantiated boost in data citation rates across a wide selection of studies that made their data publicly available.  Though modest, the impact represented by these data attributions should not be underestimated: attribution in the context of data reuse demonstrates a real and demonstrable contribution to subsequent research.


