Sys.setenv(JAVA_HOME='D:/Program Files (x86)/jdk1.7/jre') 
library(XLConnect)
Cas <- read.csv("C:/Users/lv/Desktop/Data mining/R_Projet/result.csv")

table <- diag(0, nrow=20, ncol=20)
tableno <- diag(0, nrow=20, ncol=20)

#row numero
for (i in seq(from=1,to=19)){
  # row numero compare
  for(n in seq(from=i+1, to=20)){
    contenu=0
    #column numero
    for (j in 1:length(Cas[1,])){
      x <- Cas[i,j]
      y <- Cas[n,j]
      if (x&y == TRUE){
        contenu <- contenu+1
      }
    } 
    if(contenu>3){
      table[i,n] <- 1
      table[n,i] <- 1
      tableno[i,n] <- 1
    }
  }
}

write.table(table,"C:/Users/lv/Desktop/Data mining/R_Projet/table.csv",sep=",")

write.table(tableno,"C:/Users/lv/Desktop/Data mining/R_Projet/tableno.csv",sep=",")     
    
  
