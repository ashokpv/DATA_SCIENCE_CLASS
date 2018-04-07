attach(mtcars)
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 
plot(wt, mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")

hist(mtcars$mpg)

hist(mtcars$mpg, breaks=12, col="red") 

x <- mtcars$mpg
h<-hist(x, breaks=10, col="red", xlab="Miles Per Gallon",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

# Kernel Density Plot
d <- density(mtcars$mpg) # returns the density data
plot(d) # plots the results 

d <- density(mtcars$mpg)
plot(d, main="Kernel Density of Miles Per Gallon")
polygon(d, col="red", border="blue") 

# Compare MPG distributions for cars with
# 4,6, or 8 cylinders
library(sm)
attach(mtcars)

# create value labels
cyl.f <- factor(cyl, levels= c(4,6,8),
                labels = c("4 cylinder", "6 cylinder", "8 cylinder"))

# plot densities
sm.density.compare(mpg, cyl, xlab="Miles Per Gallon")
title(main="MPG Distribution by Car Cylinders")

# add legend via mouse click
colfill<-c(2:(2+length(levels(cyl.f))))
legend(locator(1), levels(cyl.f), fill=colfill) 

dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="Gas Milage for Car Models",
         xlab="Miles Per Gallon")

# Dotplot: Grouped Sorted and Colored
# Sort by mpg, group and color by cylinder
x <- mtcars[order(mtcars$mpg),] # sort by mpg
x$cyl <- factor(x$cyl) # it must be a factor
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen"
dotchart(x$mpg,labels=row.names(x),cex=.7,groups= x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon", gcolor="black", color=x$color) 

# Simple Bar Plot
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution",
        xlab="Number of Gears") 

# Simple Horizontal Bar Plot with Added Labels
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", horiz=TRUE,names.arg=c("3 Gears", "4 Gears", "5)
                    
                   
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",xlab="Number of Gears", col=c("darkblue","red"),legend = rownames(counts))
                    
                    # Grouped Bar Plot
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",xlab="Number of Gears", col=c("darkblue","red"),legend = rownames(counts), beside=TRUE)
                    
                    
                    par(las=2) # make label text perpendicular to axis
                    par(mar=c(5,8,4,2)) # increase y-axis margin.
                    
                    counts <- table(mtcars$gear)
                    barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5   Gears"), cex.names=0.8)            
                    
                    
                    x <- c(1:5); y <- x # create some data
                    par(pch=22, col="red") # plotting symbol and color
                    par(mfrow=c(2,4)) # all plots on one page
                    opts = c("p","l","o","b","c","s","S","h")
                    for(i in 1:length(opts)){
                    heading = paste("type=",opts[i])
                    plot(x, y, type="n", main=heading)
                    lines(x, y, type=opts[i])
                    }
                    
                    x <- c(1:5); y <- x # create some data
                    par(pch=22, col="blue") # plotting symbol and color
                    par(mfrow=c(2,4)) # all plots on one page
                    opts = c("p","l","o","b","c","s","S","h")
                    for(i in 1:length(opts){
                    heading = paste("type=",opts[i])
                    plot(x, y, main=heading)
                    lines(x, y, type=opts[i])
                    }
                    
                    
                    # Create Line Chart
                    
                    # convert factor to numeric for convenience
                    Orange$Tree <- as.numeric(Orange$Tree)
                    ntrees <- max(Orange$Tree)
                    
                    # get the range for the x and y axis
                    xrange <- range(Orange$age)
                    yrange <- range(Orange$circumference)
                    
                    # set up the plot
                    plot(xrange, yrange, type="n", xlab="Age (days)",
                    ylab="Circumference (mm)" )
                    colors <- rainbow(ntrees)
                    linetype <- c(1:ntrees)
                    plotchar <- seq(18,18+ntrees,1)
                    
                    # add lines
                    for (i in 1:ntrees) {
                    tree <- subset(Orange, Tree==i)
                    lines(tree$age, tree$circumference, type="b", lwd=1.5,
                    lty=linetype[i], col=colors[i], pch=plotchar[i])
                    }
                    
                    
                    
                    # add a title and subtitle
                    title("Tree Growth", "example of line plot")
                    
                    # add a legend
                    legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
                    pch=plotchar, lty=linetype, title="Tree")
                    
                    
                    slices <- c(10, 12,4, 16, 8)
                    lbls <- c("US", "UK", "Australia", "Germany", "France")
                    pie(slices, labels = lbls, main="Pie Chart of Countries")
                    
                    # Pie Chart with Percentages
                    slices <- c(10, 12, 4, 16, 8)
                    lbls <- c("US", "UK", "Australia", "Germany", "France")
                    pct <- round(slices/sum(slices)*100)
                    lbls <- paste(lbls, pct) # add percents to labels
                    lbls <- paste(lbls,"%",sep="") # ad % to labels
                    pie(slices,labels = lbls, col=rainbow(length(lbls)),
                        main="Pie Chart of Countries")   
                    
                    # 3D Exploded Pie Chart
                    library(plotrix)
                    slices <- c(10, 12, 4, 16, 8)
                    lbls <- c("US", "UK", "Australia", "Germany", "France")
                    pie3D(slices,labels=lbls,explode=0.1,
                          main="Pie Chart of Countries ")
                    
                    # Pie Chart from data frame with Appended Sample Sizes
                    mytable <- table(iris$Species)
                    lbls <- paste(names(mytable), "\n", mytable, sep="")
                    pie(mytable, labels = lbls,
                        main="Pie Chart of Species\n (with sample sizes)")
                    
                    
                    
                    boxplot(mpg~cyl,data=mtcars, main="Car Milage Data",
                            xlab="Number of Cylinders", ylab="Miles Per Gallon") 
                    
                    # Notched Boxplot of Tooth Growth Against 2 Crossed Factors
                    # boxes colored for ease of interpretation
                    boxplot(len~supp*dose, data=ToothGrowth, notch=TRUE,
                            col=(c("gold","darkgreen")),
                            main="Tooth Growth", xlab="Suppliment and Dose") 
                    
                    
                    # Violin Plots
                    library(vioplot)
                    x1 <- mtcars$mpg[mtcars$cyl==4]
                    x2 <- mtcars$mpg[mtcars$cyl==6]
                    x3 <- mtcars$mpg[mtcars$cyl==8]
                    vioplot(x1, x2, x3, names=c("4 cyl", "6 cyl", "8 cyl"),
                            col="gold")
                    title("Violin Plots of Miles Per Gallon")
                    
                    # Example of a Bagplot
                    library(aplpack)
                    attach(mtcars)
                    bagplot(wt,mpg, xlab="Car Weight", ylab="Miles Per Gallon",
                            main="Bagplot Example") 
                    
                    # Add fit lines
                    abline(lm(mpg~wt), col="red") # regression line (y~x)
                    lines(lowess(wt,mpg), col="blue") # lowess line (x,y) 
                    
                    # Enhanced Scatterplot of MPG vs. Weight
                    # by Number of Car Cylinders
                    library(car)
                    scatterplot(mpg ~ wt | cyl, data=mtcars,
                                xlab="Weight of Car", ylab="Miles Per Gallon",
                                main="Enhanced Scatter Plot",
                                labels=row.names(mtcars))                 
                    