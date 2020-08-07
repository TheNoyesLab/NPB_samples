## Start with this staging file to set up your analysis. 
# Source the utility functions file, which should be in the scripts folder with this file
source('scripts/meg_utility_functions.R')
source('scripts/load_libraries.R')

# Set working directory to the MEG_R_metagenomic_analysis folder and add your data to that folder
#setwd("")

# Set the output directory for graphs:
graph_output_dir = 'graphs'
# Set the output directory for statistics:
stats_output_dir = 'stats'
# In which column of the metadata file are the sample IDs stored?
sample_column_id = 'ID'

####################
## File locations ##
####################
## The files you want to use for input to this (for the MEG group analyses)
## is the AMR_analytic_matrix.csv. So you should have pulled these files from the output of the nextflow pipeline
## and you are now performing this analysis on your local machine. 

## For the AMR analysis, you will also need to download the megares_annotations.csv
## file from the MEGARes website; the annotation file must be from the same version
## of the database as the file you used in the AmrPlusPlus pipeline, i.e. the headers
## must match between the annotation file and the database file.

# Where is the metadata file stored on your machine?
amr_metadata_filepath = 'NPB_sample_metadata.csv'
amr_count_matrix_filepath = 'AMR_analytic_matrix.csv'
# Name of the megares annotation file used for this project
megares_annotation_filename = 'data/amr/megares_full_annotations_v2.0.csv'

#################################
## Microbiome - 16S or kraken? ##
#################################

# Where is the metadata file for the microbiome samples stored on your machine?
microbiome_temp_metadata_file = "NPB_sample_metadata.csv"

# If you used the AMR++ pipeline and have the kraken2 count matrix, point to the kraken file or see below for using qiime2 results.
kraken_temp_file = "kraken_analytic_matrix.csv"


###################
## User Controls ##
###################
## Hopefully, this section should be the only code you need to modify.
## However, you can look into the code in further sections if you need
## to change other, more subtle variables in the exploratory or
## statistical functions.

# The following is a list of analyses based on variables in 
# your metadata.csv file that you want
# to use for EXPLORATORY analysis (NMDS, PCA, alpha rarefaction, barplots)
# NOTE: Exploratory variables cannot be numeric. 

AMR_exploratory_analyses = list(
# Analysis Dilution
  # Description: 
  list(
    name = 'QiacubeRun',
    subsets = list(),
    exploratory_var = 'QiacubeRun',
    order = ''
  ),  
  # Analysis ID
  # Description: 
  list(
    name = 'TreatmentGroup',
    subsets = list(),
    exploratory_var = 'TreatmentGroup',
    order = c('Grp1','Grp2','Grp3')
  ),  
  # Analysis 
  # Description: 
  list(
    name = 'PenID',
    subsets = list(),
    exploratory_var = 'PenID',
    order = ''
  ),  
  # Analysis 
  # Description: 
  list(
    name = 'Group1',
    subsets = list('TreatmentGroup == Grp1'),
    exploratory_var = 'PenID',
    order = ''
  )
)



microbiome_exploratory_analyses = list(
# Analysis Dilution
  # Description: 
  list(
    name = 'QiacubeRun',
    subsets = list(),
    exploratory_var = 'QiacubeRun',
    order = ''
  ),  
  # Analysis ID
  # Description: 
  list(
    name = 'TreatmentGroup',
    subsets = list(),
    exploratory_var = 'TreatmentGroup',
    order = c('Grp1','Grp2','Grp3')
  ),  
  # Analysis 1
  # Description: 
  list(
    name = 'PenID',
    subsets = list(),
    exploratory_var = 'PenID',
    order = ''
  ),  
  # Analysis 
  # Description: 
  list(
    name = 'Group1',
    subsets = list('TreatmentGroup == Grp1'),
    exploratory_var = 'PenID',
    order = ''
  )
)
# Each analyses you wish to perform should have its own list in the following
# statistical_analyses list.  A template is provided to get you started.
# Multiple analyses, subsets, and contrasts are valid, but only one random
# effect can be used per analysis.  The contrasts of interest must have their
# parent variable in the model matrix equation.  Contrasts are named by
# parent variable then child variable without a space inbetween, for example:
# PVar1Cvar1 where the model matrix equation is ~ 0 + Pvar1.

