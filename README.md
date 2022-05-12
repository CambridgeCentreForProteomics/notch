# Orbitrap notch
A study of the 'notch' in Orbitrap TMT reporter ion intensities.

Now published in ACS Measurement Science Au: https://pubs.acs.org/doi/10.1021/acsmeasuresciau.1c00053

###### Dependencies:
- R >= 4.0.3
- tidyverse (CRAN)
- ggbeeswarm (CRAN)
- gtools (CRAN)
- MSnbase (Bioconductor)
- limma (Bioconductor)
- biobroom (Bioconductor)
- rawDiag (https://github.com/fgcz/rawDiag)
- camprotR (https://github.com/CambridgeCentreForProteomics/camprotR)

## Study components
1.  [Re-analysis of published datasets](reanalysis_published) to examine:
    - What proportion of PRIDE Orbitrap submissions used Tune < 3.0?
    - Can sub-notch values be removed by average S/N filtering?
    - What happens to notch values? 
2. [Analysis of a benchmark human:yeast dataset](benchmark) to examine the impact of the notch/sub-notch region on :
    - PSM/peptide/Protein-level fold-change estimates
    - Detection of differentially abundant peptides/proteins

Both analysis subdirectories have the same structure:
- *raw*: PSM-level inputs
- *shared files*: Reference and cRAP fasta files
- *notebooks*: Analyses, with order indicated by prefix     
- *results*: Intermediate and final outputs from notebooks and plots
