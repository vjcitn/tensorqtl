


#' run_tq runs tensorqtl on a given set of files; fastparquet must be in condaenv
#' @importFrom reticulate import py_require
#' @param xexp XqtlExperiment instance
#' @param variant_df nvar x 3 data.frame, colnames chrom, pos, index; rownames agree with genotype_df, index is seq_len(nrow(variant_df)-1
#' @param phenotype_df nphe x nsub data.frame with numeric assay results, colnames agree with genotype_df
#' @param phenotype_pos_df nphe x 2 data.frame, chr, pos, rownames agree with phenotype_df
#' @param covariates_df nsub x ncovar data.frame, all numeric values
#' @param prefix character(1) used as stem for output
#' @param write_parquet_path path to folder used for output
#' @export
tq_xexp = function(xexp, prefix,
    write_parquet_path) {
 reticulate::py_require("tensorqtl")
 reticulate::py_require("rpy2")
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

 conv = xexp2dfs(xexp)

 cis$map_nominal(conv$genotype_df, conv$variant_df, conv$phenotype_df, 
    conv$phenotype_pos_df, prefix, covariates_df=conv$covariates_df,
   write_stats=TRUE, write_top=TRUE, output_dir=write_parquet_path)
}
