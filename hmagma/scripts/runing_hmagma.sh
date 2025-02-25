#!/bin/bash

#
#PBS  -N hmagma_original_v3.error
#PBS -o hmagma_original_v3.output.log
#
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=60:mem=160gb

module load anaconda3/personal
source activate base


export cell=('Microglia_interactome' 'Neuronal_interactome' 'Oligo_interactome')

export disease=("AD_Jansen2019" "AD_Kunkle2019" "PD_Nalls2019_proxy" "MS_Andlauer2016" "ALS_Rheenen2021" "SCZ_Trubetskoy2022" "Longevity_Deelan2019_90th")


for cell_type in "${cell[@]}"
do
	for disease_type in "${disease[@]}"
	do
/rds/general/user/aa19618/home/HMAGMA/HMAGMA_system/magma \
--bfile  /rds/general/user/aa19618/home/HMAGMA/g1000_eur/g1000_eur/g1000_eur \
--pval /rds/general/user/aa19618/projects/epinott/live/user_analysed_data/Aydan/vasculature_disease_epi/gwas_studies/munged_files/${disease_type}_munged.tsv use=SNP,P ncol=N \
--gene-annot /rds/general/user/aa19618/home/HMAGMA_Protocol/annotation_files/${cell_type}.transcript.annot \
--debug set-spar=tmp_snps_used \
--out /rds/general/user/aa19618/home/HMAGMA_Protocol/HMAGMA_output_v3/original/${cell_type}_${disease_type}_gc41 
done
done


exit 0

