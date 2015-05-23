########################
# Reports
########################

library(tm)
library(Rgraphviz)

d1 <- read.csv("~/mla_data/data/2012/CSV_files/freq.csv")
#d2 <- read.csv("~/mla_data/data/2013/CSV_files/freq.csv")
#d3 <- read.csv("~/mla_data/data/2014/CSV_files/freq.csv")

rev(d1)
d1 <- as.data.frame(d1)
word.names <- head(d1$X, 10)
word.names <- rev(word.names)
word.freq <- head(d1$Total, 10)
word.freq <- rev(word.freq)

#################################
# 2012 word frequency plot
#################################

## Open PDF device and set location to save file
png("~/mla_data/plots/freq_2012.png", 600, 480)

	## Set plot dimensions 
	par(pin=c(4, 4))

	## Draw plot
	freq.plot <- barplot(word.freq, names.arg=word.names, horiz=TRUE, 
						 main="2012 Word Frequencies", ylab=NULL, 
						 xlab="Frequency", las=2, axes=FALSE)
	
	# Starting x-axis position for for() loop
	freq.pos <- 0.65		
	
	## Add frequency totals to bars	
	for(i in 1:length(word.freq)) {			
	text(freq.pos, labels=word.freq[i], pos=4, offset=.2)
	freq.pos <- freq.pos + 1.2
	}

	## Add bottom axis and numeric range
	axis(1, at=seq(0, 1200, 100))

## Close PDF device
dev.off()

##########################
# Correlation Cluster
##########################

load("~/mla_data/data/dtm.rda")

png("~/mla_data/plots/cor_cluster.png", 700, 500)

##Call a list of attributions to change the look of the cluster graph
defAttrs <- getDefaultAttrs()

plot(dtm, terms=findFreqTerms(dtm, lowfreq=250, highfreq=2000),
     corThreshold=0.12, attrs=list(node=list(shape = "ellipse", 
     fixedsize = TRUE, fillcolor="lightblue", height="2.6", 
     width="10.5", fontsize="14")))

dev.off()
