
## The following only needs to be done only once (and may in fact already
## be installed). That's why the code ('source(...)') is turned into a
## comment, using '#' (like the very text you are reading now!)
## Get the biocLite installer script ...
## source("http://www.bioconductor.org/biocLite.R")

## ... and use it to install the DESeq2 package (again, this already be installed)
## biocLite("DESeq2")

## We will now load this package into your current workspace
## But first it's useful to know how to get help. 
## That is done using a question mark in front of the thing
## you need help on:

?library

## This documentation often contains an example section. This is useful
## in itself, but the example can also be run using the example() function

example(load)

## If DESeq2 is installed, you can now load it into the current workspace:

library(DESeq2)

## Let's load the 'Mouse Neural Stem Cell data from Liu et al.' (GSE65747.rda)
## This data has already been prepared by us. It contains just one big data 
## object called 'dds'. Load it as follows:

load('GSE65747.rda')

## What is the name of the object you just loaded (use the ls() function)?

ls()

## What is the type of this object? (use the class() or the is() function)

class(dds)
is(dds)

## The object is a 'DESeqDataSet', which is essentially a big table with
## the read counts per gene and per sample, but also contains the
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

## Have a look at the actual counts. Use the head() function to limit the
## output, and summary() for a summary.

head(counts(dds))                       # head() gives the first rows
summary(counts(dds))                    # summary statistics per column

## 2. Which sample had most, and which had fewest mapped reads?

## You can look up the exact counts by specifying the gene (row) and
## sample (column) in matrix notation, using square brackets and a comma.
## E.g. look up gene number 1000, in
## sample 3:

counts(dds[1000,3])

## To specify a numeric range, use the 'colon operator'. E.g., to show
## the counts for gene number 101 to number 105' for samples 2 and 3, do:

counts(dds[101:105, 2:3])

## But it's clearer to select rows and colums by rowname and/or column name (if
## they are present; not all matrices have row and/or column names)

counts(dds['Smap1', 'A'])

## The thing before the comma is the row index and it selects the rows
## The thing after the comma is the column index and selects the columns
## If you leave an index unspecified, it will select everything of that dimenstion

counts(dds['Hdhd2',    ]) ## note the 'comma-nothing'!

## Is gene 'Malat1' anbudant or not?

## You can also use this to lookup the metadata, e.g.:

mcols(dds['Rp1',])

## What information is given per gene? On which chromosome does gene 'Vcp' lie?

## What are the maximum and mininum counts for each of the samples? 
## Use the min(), max() and/or summary() functions, e.g.

min(counts(dds[, 'B']))

## Likewise, you can obtain the usual statistical functions using
## mean(), median(), var(), sd(), sum() etc. Try this

## You can 'save' values in variables using assignment, which looks like this

Amean <- mean(counts(dds[,'A']))

## What are the counts for the Smchd1 gene in the wild-type samples,
## and what are they in the Smchd1-null samples? Why? 

## To get an impression of the distribution of read counts of a sample,
## simply pass it to the hist() function.

hist(counts(dds[,'C']))

## To see more details you will have to specify a larger number of
## histogram bins by specifying an additional nclass=SOMENUMBER argument
## to the hist() function. This looks like
hist(counts(dds[,'C']),  nclass=100)

## To 'zoom in', e.g. to just show the bit between 0 and twice the
## mean of the the read counts (you just saved that in a variable,
## right?), you have to specify another optional argument, namely
## xlim=c(lower, upper). Try this (and adjust the nclass argument if
## needed).

## Now let's compare the distributions of _all_ the data sets. An easy way
## to do that is the boxplot() function.  When given a table such as
## returned by counts(dds) it will do a boxplot for each of the columns
## in the matrix.

boxplot(counts(dds))

## Supply an optional ylim-argument to make differences between
## the samples clearer. Which of the
## samples is the 'odd one out', based on this? Is it a knock-out or wt
## genotype?
