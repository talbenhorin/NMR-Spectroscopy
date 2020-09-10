rm(list=ls(all=TRUE))

install.packages("speaq")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("MassSpecWavelet")
BiocManager::install("impute")

library(speaq)