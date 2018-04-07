library(jsonlite)
library(plyr)
library(rvest)

citibike <- fromJSON("http://citibikenyc.com/stations/json")
stations <- citibike$stationBeanList
colnames(stations)

nrow(stations)

x<-data.frame(stations)
x[1:4,1:5]

res <- fromJSON('http://ergast.com/api/f1/2004/1/results.json')
drivers <- res$MRData$RaceTable$Races$Results[[1]]$Driver

colnames(drivers)

drivers[1:10, c("givenName", "familyName", "code", "nationality")]

var=201401
url=paste("http://stats.grok.se/json/en/",var,"/web_scraping",sep="")
raw.data <- readLines(url, warn="F") 
raw.data
require(rjson)
rd  <- fromJSON(raw.data)
rd


con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
x
head(x)

baseurl <- "https://projects.propublica.org/nonprofits/api/v1/search.json?order=revenue&sort_order=desc"
pages <- list()
for(i in 0:10){
  mydata <- fromJSON(paste0(baseurl, "&page=", i), flatten=TRUE)
  message("Retrieving page ", i)
  pages[[i+1]] <- mydata$filings
}

#combine all into one
filings <- rbind.pages(pages)

#check output
nrow(filings)


obesity = read_html("https://en.wikipedia.org/wiki/Obesity_in_the_United_States")

obesity = obesity %>%
  html_nodes("table") %>%
  .[[1]]%>%
  html_table(fill=T)


library(ggplot2)
library(maps)
m.usa <- map_data("county")
m.usa$id <- m.usa$subregion
m.usa <- m.usa[ ,-5]
names(m.usa)[5] <- 'region'


df <- data.frame(region = unique(m.usa$region),
                 obesity = rnorm(length(unique(m.usa$region)), 50, 10),
                 stringsAsFactors = F)

head(df)


ggplot(df, aes(map_id = region)) +
  geom_map(aes(fill = obesity), map = m.usa) + 
  expand_limits(x = m.usa$long, y = m.usa$lat) +
  coord_map()

lego_movie <- html("http://www.imdb.com/title/tt1490017/")

#Scrape the website for the movie rating
rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating

cast <- lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
cast

poster <- lego_movie %>%
  html_nodes("#img_primary img") %>%
  html_attr("src")
poster

review <- lego_movie %>%
  html_nodes("#titleUserReviewsTeaser p") %>%
  html_text()
review