AMR_statistical_analyses = list(
  # Analysis 1
  # Description: 
  list(
    name = 'Treatment',
    subsets = list(),
    model_matrix = '~ 0 + TreatmentGroup ',
    contrasts = list('TreatmentGroupGrp1 - TreatmentGroupGrp2','TreatmentGroupGrp1 - TreatmentGroupGrp3',
                     'TreatmentGroupGrp2 - TreatmentGroupGrp3'),
    random_effect = NA
  )
)

microbiome_statistical_analyses = list(
  # Analysis 1
  # Description: 
  list(
    name = 'Treatment',
    subsets = list(),
    model_matrix = '~ 0 + TreatmentGroup ',
    contrasts = list('TreatmentGroupGrp1 - TreatmentGroupGrp2','TreatmentGroupGrp1 - TreatmentGroupGrp3',
                     'TreatmentGroupGrp2 - TreatmentGroupGrp3'),
    random_effect = NA
  )
)


## Run the analysis on the microbiome and resistome data
source('scripts/metagenomeSeq_kraken.R')
source('scripts/metagenomeSeq_megaresv2.R')

# After running this script, these are the useful objects that contain all the data aggregated to different levels
# The metagenomeSeq objects are contained in these lists "AMR_analytic_data" and "microbiome_analytic_data"
# Melted counts are contained in these data.table objects "amr_melted_analytic" "microbiome_melted_analytic"

# Run code to make some exploratory figures, zero inflated gaussian model, and output count matrices.
## Choose one of the following scripts:
source('scripts/print_microbiome_figures.R')
source('scripts/print_AMR_figures.R')

## For ZIG model results
source('scripts/print_microbiome_ZIG_results.R')
source('scripts/print_AMR_ZIG_results.R')

# I just added this optional script to create phyloseq objects, so please excuse any errors
source('scripts/load_phyloseq_data.R')

# To further analyze your data and create custom figures, use these R objects containing counts in the "melted" format
# 
# Sample metadata
metadata
microbiome_metadata
## Resistome count data ("RequiresSNPConfirmation" counts removed)
amr_melted_analytic
amr_melted_raw_analytic
## Microbiome count data
microbiome_melted_analytic
microbiome_melted_analytic

## You can also use the following list objects which contain metagenomeSeq data:
# Resistome metagenomeSeq objects
AMR_analytic_data
# Microbiome metagenomeSeq objects
microbiome_analytic_data
# Finally, here are two phyloseq objects that we are still experimenting with:
amr.ps
kraken_microbiome.ps


##########################
# Extra code for figures #
##########################

### Start of code for figures, combine table objects to include meta
setkey(amr_melted_raw_analytic,ID) 
setkey(amr_melted_analytic,ID) 
setkey(microbiome_melted_analytic,ID)
# Set keys for both metadata files
setkey(metadata,ID)
setkey(microbiome_metadata,ID)

# Combine counts with metadata
microbiome_melted_analytic <- microbiome_melted_analytic[microbiome_metadata]
amr_melted_raw_analytic <- amr_melted_raw_analytic[metadata]
amr_melted_analytic <- amr_melted_analytic[metadata]

## 
## Relative abundance barplot with label for "low abundance classes"
##
Microbiome_total_phylum <- microbiome_melted_analytic[Level_ID=="Phylum", .(sum_phylum= sum(Normalized_Count)),by=.(Name)]
Microbiome_total_phylum[,total:= sum(sum_phylum)]
Microbiome_total_phylum[,proportion:= sum_phylum/total , by=.(Name) ]

