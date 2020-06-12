data <- read.table("clipboard",header = T)
summary(data)
time <- seq.Date(as.Date("2020/1/20"), by = "day", length = 136)
time

#累计确诊的曲线图
plot(time,data$确诊.累计.,xlab="时间",ylab="累计确诊",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#累计死亡的曲线图
plot(time,data$死亡.累计.,xlab="时间",ylab="累计死亡",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#累计治愈的曲线图
plot(time,data$治愈.累计.,xlab="时间",ylab="累计治愈",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#新增确诊的曲线图
plot(time,data$新增确诊,xlab="时间",ylab="新增确诊",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#新增死亡的曲线图
plot(time,data$新增死亡,xlab="时间",ylab="新增死亡",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#新增治愈的曲线图
plot(time,data$新增治愈,xlab="时间",ylab="新增治愈",type="l",xaxt = "n")
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

#三个累计的曲线图
plot(time,data$确诊.累计.,xlab="时间",ylab="累计确诊",type="l",xaxt = "n",col="blue",lwd=2)
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)
lines(time,data$死亡.累计.,col="red",lwd=2)
lines(time,data$治愈.累计.,col="green",lwd=2)
legend("topright",c("累计确诊","累计死亡","累计治愈"),cex=0.6,bty="n",col=c("blue","red","green"),lty=1,lwd=2)  

par(mfrow=c(2,1), mar=c(2,2,2,2))  
#三个新增的曲线图
plot(time,data$新增确诊,xlab="时间",ylab="新增确诊",type="l",xaxt = "n",col="blue",lwd=2)
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)
lines(time,data$新增死亡,col="red",lwd=2)
lines(time,data$新增治愈,col="green",lwd=2)
legend("topright",c("新增确诊","新增死亡","新增治愈"),cex=0.6,bty="n",col=c("blue","red","green"),lty=1,lwd=2)  
#现有确诊的曲线图 
A <- data$确诊.累计.-data$死亡.累计.-data$治愈.累计.
plot(time,A,xlab="时间",ylab="现有确诊",type="l",xaxt = "n",col="blue",lwd=2)
axis.Date(1, at =time, format = "%Y-%m-%d",las = 1)

 
 
 