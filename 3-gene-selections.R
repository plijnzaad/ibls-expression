### We continue with the previously obtained data, specifically the dds and res objects.

## In order to do further analyses such sa gene set enrichment, we need
## to make selections of our genes, based on the fold-change and
## adjusted p-value. You can use the order() function, but sometimes you
## want to specify explicit threshold instead of 'the top so-many'. For
## this we need comparison operators. E.g. to find all the genes without
## any counts, we could say

not.expressed <- (res[,'baseMean'] == 0)   # NOTE: == means 'is equal to',  single '=' is used for arguments!

## not.expressed is now a vector of so-called logicals (or Booleans),
## with TRUE where the baseMean column had a 0, and FALSE if not. You
## can use this logical vector to select rows from the original table:

res.not.expressed <- res[not.expressed, ]

## 1. How many are there (use e.g. the summary function)

## If you apply the function sum() to a vector of logicals it will return the _number_ of TRUEs, e.g.

sum(not.expressed)

## 2. How many genes have a baseMean higher than 10,000?

## We have seen many NA's in the results table. We have to get rid of
## them because these values are 'contageous': many functions will
## return NA if they are given arguments containing any NA. Some functions
## like we saw with mean(), min() and max()) have a special optional
## argument 'na.rm' to do this, but that does not work on vectors.
## We need a function that returns TRUE for NA, and FALSE otherwise.
## That function exists, it is called is.na():
na <- is.na(res[, 'padj'])

## 3. How many 'NA's are there?  We can use our 'na' vector to select
## things from the results table, but we need in fact the exact
## opposite: all the rows that are *not* NA.  To negate logical values
## there is the '!'  operator (also called the NOT operator):
not.na <- !na

# And now we can do 
res2 <- res[not.na, ]

## 4. How many genes survive this filtering?

## 5. Which genes have a padj value better than 1e-20?

## Lastly, we should be able to *combine* several comparison operators,
## e.g. select genes that have changed at least 2-fold, but also have a
## p-value better than 0.01. For this there is the AND operator: & . It
## works as can be expected: a & b is only TRUE if both a AND b have
## TRUE

## 6. How many genes go up, and have an adjusted p-value better than 0.01? Same question for
## the genes going down. Use something like the following code:
myselection <-  myresults[ , 'padj'] < somevalue & myresults[ , 'log2FoldChange'] > othervalue
myresults[myselection, ]

## We can now try to see what is so special about these gene lists in
## terms of annotation using the Gene Ontology tools available. They
## require lists of gene names.  Use rownames() to select the names of
## your genes of interest from the results table in combination with
## your selection criteria. Write them to a file as follows:

genes.up <- rownames( myresults[myselection,] )
writeLines(con=file("up.txt"), rownames(res[up,]))

## and likewise for the down genes. It is probably easiest to open this text file using Notepad++ or
## Excel, and then copy-paste things from there to the the web tools.

## 7. Use http://www.geneontology.org/page/go-enrichment-analysis )
## (or, if that is down, http://integromics.holstegelab.nl/index.php?framesrc=Core/go.cgi&action=search )
## to analyse your lists of gene names (be sure to select Mouse as
## species).  Which processes, functions or components are
## overrepresented in your up and down lists? Which group of genes is
## responsible for most terms in the up-list?
