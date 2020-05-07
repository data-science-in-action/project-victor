##SEIR 模型
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
##总体
data1=as.data.frame(read.table("clipboard",header=T))
names(data1) <- c("times","cases","deaths")
startdate <- as.Date("2019-12-08")
enddate <- as.Date("2020-1-20")
delay1 <- as.numeric(enddate - startdate)
t1=data1$times-3
N <- 1.4e8
init1 <- c(S = N - 1, E = 0, I = 1, R = 0, D = 0, C = 1)
fixed <- c(tau0 = log(delay1),tau1 = log(46), sigma = 1/4.98, gamma = 1/7.04)
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
plot(times1,simulation1$C,type='l',lty=2,ylab='病例累计人数',xlab='日期',xaxt="n")
axis(1,c(seq(0,150,30)),c("2019-12","2020-01","2020-02","2020-03","2020-04","2020-05"))
points(data1$times+delay1,data1$cases,pch=20)
legend("topleft",legend=c("观测值","拟合值"),lty=c(0,2),pch=c(20,NA),bty='n')
title('全国')

#有效再生数
R1=4.351482*exp(-0.07233686*t1)
T1=round(log(4.351482)/0.07233686)
par(mfrow=c(2,2))
plot(t1,R1,type='l',ylim=c(0.5,1.8),ylab='有效再生数',xlab='日期',xaxt="n")
axis(1,c(seq(0,120,30)),c("2020-01-20","2020-02-20","2020-03-20","2020-04-20","2020-05-20"))
abline(h=1,v=log(4.351482)/0.07233686,lty=2)
text(T1,0.8,"2020-02-12")
title('总体')

