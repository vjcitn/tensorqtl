library(reticulate)
library(biocXqtl)
library(SummarizedExperiment)
xexp2dfs = function(xexp) {
  stopifnot(inherits(xexp, "XqtlExperiment"))
  phenotype_df = as.data.frame(as.matrix(assay(xexp)))
  rownames(phenotype_df) = names(rowRanges(xexp))
  colnames(phenotype_df) = colnames(xexp)
  phenotype_pos_df = data.frame(chr=seqnames(rowRanges(xexp)), pos=start(rowRanges(xexp)))
  rownames(phenotype_pos_df) = rownames(xexp)
  cal = getCalls(xexp)
  genotype_df = as.data.frame(data.matrix(mcols(cal)))
  rownames(genotype_df) = names(cal) # colnames should be good
  variant_df = data.frame(chrom=seqnames(cal), pos=IRanges::start(cal)) #, index=seq_len(length(cal))-1L)
  rownames(variant_df) = rownames(genotype_df)
  covariates_df = as.data.frame(colData(xexp))
  r2p = function(x) r_to_py(x, convert=TRUE)
  list(phenotype_df = r2p(phenotype_df), phenotype_pos_df = r2p(phenotype_pos_df),
    genotype_df = r2p(genotype_df), variant_df = r2p(variant_df), covariates_df = r2p(covariates_df) )
}
  
