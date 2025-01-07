#!/bin/bash

#
#PBS  -N plac_annot_files
#
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=10:mem=150gb

module load anaconda3/personal
source activate ldsc

cd ~/ldsc

  ## Step 1: Creating an annot file 

export cell=('Microglia_interactome' 'Neuronal_interactome' 'Oligo_interactome')
export region=('plac')

for cell_type in "${cell[@]}"
do
  for region_type in "${region[@]}"
  do
    for chrom in {1..22}
    do
## Step 1: Creating an annot file
  python make_annot.py \
  --bed-file ~/HMAGMA_Protocol/required_files/PLAC/${cell_type}_${region_type}.bed \
  --bimfile 1000G_EUR_Phase3_plink/1000G.EUR.QC.${chrom}.bim \
  --annot-file annot_file/${cell_type}_${region_type}.${chrom}.annot.gz 
done
done
done

##Generating ldsc scores 

cd ~/ldsc/annot_file 

for cell_type in "${cell[@]}"
do
  for region_type in "${region[@]}"
  do
    for chrom in {1..22}
    do
		python ~/ldsc/ldsc.py \
  --l2 \
  --bfile ~/ldsc/1000G_EUR_Phase3_plink/1000G.EUR.QC.${chrom} \
  --ld-wind-cm 1 \
  --annot ${cell_type}_${region_type}.${chrom}.annot.gz \
  --thin-annot \
  --out ${cell_type}_${region_type}.${chrom} \
  --print-snps ~/ldsc/list.txt 
done
done
done

exit 0 


