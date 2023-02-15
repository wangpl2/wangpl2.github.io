#说明：
#第一行：第一列应该为Code等，第二列开始引物名称应该为：GLESSR3；
#第二行：第一列应该为alelle,第二列开始一直为1,2......1,2；
#第一列：第三行往下为样本名称；
#第三行往下第二列往右应该为扩增片段的分子量大小。
#
library(tidyverse)
LichiSSRData4Fp <- read_csv("C:/Users/20220902/Desktop/Rdata/LichiSSRData4Fp.csv")
lcsd <- LichiSSRData4Fp[-1,]
lcsd <- lcsd[,-1]
n <- colnames(lcsd)
mknames <- sub(".*(SSR-\\d+).*","\\1",n)
mknames[-1]
unique(mknames)
MarkerCollection <- unique(mknames)
length(unique(mknames))


ZeroOneMdCollection <- function(lcsd,MarkerName,SampleSize){
SSR <- select(lcsd,contains(MarkerName))
SSR
SSR[1,2]

n <- t(SSR[1])
n2 <- t(SSR[2])
k <- c(n,n2)
k
uk <- unique(k)
uk
typeof(uk)
length(uk)
uk
retable <- data.frame("")
i=1   #i在下面循环中表示第i列 
c.names <- colnames(retable)
for (fgSize in uk) {
  if(fgSize != "/"){
    
  SSRplusfgsizeName <- str_c(MarkerName,"-",fgSize)
  c.names[i] <- SSRplusfgsizeName
  for (sampleNum in 1:SampleSize) {#样本数量
    if (SSR[sampleNum,1 ] == fgSize || SSR[sampleNum,2] == fgSize) {
      retable[sampleNum,i] <- 1
    } else {
      retable[sampleNum,i] <- 0
    }
  }
  #print(SSRplusfgsizeName)
  i = i + 1
  }
  #print(retable)
}
c.names
colnames(retable)
colnames(retable) <- c.names
return(retable) 
}


ZeroOneMdCollection(lcsd,"SSR-5",58)

returnWholeMdCollection <- function(lcsd,MarkerCollection,sampleSize){
wholeMdCollection <- data.frame("")
for (mk in MarkerCollection) {
  aPmkMd <- ZeroOneMdCollection(lcsd,mk,58)
  wholeMdCollection <- cbind(wholeMdCollection,aPmkMd)
  }
  wholeMdFinalCollection <- wholeMdCollection[,-1]
  return(wholeMdFinalCollection)
}

wholeMdFinalCollection <- returnWholeMdCollection(lcsd,MarkerCollection,58)
#print(wholeMdFinalCollection)

write.csv(wholeMdFinalCollection,file = "wholeMdFinalCollection4FingerPrint.csv",
          row.names = FALSE)


