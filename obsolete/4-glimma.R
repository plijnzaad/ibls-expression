## The following is a bit of an encore to show some of capabilities of R
## and especially of the shiny library, as used in the Glimma
## package. This provides functions that create interactive HTML pages
## for exploring RNA expression data. However, the standard version of that
## package contains an error that makes it fail for our data. Therefore,
## we need to install the lastest version:

## ------------------------------------------------------------------------
## The following needs to be done only once:
##
## Get the biocLite installer script ...
source("http://www.bioconductor.org/biocLite.R")
## ... and use it to install the Glimma library:
biocLite("Glimma")
## ------------------------------------------------------------------------
library(Glimma)                   # load the Glimma library into the current session

groups <- colData(dds)[ ,'group']
## dds2 <- dds[ rowSums(counts(dds)) >1 ,  ]
##n## following genes will be shown in red:
## dds2 <- DESeq(dds2)

res <- results(dds, contrast=c("group", "Smchd1-null", "WT"))

padj <- res[, 'padj']
padj[ is.na(padj) ] <- 1
## status <- as.numeric(res[, 'padj'] < 0.01) # (as.numeric converts TRUE/FALSE to 1/0)
status <- res[, 'padj'] < 0.01 # (as.numeric converts TRUE/FALSE to 1/0)

## use separate colors per sample in the counts-per-gene plot (topright
## panel): blues for WT, reds for knock-out:

colors <- c('blue', 'LightBlue', 'red', 'pink', 'DarkRed', 'DarkBlue')

## Columns to show in table (

display <- c("GeneID", "GeneName", "logFC")

## interactive MA plot:

glMDPlot(res,
         status=as.numeric(status),
         counts=1+counts(dds),
         samples=colnames(dds),
         sample.cols=colors,
         anno=mcols(dds),
         groups=groups,
         display.columns=display,
         side.log=TRUE)

## If all is well, this will create an interactive HTML page and send it
## to your browser.  Most elements in the plots and table are
## (double-)clickable or hoverable, and will show/highlight the various
## aspects of the selected thing in all three plots.