# Identify rare phyla
length(unique(Microbiome_total_phylum$Name)) # 45 phyla
rare_phyla <- Microbiome_total_phylum[proportion < .0005 ,Name]

# 
Microbiome_phylum_by_ID_edited <- microbiome_melted_analytic[Level_ID=="Phylum", .(sum_phylum = sum(Normalized_Count),TreatmentGroup), by = .(Name,ID)]

Microbiome_phylum_by_ID_edited[(Name %in% rare_phyla), Name := 'Low abundance phyla (< 0.05%)']
#AMR_class_by_ID_edited[(Name %in% rare_class),]

Microbiome_phylum_by_ID_edited[,sample_total:= sum(sum_phylum), by=.(ID)]
Microbiome_phylum_by_ID_edited[, percentage := sum_phylum/sample_total *100 ,by=.( Name, ID) ]
Microbiome_phylum_by_ID_edited[, percentage_label:= as.character(percentage)]
Microbiome_phylum_by_ID_edited[percentage_label=='0', percentage_label := '<0.05']

# Drop extra factors 
Microbiome_phylum_by_ID_edited$Name = droplevels(Microbiome_phylum_by_ID_edited$Name)
unique(factor(Microbiome_phylum_by_ID_edited$Name))
# Check which factors you have and change the order here
#Microbiome_phylum_by_ID_edited$Name = factor(Microbiome_phylum_by_ID_edited$Name ,levels=c('Low abundance phyla (< 0.05%)',"Fusobacteria","Tenericutes","Spirochaetes","Actinobacteria", "Proteobacteria","Firmicutes","Bacteroidetes"))

Microbiome_phylum_by_ID_edited$Class <- Microbiome_phylum_by_ID_edited$Name
#AMR_class_sum[,percentage:= round(sum_phylum/total, digits=2) ,by=.(ID, Name) ] removes some with low proportions

# Plot Normalized counts
ggplot(Microbiome_phylum_by_ID_edited, aes(x = ID, y = sum_phylum, fill = Name)) + 
  geom_bar(stat = "identity") +
  facet_wrap( ~ TreatmentGroup, scales='free_x',ncol = 2) +
  #scale_fill_brewer(palette="Dark2") +
  theme(
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    strip.text.x=element_text(size=24),
    strip.text.y=element_text(size=24, angle=0),
    axis.text.x=element_blank(), #element_text(size=16, angle=20, hjust=1)
    axis.text.y=element_text(size=22),
    axis.title=element_text(size=26),
    legend.position="right",
    panel.spacing=unit(0.1, "lines"),
    plot.title=element_text(size=32, hjust=0.5),
    legend.text=element_text(size=8),
    legend.title=element_text(size=10),
    panel.background = element_rect(fill = "white")
  ) +
  #ggtitle("CSS counts -resistome composition") +
  xlab('Sample ID') +
  ylab('CSS counts')

# Plot relative abundance
ggplot(Microbiome_phylum_by_ID_edited, aes(x = ID, y = percentage, fill = Name)) + 
  geom_bar(stat = "identity") +
  facet_wrap( ~ TreatmentGroup, scales='free_x',ncol = 2) +
  #scale_fill_brewer(palette="Dark2") +
  theme(
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    strip.text.x=element_text(size=24),
    strip.text.y=element_text(size=24, angle=0),
    axis.text.x=element_blank(), #element_text(size=16, angle=20, hjust=1)
    axis.text.y=element_text(size=22),
    axis.title=element_text(size=26),
    legend.position="right",
    panel.spacing=unit(0.1, "lines"),
    plot.title=element_text(size=32, hjust=0.5),
    legend.text=element_text(size=8),
    legend.title=element_text(size=10),
    panel.background = element_rect(fill = "white")
  ) +
  #ggtitle("CSS counts -resistome composition") +
  xlab('Sample ID') +
  ylab('Relative abundance')



