## ------------------------------------------------------------------------
## The following only needs to be done once:
## 
## get the biocLite installer script:
source("http://www.bioconductor.org/biocLite.R") 
## now install the DESeq2 package:
biocLite("DESeq2")
## 
## ------------------------------------------------------------------------

## If DESeq2 has been installed, you first have to load it into the workspace:
library(DESeq2)

## Download the 'Mouse Neural Stem Cell data from Liu et al.' (GSE65747.rda)
## data from the course home page.  This data has already been prepared
## by us. It contains just one big data object called 'dds'. Load it as follows:
load('GSE65747.rda')

## If you can't find the file you just downloaded you can use the
## function file.choose(). After picking your file it just returns the
## full path name as a string. If you assign that string you can
## subsequently use it

rda.file <- file.choose()               # '<-' assigns the right-hand side to the left-hand side

rda.file                                # typing in the name of the object displays the content

load(rda.file)                          # now use it to load the actual data

## The dds object is a "DESeqDataSet", which is essentially a big table
## with the counts per gene and per sample. In addition, it contains
## 'metadata', i.e.  the details of the genes (rows) and samples
## (columns).  You can get a quick overview of the data by just typing in the name
## of the object in the R console.

## 1. How many genes and how how many samples are contained in the object?

## Looking up (meta)data inside the dds object is done using the
## functions 'counts' for the count data, 'colData' for information per
## column (such as which experimental group a sample belongs to), and
## 'mcols' (or: 'values') for the metadata on genes.

## Have a look at the counts data:

head(counts(dds))                       # head() gives the first rows
summary(counts(dds))                    # summary statistics per column

## 2. Which sample had most, and which had fewest mapped reads?

## You can look up the exact counts by specifying the gene (row) and/or
## sample (column) in matrix notation. E.g. look up gene number 1000, in sample 3:

counts(dds[1000,3])

## To specify a numeric range, use the 'colon operator'. E.g., to show
## counts for gene gene 'number 101 up to 105', do
counts(dds[101:105, 2:4])

## But it's better to select rows and colums by name (they not always present, though)
counts(dds['Smap1', 2:4])

## If, inside the square brackets, you leave a dimension empty, it means: all of that dimension
counts(dds['Hdhd2',    ])                  # note the 'comma-nothing': we are selecting *all columns* of row 'Hdhd2'

## 3. Is gene 'Malat1' abudant or not? 

## 4. What is the grouping of samples? Use the colData() function. How
## many knock-out and how many wild-type (wt) genotypes are there?

## Have a look at the gene metadata, e.g.:

mcols(dds['Rp1',1])

## 5. What information is given per gene? On what chromosome does gene Vcp lie?

## Let's look at the distribution of reads counts per gene of a sample, e.g. the first one (i.e.: column 1)
## 6. What is the highest expression? Use the max() or the summary(function)

## To find out what gene has this maximum expresssion, use the
## which.max() function.  It gives the row number where the maximum
## occurs. Easiest to do it in two steps:

maximum.at <- which.max(counts(dds[   , 1])) # note the 'nothing-comma': selects the maximum *all rows* of colum 1
counts(dds[ maximum.at , 1])

## 7. Which gene is this? Is the same gene the maximally expressed in each sample?

## 8. What are the counts for the Smchd1 gene in the wild-type samples, and what are they
## in the Smchd1-null samples? Why?

## 9. Use the mean() function to find the mean of the counts in sample 1, and assign it to a variable

## Often, functions can take optional arguments. For example, if your
## data contains 'NA' (not available) values, you can instruct mean() to
## remove them by specifying this additional argument as follows:

mean(mydata,  na.rm=TRUE) # TRUE and FALSE are so-called logical values

## (for default values of optional arguments, see the functions documentation)

## To get an impression of the distribution of reads counts of sample 1,
## simply pass it to the hist() function. What does it look like?

## To see more details you will have to specify a larger number of
## histogram bins by specifying an additional nclass argument; try this.

## 10. To 'zoom in', e.g. to just show the bit between 0 and twice the
## mean of the the read counts (you just saved that in a variable,
## right?), you have to specify another optional argument, namely
## xlim=c(lower, upper). Try this (and adjust the nclass argument if
## needed).

## Now let's compare the distributions of all the data sets. An easy way
## to do that is the boxplot() function.  When given a table such as
## returned by counts(dds) it will do a boxplot for each of the columns
## in the matrix.
## 
## 11.  Do this, and supply an ylim-argument to make differences between
## the samples clearer. (Make sure that the ylim argument is given to
## the hist() function, not to the counts function!)  Which of the
## samples is the 'odd one out', based on this? Is it a knock-out or wt
## genotype?

