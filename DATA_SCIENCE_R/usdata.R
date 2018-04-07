pm0 <- read.table("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/1999.txt", comment.char = "#", header = FALSE, sep = "|", na.strings = "")
dim(pm0)
head(pm0[, 1:13])
cnames <- readLines("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/1999.txt", 1)
cnames <- strsplit(cnames, "|", fixed = TRUE)
names(pm0) <- make.names(cnames[[1]])
head(pm0[, 1:13])
x0 <- pm0$Sample.Value
summary(x0)
mean(is.na(x0))
pm1 <- read.table("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/2012.txt", comment.char = "#",header = FALSE, sep = "|", na.strings = "", nrow = 1304290)
names(pm1) <- make.names(cnames[[1]])
x1 <- pm1$Sample.Value
boxplot(log2(x0), log2(x1))
summary(x0)
summary(x1)
negative <- x1 < 0
mean(negative, na.rm = T)
dates <- pm1$Date
dates <- as.Date(as.character(dates), "%Y%m%d")
missing.months <- month.name[as.POSIXlt(dates)$mon + 1]
tab <- table(factor(missing.months, levels = month.name))
round(100 * tab / sum(tab))
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)
both <- intersect(site0, site1)
print(both)
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)
both.county <- 63
both.id <- 2008
## Choose county 63 and side ID 2008
pm1sub <- subset(pm1, State.Code == 36 & County.Code == both.county & Site.ID == both.id)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == both.county & Site.ID == both.id)
dates1 <- as.Date(as.character(pm1sub$Date), "%Y%m%d")
x1sub <- pm1sub$Sample.Value
dates0 <- as.Date(as.character(pm0sub$Date), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
## Find global range
rng <- range(x0sub, x1sub, na.rm = T)
par(mfrow = c(1, 2), mar = c(4, 5, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5]                                                                 * " (" * mu * g/m^3 * ")"))
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5]                                 * " (" * mu * g/m^3 * ")"))
abline(h = median(x1sub, na.rm = T))


mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))

mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))

 
d0 <- data.frame(state = names(mn0), mean = mn0)
 d1 <- data.frame(state = names(mn1), mean = mn1)
 mrg <- merge(d0, d1, by = "state")
 head(mrg)
 par(mfrow = c(1, 1))
 rng <- range(mrg[,2], mrg[,3])
 with(mrg, plot(rep(1, 52), mrg[, 2], xlim = c(.5, 2.5), ylim = rng, xaxt = "n", xlab = "", ylab = "State-wide Mean PM"))
 with(mrg, points(rep(2, 52), mrg[, 3]))
  segments(rep(1, 52), mrg[, 2], rep(2, 52), mrg[, 3])
  axis(1, c(1, 2), c("1999", "2012"))
  
  
  
  par(mfrow = c(1, 1))
   rng <- range(mrg[,2], mrg[,3])
   with(mrg, plot(rep(1, 52), mrg[, 2], xlim = c(.5, 2.5), ylim = rng, xaxt = "n", xlab = "", ylab = "State-wide Mean PM"))
   with(mrg, points(rep(2, 52), mrg[, 3]))
   segments(rep(1, 52), mrg[, 2], rep(2, 52), mrg[, 3])
   axis(1, c(1, 2), c("1999", "2012"))
  
  