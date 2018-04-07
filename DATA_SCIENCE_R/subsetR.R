x <- c("a", "b", "c", "c", "d", "a")
x[1]

x[1:4]

x <- matrix(1:6, 2, 3)
x

x[1, 2]
x[1, ]
x[, 2]

x <- matrix(1:6, 2, 3)
x[1, 2]
x[1, 2, drop = FALSE]

x[1, , drop = FALSE]

x <- list(foo = 1:4, bar = 0.6)
x
bar
x[[1]]
x[["bar"]]
x$bar

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"

x[[name]]

x$name


x$foo

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(3, 2)]

head(airquality)
good <- complete.cases(airquality)
head(airquality[good, ])

x<- matrix(1:4, 2, 2)
y <- matrix(rep(10, 4), 2, 2)

x * y

x / y

x %*% y

x <- as.Date("1970-01-01")
x

unclass(as.Date("1970-01-02"))

x <- Sys.time()

p <- as.POSIXlt(x)

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
 x <- strptime(datestring, "%B %d, %Y %H:%M")
 x

 class(x)

 
 x <- as.Date("2012-01-01")
 y <-                                                                                                                                               strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
 x-y

x <- as.POSIXlt(x > x-y)

x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y


chicago <- readRDS("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/chicago.rds")
names(chicago)[1:3]

subset <- select(chicago, city:dptp)
head(subset)



i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

subset <- select(chicago, ends_with("2"))
str(subset)

 subset <- select(chicago, starts_with("d"))
 str(subset)

chic.f <- filter(chicago, pm25tmean2 > 30)
str(chic.f)
summary(chic.f$pm25tmean2)

chicago <- arrange(chicago, date)

head(select(chicago, date, pm25tmean2), 3)

tail(select(chicago, date, pm25tmean2), 3)

chicago <- arrange(chicago, desc(date))

head(select(chicago, date, pm25tmean2), 3)

tail(select(chicago, date, pm25tmean2), 3)

head(chicago[, 1:5], 3)
chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[, 1:5], 3)

chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago)

chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago)
head(transmute(chicago,pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm = TRUE),o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE)))


chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years,o3 = max(o3tmean2, na.rm = TRUE),no2 = median(no2tmean2, na.rm = TRUE))

mydata = read.csv("C:/Users/IBM_ADMIN/Desktop/IT TRAINING/sampledata.csv")

sample_n(mydata,3)
sample_frac(mydata,0.1)

x1 = distinct(mydata)
x2 = distinct(mydata, Index, .keep_all= TRUE)

x2 = distinct(mydata, Index, Y2010, .keep_all= TRUE)


mydata2 = select(mydata, Index, State:Y2008)
mydata = select(mydata, -Index, -State)
mydata3 = select(mydata, starts_with("Y"))


mydata33 = select(mydata, -starts_with("Y"))

mydata4 = select(mydata, contains("I"))

mydata5 = select(mydata, State, everything())

mydata6 = rename(mydata, Index=Index1)

mydata7 = filter(mydata, Index == "A")

mydata7 = filter(mydata6, Index1 %in% c("A", "C"))
mydata8 = filter(mydata6, Index1 %in% c("A", "C") & Y2002 >= 1300000 )

mydata9 = filter(mydata6, Index %in% c("A", "C") | Y2002 >= 1300000)

mydata10 = filter(mydata6, !Index1 %in% c("A", "C"))

summarise(mydata, Y2015_mean = mean(Y2015), Y2015_med=median(Y2015))

summarise_at(mydata, vars(Y2005, Y2006), funs(n(), mean, median))

summarise_at(mydata, vars(Y2011, Y2012),
             funs(n(), missing = sum(is.na(.)), mean(., na.rm = TRUE), median(.,na.rm = TRUE)))

arrange(mydata, Index, desc(Y2011))
