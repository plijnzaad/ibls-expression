### We continue with the previously obtained data, specifically the dds
### and res objects.

## In order to do further analyses such sa gene set enrichment, we need
## to make selections of our genes, based on the fold-change and
## adjusted p-value. You can use the order() function, but sometimes you
## want to specify explicit threshold instead of 'the top so-many'. For
## this we need comparison operators. E.g. to find all the genes without
## any counts, we could say
not.expressed <- (res[,'baseMean'] == 0)   # NOTE: == means 'is equal to',  single '=' is used for arguments!


## not.expressed is now a vector of so-called logicals (als known as booleans),
## with TRUE where the baseMean column had a 0, and FALSE if not.
## To find out how many TRUEs there are in this vector,
## apply the sum() function:
sum(not.expressed)

## You can now use this logical vector to select rows from the original
## table:
res[not.expressed, ]

## How many genes have a baseMean higher than 10,000?
gt10k <-  ( res[,'baseMean'] > 10000  )
sum ( gt10k ) 

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

available <- !na

# We can now create a set with only the clear results:
res2 <- res[available, ]

## Which genes have a padj value better than 1e-20?
sum( res2[, 'padj']  < 1e-20 )

## Lastly, we should be able to *combine* several comparison operators,
## e.g. select genes that have changed at least 2-fold, AND also have a
## p-value better than 0.01. For this there is the AND operator: & . It
## works as can be expected: a & b is only TRUE if both a AND b have
## TRUE
## How many genes go up, and have an adjusted p-value better than
## 0.01? Same question for the genes going down. 
up <-  res2[ , 'padj'] < 0.01 & res2[ , 'log2FoldChange'] > 0
sum(up)
down <-  res2[ , 'padj'] < 0.01 & res2[ , 'log2FoldChange'] < 0
sum(down)

## We can now try to see what is so special about these gene lists in
## terms of annotation using the Gene Ontology tools available. They
## require lists of gene names.  Use rownames() to select the names of
## your genes of interest from the results table in combination with
## your selection criteria. Write them to a file as follows:

up.genes <- rownames(res2[up,])
writeLines(con=file("up.txt", up.genes))

down.genes <- rownames(res2[down,])
up.genes <- rownames(res2[up,])

## It is probably easiest to open this text file using Notepad++ or
## Excel, and then copy-paste things from there to the web tools.

## 7. Use http://www.geneontology.org/page/go-enrichment-analysis ) to
## analyse your lists of gene names (be sure to select Mouse as
## species). Which processes, functions or components are
## overrepresented in your up- and down-lists? Which group of genes is
## responsible for most terms in the up-list?

## Note: if the geneontology site is down, use
## http://integromics.holstegelab.nl/index.php?framesrc=Core/go.cgi&action=search
## (the password will be on the whiteboard)
