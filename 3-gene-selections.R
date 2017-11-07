### We continue with the previously obtained data, specifically the dds and res objects.

## In order to do further analyses such sa gene set enrichment, we need
## to make selections of our genes, based on the fold-change and
## adjusted p-value. You can use the order() function, but sometimes you
## want to specify explicit threshold instead of 'the top so-many'. For
## this we need comparison operators. E.g. to find all the genes without
## any counts, we could say

not.expressed <- (res[,'baseMean'] == 0)   # NOTE: == means 'is equal to',  single '=' is used for arguments

## not.expressed is now a vector of so-called logicals (or Booleans),
## with TRUE where the baseMean column had a 0, and FALSE if not. You
## can use this logical vector to select rows from the original table:

res.not.expressed <- res[not.expressed, ]

## 1. How many are there (use e.g. the summary function)

## If you apply the function sum() to a vector of logicals it will return the _number_ of TRUEs
## 2. How many genes have a baseMean higher than 10,000?

## We have seen many NA's in the results table. We have to somehow get
## rid of them, because these values are 'contageous': many functions
## will return NA if they are given arguments containing any NA (unless
## you specify the argument na.rm=TRUE, like we did with min() and
## max()). Luckily there is a simple function that can test for this:
## is.na(). We can 'invert' the value of a logical using the '!'
## operator. In other words, to filter out the genes that have an NA
## p-adj, we simply have to do the following (in several steps for
## clarity):

na <- is.na(res[, 'padj'])
not.na <- !na
res2 <- res[not.na, ]

## 2. How many genes survive this filtering?

## 3. Which genes have a padj value better than 1e-20?

## Lastly, we should be able to combine several comparison operators,
## e.g. select genes that have change at least 2-fold, but also have a
## p-value better than 0.01. For this there is the AND operator: & . It
## works as can be expected: a & b is only TRUE if both a AND b have
## TRUE

## 4. How many genes go up, and have an adjusted p-value better than 0.01? Same question for
## the genes going down.

## We will now try to see what is so special about these gene lists in terms of annotation.
## We therefore have to select the names of these genes. Use rownames() to select the names of your
## genes of interest out of the results table in combination with your selection criteria. Write
## them to a file, roughly as follows

genes.up <- rownames(myresults[mycriteria,])
writeLines(con=file("up.txt"), rownames(res[up,]))

## and likewise for the down genes.

## 5. Use http://cbl-gorilla.cs.technion.ac.il/ (or
## http://www.geneontology.org/page/go-enrichment-analysis) to analyse
## your lists of gene names (be sure to select Mouse as species).  Which
## processes, functions or components are overrepresented in your up and
## down lists? Which group of genes is responsible for most terms in the
## up-list?
