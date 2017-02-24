# Author: Enrico Dainelli

#First version
library(RJSONIO) 
library(XML)
result <- xmlParse(file = "~/Desktop/-omk-odk-submissions-thyolo_buildings.osm")
a<-xmlToList(result) 
b<-toJSON(a) 
resultJson <-jsonlite::fromJSON(b, simplifyDataFrame = TRUE)
resultJson <- as.data.frame(resultJson)
resultJson <- t(resultJson)
resultJson <- as.data.frame(resultJson)
resultJson$v2 <- rownames(resultJson)
resultJson <- resultJson[grep("way..attrs.id", rownames(resultJson)), ]
rownames(resultJson) <- NULL
colnames(resultJson)[which(names(resultJson) == "V1")] <- "way id"
library(readr)
thyolo_buildings_1_ <- read_csv("~/Desktop/thyolo_buildings (1).csv")
thyolo_buildings_1_$way_id <- resultJson$`way id`
write.csv(thyolo_buildings_1_,"~/Desktop/newcsv.csv")

#second version
library(XML)
result <- xmlParse(file = "~/Desktop/-omk-odk-submissions-thyolo_buildings (1).osm")
rootnode <- xmlRoot(result)
rootsize <- xmlSize(rootnode)
changevector <- c()
pages <- (1:rootsize)
for(i in pages){
  a <- (rootnode[[i]])
  a <- xmlToList(a)
  a <- as.list(a)
  a <- a$changeset
  changevector <- c(changevector, a)
}
changevector <- as.data.frame(changevector)
changevector <- changevector[!duplicated(changevector$changevector),]
changevector <- as.data.frame(changevector)
library(readr)
thyolo_buildings_1_ <- read_csv("~/Desktop/thyolo_buildings (1).csv")
thyolo_buildings_1_$changevector <- changevector$changevector
View(thyolo_buildings_1_)