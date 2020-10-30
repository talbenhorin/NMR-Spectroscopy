rm(list=ls(all=TRUE))

#install.packages("Rnmr1D")
library(Rnmr1D)

# Directory for example data 
# data_dir <- system.file("extra", package = "Rnmr1D")

datapath <- "NMRdata" # CHANGE ME to the directory containing your demultiplexed reverse-read fastqs

RAWDIR <- file.path(datapath,"MS_DV_OY16")

procParams <- Spec1rProcpar
procParams$LOGFILE <- ""
procParams$VENDOR <- 'bruker'
procParams$INPUT_SIGNAL <- 'fid'
procParams$LB <- 0.3
procParams$ZEROFILLING <- TRUE
procParams$ZFFAC <- 4
procParams$OPTPHC1 <- TRUE
procParams$TSP <- TRUE

metadata <- generateMetadata(RAWDIR, procParams)
ID <- 1
ACQDIR <- file.path(RAWDIR,"MS_DV_OY16-BS1")
#ACQDIR <- metadata$rawids[ID,1]
spec <- Spec1rDoProc(Input=ACQDIR, param=procParams)
plot( spec$ppm, spec$int, type="l", col="blue", 
      xlab="ppm", ylab="Intensities", 
      xlim=c( spec$pmax, spec$pmin ), ylim=c(0, max(spec$int/100)) )
legend("topleft", legend=metadata$samples[ID,1])