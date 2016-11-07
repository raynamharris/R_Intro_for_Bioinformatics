### Install package from Bioconducter
source("https://bioconductor.org/biocLite.R") ## try http:// if https:// URLs are not supported
biocLite("DESeq2")
library("DESeq2")

### The basic steps for differential expression analysis:
### Step 1: DESeqDataSet(se, design = ~ batch + condition)
### Step 2: dds <- DESeq(dds)
### Step 3: res <- results(dds, contrast=c("condition","trt","con"))

## Loading the data
## Used to be ablt to do this from a library call "pasilla" but there is a bug


### loading your own personal data
setwd("~/Desktop/R_Intro_for_Bioinformatics/data")
countData <- read.csv("pasillaGenes.csv", sep=",", header=TRUE)
colData <- read.csv("pasillaSamples.csv", sep=",", header=TRUE)
head(countData) ### notice, we need to make col 1 the row names
head(colData) ### notice, we need to make col 1 the row names

### these oneliners will make column 1 the rowname then remove column 1
countData <- data.frame(row.names=countData[,1], countData[,-1])
colData <- data.frame(row.names=colData[,1], colData[,-1])
head(countData) 
head(colData) 

### Step 1: construct a DESeqDataSet

dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ condition)
dds


### 1.3.5 Pre-filtering
### While it is not necessary to pre-filter low count genes, 
### removing rows in which there are no reads or nearly no reads will 
### reduce the memory size of the dds data object and 
### increase the speed of the transformation and testing functions within DESeq2. 

dds <- dds[ rowSums(counts(dds)) > 1, ]

### 1.3.6 Factor levels
### By default, R will choose a reference level for factors based on alphabetical order
dds$condition <- factor(dds$condition, levels=c("untreated","treated"))


### 1.4 Differential Expresssion
### The standard differential expression analysis steps are wrapped 
### into a single function, DESeq.
dds <- DESeq(dds)


### Results tables are generated using the function results, which extracts
### a results table with log2 fold changes, p values and adjusted p values
res <- results(dds)
res



### We can order our results table by the smallest adjusted p value:
resOrdered <- res[order(res$padj),]
resOrdered

### We can summarize some basic tallies using the summary function.
summary(res)


### How many adjusted p-values were less than 0.1?
sum(res$padj < 0.1, na.rm=TRUE)
## [1] 797

### If the adjusted p value cutoff will be a value other than 0.1, 
### alpha should be set to that value:
res05 <- results(dds, alpha=0.05)
summary(res05)

### In DESeq2, the function plotMA shows the log2 fold changes 
### attributable to a given variable over the mean of normalized counts.

plotMA(res, main="DESeq2", ylim=c(-2,2))


### A simple function for making this plot is plotCounts, which normalizes counts by sequencing depth and adds a pseudocount
### of 1 2 to allow for log scale plotting. The counts are grouped by the variables in intgroup, where more than
### one variable can be specified. Here we specify the gene which had the smallest p value from the results table
### created above. You can select the gene to plot by rowname or by numeric index.

plotCounts(dds, gene=which.min(res$padj), intgroup="condition")


### For customized plotting, an argument returnData specifies that the function 
### should only return a data.frame for plotting with ggplot.

d <- plotCounts(dds, gene=which.min(res$padj), intgroup="condition",
                returnData=TRUE)
library("ggplot2")
ggplot(d, aes(x=condition, y=count)) +
  geom_point(position=position_jitter(w=0.1,h=0)) +
  scale_y_log10(breaks=c(25,100,400))

# write.csv(as.data.frame(resOrdered),
#          file="condition_treated_results.csv")

### 1.6 Multi-factor designs
colData(dds)
### make a copy of dds and change design to ~ type + condition
ddsMF <- dds
design(ddsMF) <- formula(~ type + condition)

### alternatively
ddsMF <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ type +condition)


ddsMF <- DESeq(ddsMF)


## setting the contrast 
resMFType <- results(ddsMF, contrast=c("type","single-read","paired-end"))
resMFTypeOrdered <- resMFType[order(resMFType$padj),]
resMFTypeOrdered #results from paired in
# FBgn0003943 3205.75389      -2.251047  0.1183007  -19.02818
# FBgn0053105  229.78255      -2.451628  0.1657983  -14.78681
# FBgn0053909   67.39269      -2.838965  0.2042814  -13.89732
# FBgn0052669  150.31743       2.003563  0.1672334   11.98064
# FBgn0052581   34.74155      -2.165962  0.2061476  -10.50685

### now let's compare to our other sample
resOrdered # res for condition treated un treated
# FBgn0039155   453.2753      -3.714167  0.1600556  -23.20548
# FBgn0029167  2165.0445      -2.082784  0.1035958  -20.10491
# FBgn0035085   366.8279      -2.227224  0.1369732  -16.26029
# FBgn0029896   257.9027      -2.206754  0.1586949  -13.90564
# FBgn0034736   118.4074      -2.564956  0.1847592  -13.88270




### 2.2.1 Heatmap of the count matrix
library("pheatmap")
select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:20]

nt <- normTransform(dds) # defaults to log2(x+1)
log2.norm.counts <- assay(nt)[select,]
df <- as.data.frame(colData(dds)[,c("condition","type")])
pheatmap(log2.norm.counts, cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)



### 2.2.2 Heatmap of the sample-to-sample distances
rld <- rlog(dds) #log transformed
vsd <- varianceStabilizingTransformation(dds)
sampleDists <- dist(t(assay(rld)))

library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(rld$condition, rld$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)


### 2.2.3 Principal component plot of the samples
plotPCA(rld, intgroup=c("condition", "type"))
data <- plotPCA(rld, intgroup=c("condition", "type"), returnData=TRUE)
percentVar <- round(100 * attr(data, "percentVar"))
ggplot(data, aes(PC1, PC2, color=condition, shape=type)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance"))





