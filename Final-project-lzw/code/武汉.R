##SEIR模型
# Necessary libraries
library(deSolve)
library(chron)
library(bbmle)
# Definition of the SEIR model

SEIR <- function(t, x, parms) {
  with(as.list(c(parms,x)),{
    if(t < tau1) beta <- beta0
    else beta <- beta0*exp(-k*(t-tau1))
    N <- S + E + I + R
    dS <- - beta*S*I/N
    dE <- beta*S*I/N - sigma*E
    dI <- sigma*E - gamma*I
    dR <- (1-f)*gamma*I
    dD <- f*gamma*I
    dC <- sigma*E
    der <- c(dS,dE,dI,dR,dD,dC)
    list(der)
  }
  ) }
# Parameter transformation
trans <- function(pars) {
  pars["beta0"] <- exp(pars["beta0"])
  pars["k"] <- exp(pars["k"])
  pars["f"] <- plogis(pars["f"])
  pars["tau0"] <- exp(pars["tau0"])
  pars["tau1"] <- exp(pars["tau1"])
  return(pars)
}
##m模拟
data1=as.data.frame(read.table("clipboard",header=T))
names(data1) <- c("times","cases","deaths")
startdate <- as.Date("2019-12-08")
enddate <- as.Date("2020-1-23")
delay1 <- as.numeric(enddate - startdate)
t1=data1$times+delay1
N <- 1e6
init1 <- c(S = N - 1, E = 0, I = 1, R = 0, D = 0, C = 1)
fixed <- c(tau0 = log(delay1),tau1 = log(46), sigma = 1/4.45, gamma = 1/4.86)
free <- c(beta0 = log(0.2), k = log(0.001), f = 0)
nll1 <- function(beta0,k,f,tau0,tau1,sigma,gamma) {
  pars <- c(beta0=beta0,k=k,f=f,tau0=tau0,tau1=tau1,sigma=sigma,gamma=gamma)
  pars <- trans(pars)
  times <- c(0,data1$times+pars["tau0"])
  simulation <- as.data.frame(ode(init1,times,SEIR,parms=pars))
  simulation <- simulation[-1,]
  ll <- sum(dpois(data1$cases,simulation$C,log=TRUE))
  return(-ll)
}
fit1 <- mle2(nll1,start=as.list(free),fixed=as.list(fixed),method="Nelder-Mead",control=list(maxit=2e3))
trans(coef(fit1))


#拟合
par(mfrow=c(2,2))
times1=c(0,data1$times+delay1)
simulation1=as.data.frame(ode(init1,times1,SEIR,trans(coef(fit1))))
plot(times1,simulation1$C,type='l',lty=2,ylab='累计病例数',xlab='日期',xaxt="n")
axis(1,c(seq(0,180,30)),c("2019-12","2020-01","2020-02","2020-03","2020-04","2020-05","2020-06"))
points(data1$times+delay1,data1$cases,pch=20)
legend("topleft",legend=c("观测值","拟合值"),lty=c(0,2),pch=c(20,NA),bty='n')
title('武汉')

#有效再生数
beta0=0.6436746
k=0.0507116
gamma=0.2057613 
R0=beta0/gamma
R1=R0*exp(-k*(t1-47))
T1=round(log(R0)/k)
par(mfrow=c(2,2))

plot(t1-30,R1,type='l',ylim=c(0,4),ylab='有效再生数',xlab='日期',xaxt="n")
axis(1,c(seq(0,150,30)),c("2020-01-10","2020-02-10","2020-03-10","2020-04-10","2020-05-10","2020-06-10"))

abline(h=1,v=log(R0)/k+17,lty=2)
text(T1+20,2,"2020-02-15")
title('武汉')

#新增
data2=as.data.frame(read.table("clipboard",header=T))
plot(data2$times+20,data2$new,type='l',lty=2,ylab='病例新增人数',xlab='日期',xaxt="n")
axis(1,c(seq(0,150,30)),c("2020-01","2020-02","2020-03","2020-04","2020-05","2020-06"))
points(data2$times+20,data2$actual,pch=20)
legend("topright",legend=c("观测值","拟合值"),lty=c(0,2),pch=c(20,NA),bty='n')
title('武汉')
