# Running gene-level analysis using MAGMA software
export disease=("AD_Jansen2019" "AD_Kunkle2019" "PD_Nalls2019_proxy" "MS_Andlauer2016" "ALS_Rheenen2021" "SCZ_Trubetskoy2022")

magma \
--annotate window=10,10 \
--snp-loc g1000_eur/g1000_eur.bed \
--gene-loc gencode41_37_gene_coord.txt \
--out og_magma_annotation 

for disease_type in "${disease[@]}"
do
magma \
--bfile g1000_eur/g1000_eur \
--pval gwas_studies/munged_files/${disease_type}_munged.tsv use=SNP,P ncol=N \
--gene-annot annotation_files/og_magma_annotation.genes.annot \
--debug set-spar=tmp_snps_used \
--out og_magma_${disease_type}_gc41
done