library(tximport)
library(DESeq2)
library(readr)
library(dplyr)
library(ggplot2)
library(openxlsx)

# === Load Sample Metadata ===
samples <- read_tsv("config/samples.tsv")
samples <- as.data.frame(samples)
rownames(samples) <- samples$sample

# === Import Salmon Quantifications ===
files <- file.path("results/salmon", samples$sample, "quant.sf")
names(files) <- samples$sample
txi <- tximport(files, type = "salmon", txOut = TRUE)

# === DESeq2 Analysis ===
dds <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ condition)
dds <- DESeq(dds)

# === Normalized Counts ===
norm_counts <- counts(dds, normalized = TRUE)
write.csv(norm_counts, file = "results/normalized_counts.csv")

# === PCA Plot ===
vsd <- vst(dds, blind = FALSE)
pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pca_data, "percentVar"))

p <- ggplot(pca_data, aes(PC1, PC2, color = condition)) +
  geom_point(size = 4) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  theme_minimal()

ggsave("results/pca_plot.pdf", plot = p, width = 6, height = 5)

# === Pairwise DGE + Volcano Plots + Excel ===
conditions <- unique(samples$condition)
comparisons <- combn(conditions, 2, simplify = FALSE)

for (comp in comparisons) {
  res <- results(dds, contrast = c("condition", comp[2], comp[1]))
  df <- as.data.frame(res) %>%
    mutate(gene = rownames(.)) %>%
    arrange(padj)

  # Save CSV
  write.csv(df, file = paste0("results/dge_results_", comp[2], "_vs_", comp[1], ".csv"), row.names = FALSE)

  # Save Excel
  wb <- createWorkbook()
  addWorksheet(wb, "DGE Results")
  writeData(wb, sheet = 1, df)
  saveWorkbook(wb, paste0("results/dge_results_", comp[2], "_vs_", comp[1], ".xlsx"), overwrite = TRUE)

  # Volcano Plot
  df$significant <- ifelse(df$padj < 0.05 & abs(df$log2FoldChange) > 1, "yes", "no")
  v <- ggplot(df, aes(log2FoldChange, -log10(padj))) +
    geom_point(aes(color = significant), alpha = 0.5) +
    scale_color_manual(values = c("no" = "gray", "yes" = "red")) +
    theme_minimal() +
    ggtitle(paste("Volcano:", comp[2], "vs", comp[1]))

  ggsave(paste0("results/volcano_", comp[2], "_vs_", comp[1], ".pdf"), plot = v, width = 6, height = 5)
}
