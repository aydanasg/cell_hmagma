# Running gene-level analysis using MAGMA software on H-MAGMA annotation files 
export cell=('Microglia_interactome' 'Neuronal_interactome' 'Oligo_interactome')
export disease=("AD_Jansen2019" "AD_Kunkle2019" "PD_Nalls2019_proxy" "MS_Andlauer2016" "ALS_Rheenen2021" "SCZ_Trubetskoy2022")

for cell_type in "${cell[@]}"
do
	for disease_type in "${disease[@]}"
	do
/rds/general/user/aa19618/home/HMAGMA/HMAGMA_system/magma \
--bfile  g1000_eur/g1000_eur \
--pval gwas_studies/munged_files/${disease_type}_munged.tsv use=SNP,P ncol=N \
--gene-annot annotation_files/${cell_type}.transcript.annot \
--debug set-spar=tmp_snps_used \
--out ${cell_type}_${disease_type}_gc41 
done
done

