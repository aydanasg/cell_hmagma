

module load anaconda3/personal
source activate ldsc


export disease=('AD_Jan' 'AD_Kunkle' 'PD_nalls_no23_r_py_2' 'LBD_Chia' 'MS_Andlauer' 'ALS_rheenen' 'SCZ_pgc3info9' 'SCZ_PardinasInfo9')
export region=('promoter_enhancers_bin' 'promoter_enhancers' 'enhancers_bin' 'enhancers' 'promoters_bin' 'promoters')

for disease_type in "${disease[@]}"
do
	for region_type in "${region[@]}"
	do
python ~/ldsc/ldsc.py \
--h2 ~/ldsc/GWAS_munge/${disease_type}_ldsc.sumstats.gz \
--ref-ld-chr ~/ldsc/1000G_Phase3_baselineLD_v2.2_ldscores/baselineLD.,~/ldsc/annot_file/Microglia_interactome_plac_${region_type}_v2.,~/ldsc/annot_file/Neuronal_interactome_plac_${region_type}_v2.,~/ldsc/annot_file/Oligo_interactome_plac_${region_type}_v2. \
--out ~/ldsc/heritability/${disease_type}_plac_${region_type}_v6 \
--overlap-annot  \
--frqfile-chr ~/ldsc/1000G_Phase3_frq/1000G.EUR.QC. \
--w-ld-chr ~/ldsc/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--print-coefficients
done
done

exit 0 

