#' Global measures to analysis reconstructed networks with different thresholds 
#' To show dependency of structural properties with the threshold: 1%, 2%, 5%, 10%, 20%
 
#'!/usr/bin/ Rscript

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Usage: script.R <group [I, II, III, IV]> <layer.name [MON]> <layer.type [FOR,INV,MUX]> <z [1:5]>", call.=FALSE)
}

group <- as.character(args[1])
layer.name <- as.character(args[2])
layer.type <- as.character(args[3])
z <- as.numeric(args[4])

# group <- "III"
# layer.name <- "MON"
# layer.type <- "MUX"
# z <- 3

library('igraph')
library('brainGraph')

cnt <- 50
data.dir <- "D:/Thesis_Ph.D/GWL_Tabriz/"
g.dir <- paste0(data.dir, "analysis/GRAPH/")
g.name <- paste0(g.dir, "GWL-", layer.name, "_", group, "_GRAPH-Surr", cnt, "_Z", z, "_", layer.type, ".RDS")
com.graph <- readRDS(g.name)
ana.dir <- "D:/Thesis_Ph.D/GWL_Tabriz/analysis/Measures/"
dir.create(ana.dir, showWarnings = F)

ga.mat <- vector()

deg <- igraph::degree(com.graph, v = V(com.graph), mode = c("all"), loops = FALSE)
ga.mat[1] <- ceiling(sum(deg)/2) #number of edges
ga.mat[2] <- ceiling(mean(deg)) #average degree
ga.mat[3] <- igraph::mean_distance(com.graph, directed = FALSE, unconnected = TRUE) #average path length
clus <- igraph::component_distribution(com.graph)
ga.mat[4] <- max(clus) #size of largest connected component
ga.mat[5] <- igraph::transitivity(com.graph, type="global") #clustering coefficiant
ga.mat[6] <- brainGraph::efficiency(com.graph, type="global") #global efficiency 
ga.mat[7] <- igraph::assortativity_degree(com.graph) #degree-degree  assortativity
wtc <- cluster_walktrap(com.graph)
ga.mat[8] <- modularity(wtc)
#modularity(com.graph, membership(wtc))
#centr_degree(com.graph, mode = c("all"),loops = F, normalized = F)

# G2 <- graph.adjacency(zz, mode = "undirected", weighted = TRUE, diag = F)#only for undirected graph
# clusterlouvain <- cluster_louvain(G2)
# plot(G2, vertex.color=rainbow(4, alpha=0.6)[clusterlouvain$membership])

nam.mat <- paste0(ana.dir, "GWL_", layer.name, "_", group, "_Global-measures-Surr", cnt, "_Z", z, "_", layer.type, ".RDS")
saveRDS(ga.mat,nam.mat)