#'!/usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Usage: script.R <group [I, II, III, IV]> <layer.name [MON]> <layer.type [INV]> <z [1:5]>", call.=FALSE)
}

group <- as.character(args[1])
layer.name <- as.character(args[2])
layer.type <- as.character(args[3])
z <- as.numeric(args[4])

Z_Score <- c(2.576, 2.326, 1.96, 1.645, 1.28) #z:1,2,5,10,20%
data.dir <- "D:/Thesis_Ph.D/GWL_Tabriz/"
z.dir <- paste0(data.dir, "analysis/")
dir.create(z.dir, showWarnings = F)
z.dir <- paste0(data.dir, "analysis/ZSCORE/")
dir.create(z.dir, showWarnings = F)
run.dir <- paste0("D:/Thesis_Ph.D/GWL_Tabriz/modeling/", group, "/",layer.name, "/")
sur <- 0
cormat.name <- paste0(run.dir, "CCM_GWL_CORMAT-sur", sur, "_", layer.type, ".RDS")

if(!file.exists(cormat.name)){
  cat(paste(" MISSING! Correlation matrix","\n"))
}else{
  cor.mat <- readRDS(cormat.name)
}

N <- dim(cor.mat)[2]
Surr <- 50
mu.mat <- matrix(0, N, N)
sig.mat <- matrix(0, N, N)
z_score <- matrix(0, N, N)
cnt.surr <- 0

for (i in 1:N) {
  for (j in 1:N) {
    
    rho.mean <- cor.mat[i,j]
    
    #keep the informative entries
    if(rho.mean < 0 || is.na(rho.mean) || i==j){
      cor.mat[i,j] <- 0
    }
    
  }
}

for (sur in 1:Surr) {
  cormat.name.surr <- paste0(run.dir, "CCM_GWL_CORMAT-sur", sur, "_", layer.type, ".RDS")
  cor.mat.surr <- readRDS(cormat.name.surr)
  
  ### For the CCM method, this part needs to be active
  for (i in 1:N) {
    for (j in 1:N) {
      
      rho.mean <- cor.mat.surr[i,j]
      
      #keep the informative entries
      if(rho.mean < 0 || is.na(rho.mean) || i==j){
        cor.mat.surr[i,j] <- 0
      }
      
    }
  }
  
  mu.mat <- mu.mat + cor.mat.surr
  sig.mat <- sig.mat + cor.mat.surr^2
  
  #this counter allows to normalize correctly (accounting for possible missing files)
  cnt.surr <- cnt.surr + 1
  cat(paste("Surr", Surr, "/", cnt.surr, "\n"))
}

c.ave <- mu.mat/cnt.surr
c.std <- sqrt( (sig.mat/cnt.surr) - (c.ave)^2 )

z_score <- (cor.mat - c.ave)/c.std

for (i in 1:N) {
  for (j in 1:N) {
    
    rho.mean <- z_score[i,j]
    
    #keep the informative entries
    if(rho.mean < 0 || is.na(rho.mean) || i==j){
      z_score[i,j] <- 0
    }
    
  }
}
saveRDS(z_score, paste0(z.dir, "GWL-", layer.name, "_", group, "_ZSCORE-Surr", cnt.surr, "_", layer.type, ".RDS"))

z_score_MON <- readRDS(paste0(z.dir, "GWL-", layer.name, "_", group, "_ZSCORE-Surr", cnt.surr, "_FOR", ".RDS"))

for (i in 1:N) {
  for (j in 1:N) {
    
    if ( z_score_MON[i,j] < Z_Score[z] || z_score[i,j] < Z_Score[z] ) {
      z_score[i,j] <- 0
    }
    
  }
}

#Save results
saveRDS(z_score, paste0(z.dir, "GWL-", layer.name, "_", group, "_ZSCORE-Surr", cnt.surr, "_Z", z, "_MUX.RDS"))
