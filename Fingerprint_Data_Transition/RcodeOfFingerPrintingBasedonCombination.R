############################################################################
#                                                                          #
#说明：(1)tFP为整个分子数据的集合
#         tFP的数据格式为：
#         (i).第一行：第一格为GeneID，其余为MarkerName-Fragmentweight,eg.GLESSR1-105
#         (ii)第一列，从第二行开始往下为样本名称；
#         (iii)第二行往下及第二列往右均为分子的0/1数据
#      (2)SSRseq为数据中的所有引物的集合                                   #
#      (3)returnData <- function(Md,MINS){#MINS为引物的小集合,             #
#         Md为整个分子数据集合，returnData为返回的分子数据集合,可用于指纹  #
#         图谱绘制的数据。                                                 #
#      (4)dif_nums <- function(SSR.collection,totalNum){#函数的定义,       #
#         totalNum为样本数目,SSR.collection为特定引物组合的分子数据的整合，#
#         dif_nums为特定引物组合能区分的样本数目。                         #
#       (5)fingerprint <- function(tFP,SSRseq,SampleSize,assignPrimerNum)  #
#         tFP表示整个分子数据集合，                                        #
#         SSRseq表示所用的所用引物的集合                                   #
#         SampleSize表示参试样本的大小                                     #
#         assignPrimerNum表示指定引物数量用于区分参试样本.                 #
#                                                                          #
#使用举例：fingerprint(tFP,SSRseq,24,2)                                    #
##############################################################################

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


#生成每个引物的数据集
returnData <- function(Md,MINS){#MINS为引物的小集合,Md为整个分子数据集合
  all.ssr.data <- data.frame("")
  for (ssr.rawdata in MINS ) {
    a.ssr.data <- select(Md,contains(ssr.rawdata))
    all.ssr.data <- cbind(all.ssr.data,a.ssr.data)
  }
  return(all.ssr.data[,-1])
  
}

#确定能区分样本的数目
dif_nums <- function(SSR.collection,totalNum){#函数的定义,totalNum为样本数目
  SSR.READY <- replicate(totalNum,"0")
  for (x in 1:totalNum) {
    SSR.READY[x] <- paste(SSR.collection[x,],collapse = "")#将每个个体的分子数据整合成一个字符串
  }
  return(length(unique(SSR.READY))) 
}
#先请读者输入需要抽取引物的对数


#M.com <- combn(SSRseq,2)#引物的组合中引物的数目
#M.com
#length(M.com[1,])
##M.com[,1]
#Num.comb=0   #能区分样本的引物组合数量
#for (i in 1:length(M.com[1,])) {#length(M.com[1,])为组合的数目
#  MINSSRseq <- M.com[,i]#引物组合的集合
#  #print(MINSSRseq)
#  SSR.collection <-  returnData(tFP,MINSSRseq)#
#  dif.num <- dif_nums(SSR.collection,24)#24为样本数量
#  if (dif.num == 24) {#24为样本数量
#    print("能区分样本的引物情况如下")
    
#    print(M.com[,i])
#    Num.comb = Num.comb+1
#  print("一对引物为：")
#  for (m in M.com[,i]) {        #组合内的成员
#    print(m)                    #整理成数据集合SSR.collection
#  }
#  }
#}
#print("能区分样本的引物组合数量为")
#print(Num.comb)

fingerprint <- function(tFP,SSRseq,SampleSize,assignPrimerNum){
  M.com <- combn(SSRseq,assignPrimerNum)#引物的组合中引物的数目
  M.com
  m <- length(M.com[1,])#引物组合的数目
  #M.com[,1]
  Num.comb=0   #能区分样本的引物组合数量
  for (i in 1:length(M.com[1,])) {#length(M.com[1,])为组合的数目
    MINSSRseq <- M.com[,i]#引物组合的集合
    #print(MINSSRseq)
    SSR.collection <-  returnData(tFP,MINSSRseq)#
    dif.num <- dif_nums(SSR.collection,SampleSize)#SampleSize为样本数量
    if (dif.num == SampleSize) {#24为样本数量
      print("能区分样本的引物情况如下")
      
      print(M.com[,i])
      Num.comb = Num.comb+1
      #  print("一对引物为：")
      #  for (m in M.com[,i]) {        #组合内的成员
      #    print(m)                    #整理成数据集合SSR.collection
      #  }
    }
  }
  print("引物组合数目为")
  print(m)
  print("能区分样本的引物组合数量为")
  print(Num.comb)
}

fingerprint(tFP,SSRseq,24,2)


