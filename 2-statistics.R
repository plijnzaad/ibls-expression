## We continue with the data previously loaded.

## Now, do the complete differential expression analysis:

dds <- DESeq(dds)                       #this adds things to the 'dds' object

## 1. Amongst others, data has now been normalized. This is visible in 
## the colData.
## What is the normalization factor for the 'odd one out' sample
## from the previous exercise?

colData(dds)

## 2. To get the read counts after normalization, specify
## normalized=TRUE as an extra argument to counts(). Compare the
## boxplots of the unnormalized data (done in the last exercise of the
## previous session) with those of normalized data. Did the
## normalization work?

boxplot(counts(dds, normalized=TRUE), ylim=c(0,2000))

## To get the statistical results out of the normalized data,
## use the results() function. It needs the DESeqDataSet and
## a 'contrast': this specifies what experimental factor to
## compare (here: 'group'), which samples are 'treatment', and
## which samples are 'control'. It returns a table-like data
## structure

res <- results(dds, contrast=c("group", "Smchd1-null", "WT"))

## 3. The summary() function gives a useful overview of the results
## How many outliers are there, and how many 'low counts'?

summary(res)

## 4. To get an impression of the data as a whole, the change per
## gene versus its average is plotted. Use the plotMA() function for this,
## and pass it the res object as an argument.

plotMA(dds)

## 5. By default, plotMA() tries to show most of the data, and chooses
## its own y-axis limits. Genes outside the range are shown as
## triangles. Play with the ylim argument to show all the data. Better
## yet, use min() and max() on the 'log2FoldChange' column of your
## results data to find the limits automatically. To make the min() and
## max() functions ignore the NA's, you have to also pass an na.rm=TRUE
## argument.

lowest <- min(res[,'log2FoldChange'], na.rm=TRUE)
highest <- max(res[,'log2FoldChange'], na.rm=TRUE)
plotMA(dds, ylim=c(lowest,highest))

## 6. Have a look at e.g. the first 10 rows of the results table.  What
## do the columns mean? Why is padj greater than pvalue?  What are the
## statistics for the Smchd1 gene? (Remember how you selected data on a
## particular gene in the first exercise).

res[1:10, ]

res['Smchd1', ]

## 7. The genes Ndn, Mkrn3 and Peg12 are known to be repressed by
## Smchd1. Do the statistics confirm this?

res['Ndn',]
res['Mkrn3',]
res['Peg12',]

## 8. Use plot(x= ... , y= ... ) to make a plot of padj versus pvalue
## (remember how you selected columns in the first exercises). Where are
## the differences between the two largest? What multiple testing
## correction was used? Feel free to play and use different multiple
## testing correction methods when calling results() (see its
## documentation)

plot(x=res[,'pvalue'], y=res[,'padj'])

## 9. Function plotCounts() gives an overview, per experimental group,
## of the expression changes for a gene. Use the which.min function to
## find the most significantly changed gene, and plot its counts. Do the
## same for the gene that is 'most down' (any surprises there?), and the
## gene that is most up.

plotCounts(dds, gene=which.max(res[,'log2FoldChange']), intgroup="group")

## To find the top 10 genes that, in the Smchd1 knock-out, go down or go
## up most, we have first have to sort the results table. In R, this is
## done as follows:

order.incr <- order(res[, 'log2FoldChange'])
res.incr <- res[order.incr, ]

order.decr <- order(res[, 'log2FoldChange'], decreasing=TRUE)
res.decr <- res[order.decr, ]

## order() simply calculates a vector of numbers that puts the rows of
## the table in the the right order. By default, the ordering is from
## low to high; to get a descending order, specify 'decreasing=TRUE' as
## an extra argument to order()

## 10. Find the 10 genes that go up most, and those that go down most

res.incr[1:10,]                         #down most

res.decr[1:10,]                         #up most 
