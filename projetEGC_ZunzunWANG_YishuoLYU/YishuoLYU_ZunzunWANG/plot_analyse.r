Sys.setenv(JAVA_HOME='D:/Program Files (x86)/jdk1.7/jre') 
library(XLConnect)
library(igraph)
table <- read.csv("C:/Users/lv/Desktop/Data mining/R_Projet/table.csv")
tableno <- read.csv("C:/Users/lv/Desktop/Data mining/R_Projet/tableno.csv")

tableArc <- diag(0, nrow=56, ncol=2)
index <- 1

#row numero
for (i in seq(from=1,to=20)){
  # row numero compare
  for(n in seq(from=1, to=20)){
    if(table[i,n]==1){
      tableArc[index,1] <- i
      tableArc[index,2] <- n
      index<-index+1
    }
  }
}

tableArcno <- diag(0, nrow=28, ncol=2)
indexno <- 1

#row numero
for (i in seq(from=1,to=20)){
  # row numero compare
  for(n in seq(from=i+1, to=20)){
    
    if(tableno[i,n]==1){
      tableArcno[indexno,1] <- i
      tableArcno[indexno,2] <- n
      indexno<-indexno+1
    }
  }
}
tableArcno

#go2 <- graph(c(tableArc),n=20)
go2 <- graph(t(tableArc))
gno2 <- graph(t(tableArcno),directed = FALSE)

tkplot(go2)  #avec direction 
tkplot(gno2) #non direction

#the number of vertices
V(go2)

#the number of edges
E(go2)

#the degree of every vertice
degree(go2)

#the distribution of degrees of vertices
degree.distribution(go2)

#the shortest path of every vertices(the number of stop vertices)
shortest.paths(go2)

get.shortest.paths(go2,2)

#the similarity between vertices
similarity.jaccard(go2)

#the centrality
closeness(go2)

#the betweeness
betweenness(go2)
edge.betweenness(go2)

#the connexity
is.connected(go2)
clusters(go2)
no.clusters(go2)

#the communitty detection
wtcgo2 <- walktrap.community(go2)
ebc <- edge.betweenness.community(go2, directed = TRUE, edge.betweenness = TRUE, merges = TRUE, bridges = TRUE)
#display the communities
wtcgo2$membership
#modularity of the associated partition
modularity(wtcgo2)
modularity(go2,membership(wtcgo2))

#graphs generators
g <- erdos.renyi.game(1000, 1/1000)
g <- barabasi.game(10000)
#g <- graph.ring(10)as.directed(g, "mutual")
