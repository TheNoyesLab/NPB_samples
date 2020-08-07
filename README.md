# NPB metagenomic sequencing samples analyzed with AMR++


# View results using "binder" and jupyter notebooks

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TheNoyesLab/NPB_samples/4557ca8808056b479ae03cb265229e9160702a8a?filepath=Jupyter_metagenomic_analysis.ipynb)


------------

How to access data on MSI

```
ssh tanxx606@login.msi.umn.edu
ssh mesabi

# Main lab directories:
/home/noyes046/shared/ 

# Currently, the NPB samples and results are in a temporary allocation here:
/tempalloc/noyes042/NPB_samples/NPB_MEGARes_kraken_output

# Two computing node options if you want to run something. Use "screen" or "nohub" to run commands without the scheduler.
ssh cn4201 # Smaller, main computing cluster (no qsub)
ssh cn1107 # Large computing cluster (no qsub)
```

Raw sample data release and new location:
```
# Data release was as total of 232 samples (Stored here for 5 years)
# 47 samples
/home/noyes046/data_release/umgc/novaseq/200305_A00223_0336_AH2WFWDSXY/Noyes_Project_011_Pool_1
# 46
/home/noyes046/data_release/umgc/novaseq/200305_A00223_0336_AH2WFWDSXY/Noyes_Project_011_Pool_5
# 47
/home/noyes046/data_release/umgc/novaseq/200325_A00223_0346_BH75VWDSXY/Noyes_Project_011_Pool_2
# 46
/home/noyes046/data_release/umgc/novaseq/200226_A00223_0330_BH2WT2DSXY/Noyes_Project_011_Pool_3
# 46
/home/noyes046/data_release/umgc/novaseq/200226_A00223_0330_BH2WT2DSXY/Noyes_Project_011_Pool_4

# New location with symlinks
# 216 NPB samples, 16 amazonian k9 samples
/tempalloc/noyes042/NPB_samples/samples/
```

## For further analysis, use these nonhost samples:
```
# Do any further analysis with these samples
/tempalloc/noyes042/NPB_samples/NPB_nonhost_sus_scrofa/NonHostReads/
```

## For statistical analysis of the microbiome and resistome, use the results here:
```
/tempalloc/noyes042/NPB_samples/NPB_MEGARes_kraken_output

# I also moved a copy of the count tables to this directory for storage:
/home/noyes046/shared/projects/NPB_resistome_followon/NPB_MEGARes_results/
```



