#install.packages("tidyverse")
library(tidyverse)
tFP <- read_csv("C:/Users/20220902/Desktop/Rdata/tFP.csv", 
                col_types = cols(...1 = col_character()))
#View(tFP)
target <- colnames(tFP)
target


name <- sub(".*(SSR\\d+).*","\\1",target)
name
data <- unique(name)
data
SSRseq <- data[-1]
SSRseq
length(SSRseq)



comb <- combn(SSRseq,4)
#typeof(comb)
#comb
#print(comb)
#comb[1:3,1]
#comb[1:3,2]
comb1 <- combn(SSRseq,1)
comb2 <- combn(SSRseq,2)

for (m.num in 1:length(SSRseq)) {
  com.num <- combn(SSRseq,m.num)
  ml <- length(com.num)
  #print("the number of primers")
  print(m.num)
  #print("the number of combinations")
  print(ml)
  
}

dif_nums <- function(SSR.collection,totalNum){#函数的定义,totalNum为样本数目
  SSR.READY <- replicate(totalNum,"0")
  for (x in 1:totalNum) {
    SSR.READY[x] <- paste(SSR.collection[x,],collapse = "")
  }
  return(length(unique(SSR.READY))) 
}

#只有一对SSR引物能区分样本的数目

for (ssr in SSRseq) {
  SSR.collection <- select(tFP,contains(ssr))
#  SSR.READY <- replicate(24,"0")
#    for (x in 1:24) {
#      SSR.READY[x] <- paste(SSR[x,],collapse = "")
#    }
#  dif.num <- length(unique(SSR.READY))
  #if(dif.num==24){
  dif.num <- dif_nums(SSR.collection,24)#函数的调用
   print("Primer_Name:")
   print(ssr)
   print("distinguished_number:")
    print(dif.num)
  #}
}


#两对SS引物能区分开的样本数目
#print("两对引物的情况")
for (ssr1 in SSRseq) {
  for (ssr2 in SSRseq) {
    #if(ssr1 == ssr2)   #这两行的注销与不注销对结果没有影响，
    #  next             #可能会少减少一点运算量
    SSR1 <- select(tFP,contains(ssr1))
    SSR2 <- select(tFP,contains(ssr2))
    SSR.collection <- cbind(SSR1,SSR2)
#    SSR.READY <- replicate(24,"0")
#    for (x in 1:24) {
#      SSR.READY[x] <- paste(SSR.collection[x,],collapse = "")
#    }
#    dif.num <- length(unique(SSR.READY))
    dif.num <- dif_nums(SSR.collection,24)#函数的调用
    if (dif.num == 24) {
      print("两对引物的情况")
      print("第1对引物为")
      print(ssr1)
      print("第2对引物为")
      print(ssr2) 
    }
    
    
   # print(ssr1)
   # print(ssr2)
    #print(dif.num)
  }
  
}




#roll <- function(){
#  die <- 1:6
#  dice <- sample(die,size=2,replace = TRUE)
#  sum(dice)
#}
#roll
