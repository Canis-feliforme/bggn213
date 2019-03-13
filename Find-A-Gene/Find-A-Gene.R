##### ##### #   # ####         ###         ###  ##### #   # #####
#       #   ##  # #   #       #   #       #     #     ##  # #
####    #   # # # #   # ##### ##### ##### #  ## ####  # # # ####
#       #   #  ## #   #       #   #       #   # #     #  ## #
#     ##### #   # ####        #   #        ###  ##### #   # #####



# [Q7] Generate a sequence identity based heatmap of your aligned sequences using R.

library(bio3d)
align <- read.fasta("alignment.fst")
seq_id <- seqidentity(align)

heatmap(seq_id, symm=TRUE)

heatmap(seq_id, margins=c(7,7), symm=TRUE)

# export as png image
png(filename="heatmap.png")
heatmap(seq_id, margins=c(7,7), symm=TRUE)
dev.off()



# [Q8] Search the main protein structure database for the most similar atomic resolution structures to your aligned sequences.

# make a consensus sequence
consensus_seq <- consensus(align)
paste(consensus_seq$seq, collapse="")  # this has lots of gaps

# find row-wise maximum
ones <- seq_id==1
no_ones <- seq_id
no_ones[ones] <- NA
row_max <- apply(no_ones, 1, max, na.rm=TRUE)
which.max(row_max)
which(row_max==max(row_max))  # both wild peanut and peanut have the same max value

# consensus sequence of wild peanut and peanut
peanuts <- read.fasta("peanut_alignment.fst")
peanut_consensus <- consensus(peanuts)
paste(peanut_consensus$seq, collapse="")  # only two gaps... moving forward...

# query the PDB
query_seq <- paste(peanut_consensus$seq, collapse="")
pdb_search <- blast.pdb(query_seq)

annotated <- pdb.annotate(pdb_search$hit.tbl$subjectids)

Q8_long <- data.frame(annotated$structureId,
                      annotated$experimentalTechnique,
                      annotated$resolution,
                      annotated$source,
                      pdb_search$hit.tbl$evalue,
                      pdb_search$hit.tbl$identity)
colnames(Q8_long) <- c("ID", "Technique", "Resolution", "Source", "Evalue", "Identity")

# remove duplicates... only find unique proteins (by only using different organisms)
Q8_repeat_inds <- duplicated(Q8_long$Source)
Q8_short <- Q8_long[!Q8_repeat_inds,]

# Top 3
Q8_top3 <- Q8_short[1:3,]
write.csv(Q8_top3, "top3table.csv")


