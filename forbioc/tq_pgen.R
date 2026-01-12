

#' data available in R approach

#' run_tq runs tensorqtl on a given set of files
#' @importFrom reticulate import
#' @param plink_prefix_path character with path and file prefix to suffix pgen etc. 
#' @param expression_bed path to expression data in 'bed' format
#' @param covariates_file path to table of covariates, columns are individuals, rows are variables
#' @param prefix character string used to prefix output
#' @param write_parquet_path string used for output
#' @param condaenvpath path to proper conda environment for tensorqtl as defined in tensorqtl requirements
#' @export
#tq_pgen = function(plink_prefix_path, expression_bed, covariates_file, prefix, 
tq_pgen = function(genotype_df, variant_df, phenotype_df, phenotype_pos_df, covariates_df, prefix,
    write_parquet_path, condaenvpath = 
    "~/miniforge3/envs/tensorqtlvjc") {
 reticulate::use_condaenv(condaenvpath)
 reticulate::py_require("fastparquet")
 fp = reticulate::import("fastparquet")  # needed?
 reticulate::py_require("pyarrow")
 pd = reticulate::import("pandas")
 pdraw = reticulate::import("pandas") #, convert=FALSE)
 tor = reticulate::import("torch")
 tq = reticulate::import("tensorqtl")
 dev = tor$device("cuda")
 pgen = reticulate::import("tensorqtl.pgen") #, convert=FALSE)
 cis = reticulate::import("tensorqtl.cis")
 trans = reticulate::import("tensorqtl.trans")
 post = reticulate::import("tensorqtl.post")

# load phenotypes and covariates
#phenotype_df, phenotype_pos_df = tensorqtl.read_phenotype_bed(expression_bed)

# pdfs = tq$read_phenotype_bed(expression_bed)
# phenotype_df = pdfs[[1]]
# phenotype_pos_df = pdfs[[2]]

# covariates_df = pdraw$read_csv(covariates_file, sep='\t', index_col=0L)$T

# PLINK reader for genotypes
# pgr = pgen$PgenReader(plink_prefix_path)
# genotype_df = pgr$load_genotypes()
# variant_df = pgr$variant_df
 


 cis$map_nominal(genotype_df, variant_df, phenotype_df, phenotype_pos_df, prefix, covariates_df=covariates_df,
   write_stats=TRUE, write_top=TRUE, output_dir=write_parquet_path)
}
