data("Groceries")

library(arules)
library(arulesViz)
library(datasets)
summary(Groceries)
inspect(Groceries[1:5])
itemFrequency(Groceries[, 1:3])
# Load the data set

image(Groceries[1:5])
image(sample(Groceries, 100))
apriori(Groceries)
groceryrules <- apriori(Groceries, parameter = list(support =
                                                      0.006, confidence = 0.25, minlen = 2))
groceryrules
data(Groceries)
summary(groceryrules)
inspect(groceryrules[1:3])
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)
write(groceryrules, file = "groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)
groceryrules_df <- as(groceryrules, "data.frame")
str(groceryrules_df)
itemFrequencyPlot(Groceries,topN=20,type="absolute")


rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))

# Show the top 5 rules, but only 2 digits
options(digits=2)
inspect(rules[1:5])
rules<-sort(rules, by="confidence", decreasing=TRUE)
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8,maxlen=3))
subset.matrix <- is.subset(rules, rules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
rules.pruned <- rules[!redundant]
rules<-rules.pruned

rules<-apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.08), 
               appearance = list(default="lhs",rhs="whole milk"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:50])

rules<-apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.15,minlen=2), 
               appearance = list(default="rhs",lhs="whole milk"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

library(arulesViz)
plot(rules,method="graph",interactive=TRUE,shading=NA)
