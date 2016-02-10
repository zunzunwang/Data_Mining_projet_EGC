Sys.setenv(JAVA_HOME='D:/Program Files (x86)/jdk1.7/jre') 
library(XLConnect)
library(igraph)
Cas <- read.csv("C:/Users/lv/Desktop/Data mining/R_Projet/result.csv")
nodesSet1 <- 1:20
nodesSet2 
<- 1:20
indexH <- 1
ss1 <-diag(0, nrow=1, ncol=12)
ss2 <-diag(0, nrow=1, ncol=12)
for (i in seq(from=1,to=20)){
  for(n in seq(from=1, to=20)){
    if(Cas[i,n]!=0){
      ss1[1,indexH] <- i
      ss2[1,indexH] <- n
      indexH <- indexH + 1
      
    }
  }
}
ss1
ss2

# create example input data
edgeList <- data.frame(S1=c(ss1),S2=c(ss2))

### PREMISE :
### graph.bipartite function simply create a graph and add a boolean 'type' attribute
### to each vertex that indicate the partition of the vertex (e.g. TRUE first partition, 
### FALSE second partition).
### So, it's not strictly necessary to use that function to get a bipartite graph, but 
### you can use any method you like (or feel easier) as long as you add a 'type' 
### attribute. 
### Hence, in the following code I won't use graph.bipartite since I don't like it :)

# first we give prefixes to the nodes to discern the two partition
g <- graph.empty()
g <- add.vertices(g,nv=length(nodesSet1),attr=list(name=paste0('A',nodesSet1),
                                                   type=rep(TRUE,length(nodesSet1))))
g <- add.vertices(g,nv=length(nodesSet2),attr=list(name=paste0('B',nodesSet2),
                                                   type=rep(FALSE,length(nodesSet2))))

# we need to turn edgeList into a vector (and using names instead of indexes)
edgeListVec <- as.vector(t(as.matrix(data.frame(S1=paste0('A',edgeList$S1),
                                                S2=paste0('B',edgeList$S2)))))
g <- add.edges(g,edgeListVec)

# check if is recognized as bipartite
is.bipartite(g)
plot.igraph(g, layout=layout.bipartite,
            vertex.color=c("orange","green")[V(g)$type+1])