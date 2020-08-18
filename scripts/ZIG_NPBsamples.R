## Analysis for ZIG model 
library(statmod)

settings = zigControl(maxit=20, verbose=TRUE)

# Filter data
CSS_filtered_phylum_microbiome.metaseq <- filterData(AMR_analytic_data[[1]], present = 2)
CSS_filtered_phylum_microbiome.metaseq <- cumNorm(CSS_filtered_phylum_microbiome.metaseq) # fitZig needs this, but we overide this with "useCSSoffset=FALSE"

## Metadata variables for analysis
Treatment = pData(CSS_filtered_phylum_microbiome.metaseq)$TreatmentGroup

# Make the "zero" model with library size of the raw, filtered data
raw_filtered_phylum_microbiome.metaseq <- filterData(AMR_raw_analytic_data[[1]], present = 2)
zero_mod <- model.matrix(~0+log(libSize(raw_filtered_phylum_microbiome.metaseq)))


# Make model with "Group" variable
Treatment <- pData(CSS_filtered_phylum_microbiome.metaseq)$TreatmentGroup
design_treatment = model.matrix(~0 + Treatment)

# Make ZIG model
resAll_Class_Treatment = fitZig(obj= CSS_filtered_phylum_microbiome.metaseq, mod = design_treatment, control = settings,zeroMod=zero_mod,useCSSoffset=FALSE)
zigFit_Class_Treatment = resAll_Class_Treatment$fit
finalMod_Class_Treatment = resAll_Class_Treatment$fit$design

# Example contrasts by treatment group
contrast_Class_Treatment= makeContrasts(TreatmentGrp1-TreatmentGrp2,TreatmentGrp1-TreatmentGrp3,TreatmentGrp2-TreatmentGrp3, levels=finalMod_Class_Treatment)
res2_Class_Treatment = contrasts.fit(zigFit_Class_Treatment, contrast_Class_Treatment)
resEB_Class_Treatment = eBayes(res2_Class_Treatment )

# Extract results
fz_Class_bh <- topTable(resEB_Class_Treatment, adjust.method="BH",number = 1000)

