#'!/usr/bin/ Rscript

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Usage: script.R <group [I, II, III, IV]> <layer.name [MON]> <layer.type [FOR,INV,MUX]> <z [1:5]>", call.=FALSE)
}

group <- as.character(args[1])
layer.name <- as.character(args[2])
layer.type <- as.character(args[3])
z <- as.numeric(args[4])

library('igraph')

data.dir <- "D:/Thesis_Ph.D/GWL_Tabriz/"
g.dir <- paste0(data.dir, "analysis/GRAPH/")
dir.create(g.dir, showWarnings = F)
z.dir <- paste0(data.dir, "analysis/ZSCORE/")
cnt <- 50 
if (layer.type=="MUX"){
  z.name <- paste0(z.dir, "GWL-", layer.name, "_", group, "_ZSCORE-Surr", cnt, "_Z", z, "_", layer.type, ".RDS")
} else {
  z.name <-  paste0(z.dir, "GWL-", layer.name, "_", group, "_ZSCORE-Surr", cnt, "_", layer.type, ".RDS")
}

z.score <- readRDS(z.name)
Z_Score <- c(2.576, 2.326, 1.96, 1.645, 1.28) #z:1,2,5,10,20%

g.name <- paste0(g.dir, "GWL-", layer.name, "_", group, "_GRAPH-Surr", cnt, "_Z", z, "_", layer.type, ".RDS")
graph_z_score <- igraph::graph.adjacency(z.score, weighted=T, mode="directed")
graph_z_scoreMo <- igraph::delete.edges(graph_z_score, E(graph_z_score)[weight < Z_Score[z]])

saveRDS(graph_z_scoreMo, g.name)