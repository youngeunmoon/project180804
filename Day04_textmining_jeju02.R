library(XML)
library(memoise)
library(KoNLP)
library(wordcloud)
library(dplyr)
library(ggplot2)
library(ggmap)
library(rvest)
library(RColorBrewer)
library(data.table)
library(reshape)
library(stringr)

getwd()
setwd("C:\\R\\project180721")
list.files()
useSejongDic()
target<-readLines("seoul_new.txt")
target<-gsub("\\d+","",target)
target<-sapply(
  target,
  extractNoun,
  USE.NAMES = F
)
target<-unlist(target)
myGsub<-readLines("myGsub.txt")
i<-1
for (i in 1:length(myGsub)){
  target<-gsub(myGsub[i],"",target)
}
target<-Filter(function(x){!nchar(x)==1},target)
target<-Filter(function(x){nchar(x)<=10},target)
head(sort(target, decreasing = T),20)
write(unlist(target),"seoul_new2.txt")
target<-read.table("seoul_new2.txt")
target <- table(target)
head(sort(target,decreasing = T),20)
pal<-brewer.pal(8,"Dark2")
#set.seed(1234)
wordcloud::wordcloud(names(target),
                     freq = target,
                     min.freq=1,
                     random.order = F,
                     rot.per = 0.25,
                     scale = c(5,1),
                     colors=pal)

