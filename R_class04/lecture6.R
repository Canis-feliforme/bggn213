 ####  #       ###    ####   ####       ###    ###
#      #      #   #  #      #          #  ##  #
#      #      #####   ###    ###       # # #  ####
#      #      #   #      #      #      ##  #  #   #
 ####  #####  #   #  ####   ####        ###    ###



# Section 1: Improving analysis code by writing functions

# A. Can you improve this analysis code?
df <- data.frame(a=1:10, b=seq(200,400,length=10),c=11:20,d=NA)
df$a <- (df$a - min(df$a)) / (max(df$a) - min(df$a))
df$b <- (df$b - min(df$a)) / (max(df$b) - min(df$b))
df$c <- (df$c - min(df$c)) / (max(df$c) - min(df$c))
df$d <- (df$d - min(df$d)) / (max(df$a) - min(df$d))  

fnA <- function(some_vector) {(some_vector - min(some_vector)) / (max(some_vector) - min(some_vector))}
df$a <- fnA(df$a)
df$b <- fnA(df$b)
df$c <- fnA(df$c)
df$d <- fnA(df$d)

# B. Can you improve this analysis code?
# install.packages("bio3d")
library(bio3d)
s1 <- read.pdb("4AKE")  # kinase with drug
s2 <- read.pdb("1AKE")  # kinase no drug
s3 <- read.pdb("1E4Y")  # kinase with drug
s1.chainA <- trim.pdb(s1, chain="A", elety="CA")
s2.chainA <- trim.pdb(s2, chain="A", elety="CA")
s3.chainA <- trim.pdb(s1, chain="A", elety="CA")
s1.b <- s1.chainA$atom$b
s2.b <- s2.chainA$atom$b
s3.b <- s3.chainA$atom$b
plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor") 
plotb3(s2.b, sse=s2.chainA, typ="l", ylab="Bfactor") 
plotb3(s3.b, sse=s3.chainA, typ="l", ylab="Bfactor")

plot_B_factor <- function(pdb_code) {
  s <- read.pdb(pdb_code)
  s.chainA <- trim.pdb(s1, chain="A", elety="CA")
  s.b <- s.chainA$atom$b
  plotb3(s.b, sse=s.chainA, typ="l", ylab="Bfactor")
  
}
plot_B_factor("4AKE")  # kinase with drug
plot_B_factor("1AKE")  # kinase no drug
plot_B_factor("1E4Y")  # kinase with drug

# cluster dendrogram
hc <- hclust( dist( rbind(s1.b, s2.b, s3.b) ) )
plot(hc)



# Section 2: Writing and calling a function

# example
square.it <- function(x) {
  square <- x * x
  return(square)
}

# square a number
square.it(5)  # 25
# square a vector
square.it(c(1, 4, 2))  # 1 16 4
# square a character (not going to happen)
# square.it("hi")  # Error: non-numeric argument to binary operator

matrix1 <- cbind(c(3, 10), c(4, 5))
square.it(matrix1)  # 9 16 / 100 25

# return()
fun1 <- function(x) {
  3 * x - 1
}
fun1(5)  # 14

fun2 <- function(x) {
  y <- 3 * x - 1
  return(y)  # must use return() to make y a global variable instead of just a local variable
}
fun2(5)  # 14



# Section 3: Getting more complex

my.fun <- function(X.matrix, y.vec, z.scalar) {
  sq.scalar <- square.it(z.scalar)  # use my previous function square.it() and save result
  mult <- X.matrix %*% y.vec        # multiply the matrix by the vector using %*% operator
  final <- mult * sq.scalar         # multiply the resulting objects together to get a final ans
  return(final)                     # return the result
}

# save a matrix and a vector object...
my.mat <- cbind(c(1, 3, 4), c(5, 4, 3))
my.vec <- c(4, 3)
# ...and pass my.mat and my.vec into the my.fun function
my.fun(X.matrix = my.mat, y.vec = my.vec, z.scalar = 9)  # 1539 1944 2025
# n.b. this is the same as:
my.fun(my.mat, my.vec, 9)  # 1539 1944 2025

# Returning a list of objects
another.fun <- function(sq.matrix, vector) {
  # transpose matrix and square the vector
  step1 <- t(sq.matrix)
  step2 <- vector * vector
  # save both results in a list and return
  final <- list(step1, step2)
  return(final)
}
# call the function and save result in object called outcome
outcome <- another.fun(sq.matrix = cbind(c(1, 2), c(3, 4)),
                       vector = c(2, 3))
# print the outcome list
print(outcome)  # 1 2 / 3 4 // 4 9
# extract first in list
outcome[[1]]  # 1 2 / 3 4
# extract second in list
outcome[[2]] # 4 9



