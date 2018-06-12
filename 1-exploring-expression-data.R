## The following only needs to be done only once (and may in fact already
## be installed).
## Get the biocLite installer script ...
## source("http://www.bioconductor.org/biocLite.R")

## ... and use it to install the DESeq2 package:
## biocLite("DESeq2")

## If DESeq2 has been installed, you can now load it into the current workspace:
## (this is not done automatically)
library(DESeq2)


## Load the 'Mouse Neural Stem Cell data from Liu et al.' (GSE65747.rda)
## This data has already been prepared
## by us. It contains just one big data object called 'dds'. Load it as follows:
load('GSE65747.rda')

## What is the name of the object you just loaded (use the ls() function)
ls()

## What is the type of this object? (use the is() or the class() function)
is(dds)
class(dds)

## The object is a "DESeqDataSet", which is essentially a big table with
## the counts per gene and per sample. In addition, it contains
## 'metadata', i.e.  the details of the genes (rows) and samples
## (columns).  You can get a quick overview of the data by just typing
## in the name of the object in the R console. How many genes and how
## how many samples are contained in the object?
dds

## Looking up (meta)data inside the dds object is done using the
## functions counts() for the actual counts, function colData() for
## information per column (such as which experimental group a sample
## belongs to), and mcols() or its synonym values() for the metadata on genes.
## What metadata is there per sample?
colData(dds)

## What metadata is available for each gene?
mcols(dds)

## Let's have a look at the actual counts. That is too much to print out,
## so use the head() function to limit the
## output, and/or summary() for a summary:
head(counts(dds))                       # head() gives the first rows
summary(counts(dds))                    # summary statistics per column

## 2. Which sample had most, and which had fewest mapped reads?

## You can look up the exact counts by specifying the gene (row) and/or
## sample (column) in matrix notation. E.g. look up gene number 1000, in
## sample 3:
counts(dds[1000,3])

## To specify a numeric range, use the 'colon operator'. E.g., to show
## the counts for gene number 101 to number 105' for samples 2 and 3, do:
counts(dds[101:105, 2:3])

## But it's better to select rows and colums by name (they may not always
## present, though):
counts(dds['Smap1', 2:4])

## If, inside the square brackets, you leave one 'dimension' empty, it
## means: all of that dimension. E.g., if you 
counts(dds['Hdhd2',    ])
## note the 'comma-nothing'
## 3. Is gene 'Malat1' anbudant or not? 

## To refer to a few columns by name we have to use a vector of
## column names (which are strings). The vector is built using the c() function:
counts(dds['Hdhd2',   c('A', 'F')  ])

## 4. Which sample contains what? The colData() function will extract
## this so-called 'meta data' from the expression data object; take a
## look at the 'sample' column. How knock-out and how many wild-type
## (wt) genotypes are there?

## Have a look at the gene metadata, e.g.:

mcols(dds['Rp1',])

## 5. What information is given per gene? On what chromosome does gene
## Vcp lie?

## 6. Let's look at the distribution of reads counts per gene of a
## sample, e.g. the first one (i.e.: column 1). What is the highest
## expression? Use the max() or the summary() function

## To find out what gene has this maximum expresssion, use the
## which.max() function.  It gives the row number where the maximum
## occurs. Easiest to do it in two steps:

maximum.at <- which.max(counts(dds[   , 1])) # note the 'nothing-comma': selects the maximum *all rows* of colum 1
counts(dds[ maximum.at , 1])

## 7. Which gene is this? Is the same gene the maximally expressed in
## each sample?

## 8. What are the counts for the Smchd1 gene in the wild-type samples,
## and what are they in the Smchd1-null samples? Why?

## 9. Use the mean() function to find the mean of the counts in sample 1
## and assign it to a variable

## Many functions can take optional arguments. For example, if your data
## contains 'NA' (not available) values, you can instruct mean() to
## remove them before the actual calculation by specifying the na.rm
## argument (see documentation) as follows:

mean(mydata,  na.rm=TRUE) # TRUE and FALSE are so-called logical values

## (for default values of optional arguments, see a function's
## documentation)

## 10. To get an impression of the distribution of read counts of sample 1,
## simply pass it to the hist() function. What does it look like?
## To see more details you will have to specify a larger number of
## histogram bins by specifying an additional nclass argument; try this.

## 11. To 'zoom in', e.g. to just show the bit between 0 and twice the
## mean of the the read counts (you just saved that in a variable,
## right?), you have to specify another optional argument, namely
## xlim=c(lower, upper). Try this (and adjust the nclass argument if
## needed).

## Now let's compare the distributions of all the data sets. An easy way
## to do that is the boxplot() function.  When given a table such as
## returned by counts(dds) it will do a boxplot for each of the columns
## in the matrix.

boxplot(counts(dds))

## 12.  Do this, and supply an ylim-argument to make differences between
## the samples clearer. (Make sure that the ylim argument is given to
## the hist() function, not to the counts function!)  Which of the
## samples is the 'odd one out', based on this? Is it a knock-out or wt
## genotype?

boxplot(counts(dds), ylim=c(0,2000))
