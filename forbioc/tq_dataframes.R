

#' run_tq runs tensorqtl on a given set of files; fastparquet must be in condaenv
#' @importFrom reticulate import
#' @param genotype_df nvar x nsub data.frame with minor allele counts, rownames are variant ids, colnames are subject ids
#' @param variant_df nvar x 3 data.frame, colnames chrom, pos, index; rownames agree with genotype_df, index is seq_len(nrow(variant_df)-1
#' @param phenotype_df nphe x nsub data.frame with numeric assay results, colnames agree with genotype_df
#' @param phenotype_pos_df nphe x 2 data.frame, chr, pos, rownames agree with phenotype_df
#' @param covariates_df nsub x ncovar data.frame, all numeric values
#' @param prefix character(1) used as stem for output
#' @param write_parquet_path path to folder used for output
#' @export
#tq_pgen = function(plink_prefix_path, expression_bed, covariates_file, prefix, 
tq_dataframes = function(genotype_df, variant_df, phenotype_df, phenotype_pos_df, covariates_df, prefix,
    write_parquet_path) {
 reticulate::py_require("tensorqtl")
 reticulate::py_require("pandas")
 reticulate::py_require("pandas_plink")
 reticulate::import("pandas_plink") # needed?
 reticulate::py_require("torch")
 reticulate::py_require("pyarrow")
 reticulate::py_require("fastparquet")
 fp = reticulate::import("fastparquet")  # needed?
 reticulate::py_require("pyarrow")
 pd = reticulate::import("pandas")
 tor = reticulate::import("torch")
 tq = reticulate::import("tensorqtl")
 dev = tor$device("cuda")
 cis = reticulate::import("tensorqtl.cis")

 if (isTRUE(options()$verbose))  print(reticulate::py_config())

 cis$map_nominal(genotype_df, variant_df, phenotype_df, phenotype_pos_df, prefix, covariates_df=covariates_df,
   write_stats=TRUE, write_top=TRUE, output_dir=write_parquet_path)
}
