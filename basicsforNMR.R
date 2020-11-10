rm(list=ls(all=TRUE))

#install.packages("Rnmr1D")
library(Rnmr1D)

# Directory for example data 
#data_dir <- system.file("extra", package = "Rnmr1D")
#RAWDIR <- file.path(data_dir, "CD_BBI_16P02")

datapath <- "~/NMR-Spectroscopy"
RAWDIR <- file.path(datapath,"NMRdata/MS_DV_OY16")
samplefile <- file.path(datapath, "NMRdata/Samples.txt")
samples <- read.table(samplefile, sep="\t", header=T,stringsAsFactors=FALSE)

procParams <- Spec1rProcpar
procParams$LOGFILE <- ""
procParams$VENDOR <- 'bruker'
procParams$INPUT_SIGNAL <- 'fid'
procParams$LB <- 0.3
procParams$ZEROFILLING <- TRUE
procParams$ZFFAC <- 4
procParams$OPTPHC1 <- TRUE
procParams$TSP <- TRUE

metadata <- generateMetadata(RAWDIR, procParams,samples)
ID <- 1
ACQDIR <- metadata$rawids[ID,1]
spec <- Spec1rDoProc(Input=ACQDIR, param=procParams)
plot( spec$ppm, spec$int, type="l", col="blue", 
      xlab="ppm", ylab="Intensities", 
      xlim=c( spec$pmax, spec$pmin ), ylim=c(0, max(spec$int/100)) )
legend("topleft", legend=metadata$samples[ID,1])