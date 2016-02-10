#text mining
Sys.setenv(JAVA_HOME='D:/Program Files (x86)/jdk1.7/jre')
library(XLConnect)
library(tm)
library(RColorBrewer)
library(wordcloud)
#vignette("tm")
options(max.print=1000000)
cas<-readWorksheet(loadWorkbook("C:/Users/lv/Desktop/Data mining/R_Projet/Cas2015_16.xlsx"),sheet=1)
cas

abstract <- cas[1:1041,5]

reuters<-Corpus(VectorSource(abstract))
reuters <- tm_map(reuters, PlainTextDocument)
reuters <- tm_map(reuters, stripWhitespace)
reuters <- tm_map(reuters, removePunctuation)
reuters <- tm_map(reuters, removeNumbers)
reuters <- tm_map(reuters, content_transformer(tolower))
reuters <- tm_map(reuters, removeWords, stopwords("english"))
reuters <- tm_map(reuters, removeWords, stopwords("french"))
reuters <- tm_map(reuters, removeWords,
                         c("afin","ainsi","alors","according","comme","dun","dune","entre",
                           "ensemble","¨ºtre","non","tr¨¨s"))

tm_map(reuters, stemDocument)

dtm <- DocumentTermMatrix(reuters)

#inspect(dtm[5:10, 740:743])
#inspect(dtm[1:5, 100:105])

#The value of 'sparse' contribute to the terms left.
dtm2 <- removeSparseTerms(dtm, sparse=0.99)
data <- as.data.frame(inspect(dtm2))

findFreqTerms(dtm2, 250)
findAssocs(dtm,"lagrange",0.3)

name <- matrix(1:1041,1041,1)
rownames(data)<-name[,1]

write.table(data,"C:/Users/lv/Desktop/Data mining/R_Projet/result.csv",sep=",")
