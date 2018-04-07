x <- 5
x

x <- vector("numeric", length = 10)
x

y <- c("a", TRUE)
y <- c(1.7, "a")

x <- 0:6
class(x)

as.character(x)

x <- c("a", "b", "c")
as.numeric(x)

m <- matrix(nrow = 2, ncol = 3)
m
dim(m)
attributes(m)

m <- matrix(1:6, nrow = 2, ncol = 3)
m

m <- 1:10
m

dim(m) <- c(2, 5)
m

x <- 1:3
y <- 10:12
cbind(x, y)

rbind(x, y)

x <- list(1, "a", TRUE, 1 + 4i)
x

x <- vector("list", length = 5)
x

x <- factor(c("yes", "yes", "no", "yes", "no"))
x

table(x)

unclass(x)

x <- factor(c("yes", "yes", "no", "yes", "no"))
x

x <- c(1, 2, NA, 10, 3)
is.na(x)

is.nan(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
x

ncol(x)
nrow(x)

x <- 1:3
names(x)

names(x) <- c("New York", "Seattle", "Los Angeles")
x

names(x)

x <- list("Los Angeles" = 1, Boston = 2, London = 3)
x

names(x)

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m

colnames(m) <- c("h", "f")
rownames(m) <- c("x", "z")
m

mydata = read.table("/home/ash/foo.txt",header = TRUE)
mydata

mydata = read.csv("mydata.csv")  # read csv file 
mydata 
