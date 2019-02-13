 ####  #       ###    ####   ####       ###   #####
#      #      #   #  #      #          #  ##  #
#      #      #####   ###    ###       # # #  ####
#      #      #   #      #      #      ##  #      #
 ####  #####  #   #  ####   ####        ###   ####

# Graphics and Plots with R



# Section 2A: line plot

weight<-read.table("bimm143_05_rstats/weight_chart.txt", header=TRUE)
        # header=TRUE reads in the first lines as column names
plot(weight, pch=15, cex=1.5, lwd=2, ylim=c(2,10), xlab="Age (months)", ylab="Weight (kg)", main="Baby Weight vs. Age", type="o")

# Section 2B: barplot

feat<-read.table("bimm143_05_rstats/feature_counts.txt", header=TRUE, sep="\t")
                    # this one is tab-delimited
barplot(feat$Count)
