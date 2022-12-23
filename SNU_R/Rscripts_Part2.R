##### Import Data File & Create Histogram / pg.12 #####
AddisonCreek = read.table("data/AddisonCreek.txt", header=TRUE) # header: read column names
View(AddisonCreek)

hist(AddisonCreek$FlowRate,freq=TRUE, main=expression(Flowrate(ft^3/sec)),breaks=c(seq(200,900,100),1200))
# main: name of graph
# expression: want to write mathematical symbols and expressions
# compare it with main = "Flowrate(ft^3/sec)"


##### Frequency Diagram & Normalized Freq. Diagram / pg.13 #####
install.packages("HistogramTools") # install
library(HistogramTools) # attach
PlotRelativeFrequency(hist(AddisonCreek$FlowRate, breaks=c(seq(200,900,100),1200)), main=expression(Flowrate(ft^3/sec)))

hist(AddisonCreek$FlowRate, freq=FALSE,main=expression(Flowrate(ft^3/sec)), breaks = c(seq(200,900,100),1200))


##### Cumulative Freq. Diagram & Box Plot / pg.14 #####
plot(ecdf(AddisonCreek$FlowRate), verticals=TRUE, pch="", main="")
quantile(AddisonCreek$FlowRate, 0.05, type=2)

quantile(AddisonCreek$FlowRate, type=2)
IQR(AddisonCreek$FlowRate, type=2)
boxplot(AddisonCreek$FlowRate) #4분위수


##### Scatter Diagram & plot() / pg.15 #####
flowrate = AddisonCreek[,3]
height = AddisonCreek[,4]

plot(flowrate, height, pch=20)

# marker symbols and line types
x = seq(0,2*pi, length.out=10) # 0, ~ 2pi
y = sin(x)
plot(x,y,pch=0,col="blue") # default: scatter plot (no lines, i.e. type="p")
plot(x,y,pch=17,col="blue") # pch: select marker symbol
plot(x,y,pch=23,col="blue",bg="red") # some marker symbol requires background color (bg)
plot(x,y,col="blue",type="l",lty=1) # type ="l": line only, lty: line type
plot(x,y,pch=23,col="blue",bg="red",type="p") # type = "p": markers only (default)
plot(x,y,pch=23,col="blue",bg="red",type="b",lty=2) # type = "b": both markers and lines


##### Numerical Descriptors / pg.16 #####
AddisonCreek = read.table("data/AddisonCreek.txt", header=TRUE)
FR = AddisonCreek$FlowRate
HT = AddisonCreek$Height

median(FR) # Median
quantile(FR, 0.5) # Median
mean(FR) # Sample mean
max(FR)-min(FR) # Range
IQR(FR) # IQR
mean(abs(FR-mean(FR))) # Mean Absolute Deviation
var(FR) # S. Variance
sd(FR) # S. Std. Deviation
sd(FR)/abs(mean(FR)) # S. Coefficient of Variation (C.O.V.)
install.packages("e1071")
library(e1071)
skewness(FR) # Skewness
cov(FR,HT) # S. Covariance
cor(FR,HT) # S. Correlation Coeff.


##### d/p/q/r + shortname / pg.18 #####
dnorm(2, mean=2, sd=1) # PDF of normal
pnorm(2, mean=2, sd=1) # CDF of normal
qnorm(0.5, mean=2, sd=1) # quantile at 0.5

x=seq(-3,7,0.1)
par(mfrow=c(2,1))
plot(x,dnorm(x, mean=2, sd=1),type="l",xlab="",ylab="PDF")
plot(x,pnorm(x, mean=2, sd=1),type="l",xlab="x",ylab="CDF")

mu = 2; sig = 1
xn = rnorm(100000, mean=mu, sd=sig)
hist(xn,freq=FALSE,breaks=seq(-3,7,0.1),col=rgb(1,0.6,0.3),ylim=c(0,0.6))cov = sig/abs(mu)
zeta = sqrt(log(1+cov^2))
lambda = log(mu)-0.5*zeta^2
xl = rlnorm(100000, meanlog = lambda, sdlog = zeta)
hist(xl,freq=FALSE,breaks=seq(0,30,0.1),col=rgb(0.3,0.6,1,0.5),add=T)

