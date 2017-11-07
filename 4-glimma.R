## The following is a bit of an encore to show some of capabilities of R
## and especially of the shiny library, as used in the Glimma
## package. This provides functions that create interactive HTML pages
## for exploring RNA expression data. However, the standard version of that
## package contains an error that makes it fail for our data. Therefore,
## we need to install the lastest version:

## ------------------------------------------------------------------------
## The following needs to be done only once:
biocLite("devtools")              # install the devtools, needed for installing things from GitHub
library(devtools)                 # load the library
install_github("Shians/Glimma")   # Now install the Glimma development version ...
## 
## ------------------------------------------------------------------------

library(Glimma)                   # load the Glimma library

groups <- colData(dds)[ ,'group']

## following genes will be shown in red:

status <- as.numeric(res[, 'padj'] < 0.01) # (as.numeric converts TRUE/FALSE to 1/0)

## use separate colors per sample in the counts-per-gene plot (topright
## panel): blues for WT, reds for knock-out:

cols <- c('blue', 'LightBlue', 'red', 'pink', 'DarkRed', 'DarkBlue')

## Columns to show in table:

display <- c("GeneID", "GeneName", "logFC")

## interactive MA plot:

glMDPlot(res,
         status=status,
         counts=counts(dds),
         samples=colnames(dds),
         sample.cols=cols,
         anno=mcols(dds),
         groups=groups,
         display.columns=display)

## If all is well, this will create an interactive HTML page and send it
## to your browser.  Most elements in the plots and table are
## (double-)clickable or hoverable, and will show/highlight the various
## aspects of the selected thing in all three plots.

