
require(plyr)

# transform for count data
# using sqrt with minimum value of 1, as per advice at
# http://www.webcitation.org/query?url=http%3A%2F%2Fpareonline.net%2Fgetvn.asp%3Fv%3D8%26n%3D6&date=2010-02-11
tr = function(x) return(sqrt(1 + x))

log.tr = function(x) return(log(1 + x))

undo.tr = function(y) return(y^2 - 1)

undo.log.tr = function(y) return(exp(y) - 1)

get.dat.nums = function (dat.raw) {
    dat.nums = colwise(as.numeric)(dat.raw)  ##<<details this produces warnings
    return(dat.nums)
}


preprocess.raw.data = function
### Do preprocessing on raw data
### change variables to ordered factors, integers, etc as appropriate
### return cleaned data as a data frame
(
    dat.raw ##<< data frame containing raw data
)
{
    names(dat.raw) = gsub("_", ".", names(dat.raw))
    
    ####  CONVERT STRINGS TO NUMBERS 
    dat.nums = get.dat.nums(dat.raw)  ##<<details this produces warnings
    
    #library(psych)
    #described.dat.nums = psych::describe(dat.nums)
    #write.table(described.dat.nums,"described_dat_nums.txt",append=F,quote=F,sep="\t",row.names=T)

    #### START TO BUILD STATS DATASET
    dat = data.frame(pmid = as.numeric(dat.nums$pmid))


    # skip issn
    # skip essn
    # My naming convention is that "ago" means number of years between 2010 and the original variable
    dat$pubmed.year.published = dat.nums$pubmed.year.published
    dat$years.ago.tr = tr(2010 - dat.nums$pubmed.year.published)
    dat$pubmed.date.in.pubmed = dat.nums$pubmed.date.in.pubmed
    
    dat$num.authors.tr = tr(dat.nums$pubmed.number.authors)

    ####### FIRST AUTHOR VARIABLES

    # skip first_author_first_name
    dat$first.author.female                 = ordered(dat.nums$author.first.author.female)
    dat$first.author.female[which(pmax(dat.nums$author.first.author.male, dat.nums$author.first.author.female) <= 0)] = NA

    # Removing male because so highly correlated with female
    #dat$first.author.male                   = ordered(dat.nums$author.first.author.male)
    dat$first.author.gender.not.found       = ordered(dat.nums$author.first.author.gender.not.found)
    dat$first.author.num.prev.pubs.tr       = tr(dat.nums$first.author.num.prev.pubs)
    dat$first.author.num.prev.pmc.cites.tr  = tr(dat.nums$first.author.num.prev.pmc.cites)

    dat$first.author.year.first.pub.ago.tr  = tr( 2010 - dat.nums$first.author.year.first.pub)
    # NAs are either because there was no cluster, or the cluster included no prior papers
    # (unfortunately, I didn't collect an indication of which was true, but in theory there should
    # be a cluster for all papers published before 2009 Author-ity data was run, so I will 
    # assume it is the latter, that there we no prior papers.)  
    # I will code no prior papers as zero years since the prior paper
    dat$first.author.year.first.pub.ago.tr[is.na(dat.nums$first.author.year.first.pub)] = tr(0)

    dat$first.author.num.prev.microarray.creations.tr = tr(dat.nums$first.author.num.prev.microarray.creations)

    # set to NA if the number of publications is unrealistically big, because this probably means that
    # Author-ity combined two or more authors together.  Better to set to NA and deal with bias than introduce
    # such large numbers into our data
    first.author.thresh.cluster.size = quantile(dat$first.author.num.prev.pubs.tr, .98, na.rm=TRUE)
    first.author.unrealistic.pub.clusters = which(dat$first.author.num.prev.pubs.tr > first.author.thresh.cluster.size)
    dat$first.author.num.prev.pubs.tr[first.author.unrealistic.pub.clusters] = NA
    dat$first.author.num.prev.pmc.cites.tr[first.author.unrealistic.pub.clusters] = NA
    dat$first.author.year.first.pub.ago.tr[first.author.unrealistic.pub.clusters] = NA
    dat$first.author.num.prev.microarray.creations.tr[first.author.unrealistic.pub.clusters] = NA


    ####### LAST AUTHOR VARIABLES

    # skip last_author_first_name
    dat$last.author.female                 = ordered(dat.nums$last.first.author.female)
    dat$last.author.female[which(pmax(dat.nums$last.first.author.male, dat.nums$last.first.author.female) <= 0)] = NA

    # Removing male because so highly correlated with female
    #dat$last.author.male                   = ordered(dat.nums$last.first.author.male)
    dat$last.author.gender.not.found       = ordered(dat.nums$last.first.author.gender.not.found)
    dat$last.author.num.prev.pubs.tr        = tr(dat.nums$last.author.num.prev.pubs)
    dat$last.author.num.prev.pmc.cites.tr   = tr(dat.nums$last.author.num.prev.pmc.cites)

    dat$last.author.year.first.pub.ago.tr   = tr(2010 - dat.nums$last.author.year.first.pub)
    # See comment on first author above for treatment of NAs for this variable
    dat$last.author.year.first.pub.ago.tr[is.na(dat.nums$last.author.year.first.pub)] = tr(0)

    dat$last.author.num.prev.microarray.creations.tr = tr(dat.nums$last.author.num.prev.microarray.creations)

    # set to NA if the number of publications is unrealistically big, because this probably means that
    # Author-ity combined two or more authors together.  Better to set to NA and deal with bias than introduce
    # such large numbers into our data
    last.author.thresh.cluster.size = quantile(dat$last.author.num.prev.pubs.tr, .98, na.rm=TRUE)
    last.author.unrealistic.pub.clusters = which(dat$last.author.num.prev.pubs.tr >= last.author.thresh.cluster.size)
    dat$last.author.num.prev.pubs.tr[last.author.unrealistic.pub.clusters] = NA
    dat$last.author.num.prev.pmc.cites.tr[last.author.unrealistic.pub.clusters] = NA
    dat$last.author.year.first.pub.ago.tr[last.author.unrealistic.pub.clusters] = NA
    dat$last.author.num.prev.microarray.creations.tr[last.author.unrealistic.pub.clusters] = NA

    ####  SOME FUNDING VARIABLES AND STUDY VARIABLES
    # skip address
    # skip institution, use instition_clean instead below
    # skip country, use country_clean instead below
    # skip grant_numbers, use lots of other related variables below
    dat$num.grant.numbers.tr = tr(dat.nums$num.grant.numbers)

    # skip is_review because all 0s, as it should be
    # need to use pubmed.medline.status to figure out what should really be NA because of incomplete mesh terms
    dat$pubmed.is.humans    = ordered(medline.values(dat.nums$pubmed.is.humans, dat.raw$pubmed.medline.status))
    dat$pubmed.is.animals   = ordered(medline.values(dat.nums$pubmed.is.animals, dat.raw$pubmed.medline.status))
    dat$pubmed.is.mice      = ordered(medline.values(dat.nums$pubmed.is.mice, dat.raw$pubmed.medline.status))
    dat$pubmed.is.fungi     = ordered(medline.values(dat.nums$pubmed.is.fungi, dat.raw$pubmed.medline.status))
    dat$pubmed.is.bacteria  = ordered(medline.values(dat.nums$pubmed.is.bacteria, dat.raw$pubmed.medline.status))
    dat$pubmed.is.plants    = ordered(medline.values(dat.nums$pubmed.is.plants, dat.raw$pubmed.medline.status))
    dat$pubmed.is.viruses   = ordered(medline.values(dat.nums$pubmed.is.viruses, dat.raw$pubmed.medline.status))
    dat$pubmed.is.cultured.cells    = ordered(medline.values(dat.nums$pubmed.is.cultured.cells, dat.raw$pubmed.medline.status))
    # is cancer appears to depend not entirely on MEDLINE completeness
    dat$pubmed.is.cancer        = ordered(dat.nums$pubmed.is.cancer)
    # Open access filter, and some others below, are by journal not article, so doesn't depend on MEDLINE completion status
    dat$pubmed.is.open.access   = ordered(dat.nums$pubmed.is.open.access)
    dat$pubmed.is.effectiveness = ordered(medline.values(dat.nums$pubmed.is.effectiveness, dat.raw$pubmed.medline.status))
    dat$pubmed.is.diagnosis     = ordered(medline.values(dat.nums$pubmed.is.diagnosis, dat.raw$pubmed.medline.status))
    dat$pubmed.is.prognosis     = ordered(medline.values(dat.nums$pubmed.is.prognosis, dat.raw$pubmed.medline.status))
    dat$pubmed.is.core.clinical.journal = ordered(dat.nums$pubmed.is.core.clinical.journal)
    # skip is_clinical_trial because not enough
    # skip is_randomized_clinical_trial because not enough
    # skip is_meta_analysis because none (yay!)
    dat$pubmed.is.comparative.study = ordered(medline.values(dat.nums$pubmed.is.comparative.study, dat.raw$pubmed.medline.status))
    # skip multicenter because not enough (surprising?)
    # skip validation because not enough (surprising?)
    # skip funded_stimulus because all 0s
    # external funding seems set sometimes even for 1s, so doesn't depend on MEDLINE completely
    # commenting out external in favour of a combined nih below
    #dat$pubmed.is.funded.nih.extramural   = ordered(dat.nums$pubmed.is.funded.nih.extramural)
    dat$pubmed.is.funded.nih.intramural   = ordered(dat.nums$pubmed.is.funded.nih.intramural)
    # Combining extramural, intramural, and whether the PMID had a link to funding in the NIH data sources
    dat$pubmed.is.funded.nih            = ordered(pmax(dat.nums$pubmed.is.funded.nih.extramural, dat.nums$pubmed.is.funded.nih.intramural, !is.na(dat.nums$num.grants)))
    dat$pubmed.is.funded.non.us.govt    = ordered(dat.nums$pubmed.is.funded.non.us.govt)
    # Sharing in PDB and Swissprot very small, so will combine
    dat$pubmed.is.shared.other          = ordered(pmax(dat.nums$pubmed.in.genbank, dat.nums$pubmed.in.pdb, dat.nums$pubmed.in.swissprot))
    # geo.reuse is tiny but I want to use it anyway!
    dat$pubmed.is.geo.reuse             = ordered(dat.nums$is.geo.reuse)
    dat$pubmed.num.cites.from.pmc.tr    = tr(dat.nums$pubmed.number.times.cited.in.pmc)
    dat$pubmed.num.cites.from.pmc.per.year = dat.nums$pubmed.number.times.cited.in.pmc/(2010 - dat.nums$pubmed.year.published)
    # Comment these out for now, because they look wrong
    #dat$found.by.highwire               = ordered(dat.nums$found.by.highwire)
    #dat$found.by.scirus                 = ordered(dat.nums$found.by.highwire)
    #dat$found.by.googlescholar          = ordered(dat.nums$found.by.highwire)
    #dat$found.by.pmc                    = ordered(dat.nums$portal.pmids.found.by.pmc)

    ##### DEPENDENT VARIABLES
    dat$dataset.in.geo                  = ordered(dat.nums$pubmed.in.geo)
    # commenting this out in favour of a combined metric below
    #dat$dataset.in.arrayexpress         = ordered(dat.nums$in.arrayexpress)
    dat$dataset.in.geo.or.ae            = ordered(dat.nums$in.ae.or.geo)

    ###### INSTITUTION
    dat$country.australia              = ordered(ifelse("Australia" == dat.raw$country.clean, 1, 0))
    dat$country.canada                 = ordered(ifelse("Canada" == dat.raw$country.clean, 1, 0))
    dat$country.china                  = ordered(ifelse("China" == dat.raw$country.clean, 1, 0))
    dat$country.france                 = ordered(ifelse("France" == dat.raw$country.clean, 1, 0))
    dat$country.germany                = ordered(ifelse("Germany" == dat.raw$country.clean, 1, 0))
    dat$country.japan                  = ordered(ifelse("Japan" == dat.raw$country.clean, 1, 0))
    dat$country.korea                  = ordered(ifelse("Korea" == dat.raw$country.clean, 1, 0))
    dat$country.uk                     = ordered(ifelse("UK" == dat.raw$country.clean, 1, 0))
    dat$country.usa                    = ordered(ifelse("USA" == dat.raw$country.clean, 1, 0))
    dat$institution.is.medical         = ordered(dat.nums$institution.hospital.or.medlcal)
    dat$institution.rank               = dat.nums$institution.rank
    dat$institution.is.higher.ed       = ordered(ifelse("Higher educ." == dat.raw$institution.sector, 1, 0))
    dat$institution.is.higher.ed[which(is.na(dat$institution.rank))] = NA
    dat$institution.is.govnt           = ordered(ifelse("Government" == dat.raw$institution.sector, 1, 0))
    dat$institution.is.govnt[which(is.na(dat$institution.rank))] = NA
    dat$institution.research.output.tr = tr(dat.nums$institution.output)
    dat$institution.international.collaboration = dat.nums$international.collaboration
    dat$institution.mean.norm.impact.factor     = dat.nums$institution.norm.sjr
    dat$institution.mean.norm.citation.score    = dat.nums$institution.norm.citation.score

    # Include variables for the three most common institutions
    #top.institutions = names(sort(table(dat.institutions$institutions.factor), decreasing=TRUE)[0:25])
    #display.institutions = c(top.institutions)
    dat$institution.harvard            = ordered(ifelse("Harvard University" == dat.raw$institution.clean, 1, 0))
    dat$institution.nci                = ordered(ifelse("National Cancer Institute" == dat.raw$institution.clean, 1, 0))
    dat$institution.stanford           = ordered(ifelse("Stanford University" == dat.raw$institution.clean, 1, 0))

    ### JOURNAL VARIABLES
    # skip total cites 2008 because it could be due to so many things, not very informative
    #dat$journal.cites.2008.tr       = tr(dat.nums$journal.2008.cites)
    dat$journal.impact.factor.tr   = tr(dat.nums$journal.impact.factor)

    dat$journal.impact.factor.log   = log.tr(dat.nums$journal.impact.factor)

    # PLoS One is a big part of our sample, and doesn't have an official impact factor yet.
    # Important, because it is relatively low, so better to give it our estimate instead of leave missing
    # Estimate of 3 comes from http://pbeltrao.blogspot.com/2009/04/guestimating-plos-one-impact-factor.html
    dat$journal.impact.factor.log[which(dat.raw$pubmed.journal== "PLoS One")] = log.tr(3)

    dat$journal.5yr.impact.factor.log = log.tr(dat.nums$journal.5yr.impact.factor)
    dat$journal.immediacy.index.log = log.tr(dat.nums$journal.immediacy.index)
    dat$journal.num.articles.2008.tr = tr(dat.nums$journal.num.articles.2008)
    dat$journal.cited.halflife      = dat.nums$journal.cited.halflife

    # Add a variable saying how many microarray creating (as defined by being in this set)
    # papers the journal has published
    table.journal.counts = table(dat.raw$pubmed.journal)
    dat$journal.microarray.creating.count.tr = tr(as.numeric(table.journal.counts[dat.raw$pubmed.journal]))

    #### MORE FUNDING VARIABLES
    # set the missing values to 0 or tr(0), as appropriate

    # skip pmid:1 as duplicate column
    dat$num.grants.via.nih.tr   = tr(dat.nums$num.grants)
    dat$num.grants.via.nih.tr[is.na(dat$num.grants.via.nih.tr)] = tr(0)
    dat$max.grant.duration.tr   = tr(dat.nums$longest.num.years)
    dat$max.grant.duration.tr[is.na(dat$max.grant.duration.tr)] = tr(0)

    dat$nih.first.year.ago.tr   = tr(2010 - dat.nums$first.year)
    dat$nih.first.year.ago.tr[is.na(dat$nih.first.year.ago.tr)] = NA
    dat$nih.last.year.ago.tr    = tr(2010 - dat.nums$last.year)
    dat$nih.last.year.ago.tr[is.na(dat$nih.last.year.ago.tr)] = NA
    dat$nih.cumulative.years.tr = tr(dat.nums$cumulative.years)
    dat$nih.cumulative.years.tr[is.na(dat$nih.cumulative.years.tr)] = tr(0)

    dat$nih.sum.avg.dollars.tr  = tr(dat.nums$sum.avg.dollars)
    dat$nih.sum.avg.dollars.tr[is.na(dat$nih.sum.avg.dollars.tr)] = tr(0)
    dat$nih.sum.sum.dollars.tr  = tr(dat.nums$sum.sum.dollars)
    dat$nih.sum.sum.dollars.tr[is.na(dat$nih.sum.sum.dollars.tr)] = tr(0)
    dat$nih.max.max.dollars.tr  = tr(dat.nums$max.max.dollars)
    dat$nih.max.max.dollars.tr[is.na(dat$nih.max.max.dollars.tr)] = tr(0)


    # skip
    # skip grant_activity_codes list, because captured below
    dat$has.R01.funding = ordered(dat.nums$has.R01.funding)
    dat$has.R01.funding[is.na(dat$has.R01.funding)] = 0
    #dat$has.T32.funding = ordered(dat.nums$has.T32.funding)
    #dat$has.T32.funding[is.na(dat$has.T32.funding)] = 0
    # other funding types dropped because don't occurr often enough

    # look for patterns here
    dat$has.P.funding = ordered(ifelse(grepl("P", dat.raw$grant.activity.codes), 1, 0))
    dat$has.R.funding = ordered(ifelse(grepl("R", dat.raw$grant.activity.codes), 1, 0))
    dat$has.T.funding = ordered(ifelse(grepl("T", dat.raw$grant.activity.codes), 1, 0))
    dat$has.U.funding = ordered(ifelse(grepl("U", dat.raw$grant.activity.codes), 1, 0))
    dat$has.K.funding = ordered(ifelse(grepl("K", dat.raw$grant.activity.codes), 1, 0))

    dat$dataset.in.geo.or.ae.int = dat.nums$in.ae.or.geo

    dat$nCitedBy = dat.raw$nCitedBy
    dat$nCitedBy.log = log.tr(dat$nCitedBy)
    #dim(dat)

    #save(dat, file="dat.Rdata")
    return(dat)
}

