##### MLE by R / pg.22 #####
library(stats4) # package which contains MLE: comes with base R (no installation needed)
subway = read.table('subway.txt', header=TRUE, na = "-", fileEncoding = "CP949", encoding = "UTF-8")
sub0607 = subway$use0607 # number of subway passengers from each DONG in Seoul (6-7am)
hist(sub0607, breaks=seq(0,max(sub0607),max(sub0607)/20))

# User-defined function to compute log-likelihood function
LL = function(meanlog, sdlog) {
  Probs = suppressWarnings(dlnorm(sub0607, meanlog, sdlog)) 
  # ignore warning message during optimization: not important
  -sum(log(Probs)) # Log-Likelihood function
}

MLE_result = mle(LL, start=list(meanlog=10, sdlog=10)) 
# parameter estimation by MLE; start: setting initial value of the search
lambda = unname(MLE_result@coef['meanlog']) 
# unname : delete name of a list
zeta = unname(MLE_result@coef['sdlog'])


##### Interval Estimate / pg.23 #####
ParEst_knownsd = function(n, mean, sd, alpha){
  z_halfalpha = qnorm(1-alpha/2) # use qt(1-alpha/2, n-1) instead if sigma is unknown
  lb = mean-z_halfalpha*sd/sqrt(n)
  ub = mean+z_halfalpha*sd/sqrt(n)
  return(c(lb, ub))
}
ParEst_knownsd(20, 14, 2.5, 0.01)

ProportionEst = function(n, x, alpha){
  z_halfalpha = qnorm(1-alpha/2)
  pro = x/n
  lb = pro-z_halfalpha*sqrt(pro*(1-pro)/n)
  ub = pro+z_halfalpha*sqrt(pro*(1-pro)/n)
  return(c(lb,ub))
}

ProportionEst(50, 3, 0.05)


##### Hypothesis Testing / pg.24 #####
# t.test (hypothesis testing on mu under unknown sigma)
Ex22 = c(8.3, 5.6, 4.6, 9.3, 8.8, 6.5, 6.9, 7.1, 4.7, 9.2)
t.test(Ex22, alternative="greater", mu=5, conf.level=0.99)
t.test(Ex22, alternative="two.sided", mu=5, conf.level=0.99)
# one-sided: "greater" or "less"
# two-sided: "two.sided"
# conf.level: (1-alpha) for interval estimate

# z.test (hypothesis testing on mu under known sigma)
install.packages("BSDA")
library(BSDA)
z.test(Ex22, alternative="greater", mu=5, sigma.x=3, conf.level=0.99)


##### Goodness-of-Fit Test: Probability Plot / pg.25 #####
xn = rnorm(10000,2,4)
xg = rgamma(10000,shape=1,rate=1/2) 
install.packages("e1071")
library(e1071)

probplot(xn, qdist=qnorm) # Case 1
probplot(xn, qdist=qlnorm) # Case 2
probplot(xg, qdist=qgamma, shape=1) # Case 3 


##### Goodness-of-Fit Test: Kolmogorov-Smirnov Test / pg.26 #####
FT = c(69.5,71.9,72.6,73.1,73.3,73.5,74.1,74.2,75.3,75.5,75.7,75.8,76.1,76.2,
       76.3,76.9,77.0,77.9,78.1,79.6,79.7,79.9,80.1,82.2,83.7,93.7) # Add a small noise for identical entries

# One-sample ks-test
ks.test(FT,"pnorm",mean(FT),sd(FT), alternative=c("two.sided"))

# Kolmogorov-Smirnov Test by R 
DS1 = rnorm(100,0,1) 
DS2 = rnorm(100,1,1) 

# Two-sample (sample vs sample) ks-test
ks.test(DS1, DS2, alternative=c("two.sided"))
ks.test(DS1, DS2, alternative=c("greater"))
ks.test(DS1, DS2, alternative=c("less"))


##### Linear Regression by R / 28.pg #####
rm(list=ls())
concrete=read.table("concrete.txt", header=TRUE)

str = concrete$Strength # Concrete strength
cem = concrete$Cement # Cement amount

reg1 = lm(str~cem)

coef(reg1)
summary(reg1)

cem_v = seq(min(cem),max(cem),5) # create a vector for cement amount
str_ci = predict(reg1, data.frame(cem = cem_v),interval = c("confidence"),level=0.68)
str_pi = predict(reg1, data.frame(cem = cem_v),interval = c("prediction"),level=0.68)

# Plot with CI and PI
plot(str~cem)
abline(reg1,col='red')
lines(cem_v,str_ci[,2],col='blue',lty=2)
lines(cem_v,str_ci[,3],col='blue',lty=2) # blue curves for CI
lines(cem_v,str_pi[,2],col='green',lty=3)
lines(cem_v,str_pi[,3],col='green',lty=3) # green curves for PI

# Other results from 'lm' object:
# fitted(reg1): fitted results at the data points
# resid(reg1): residuals at the data points
# predict(reg1,...): predict using the regression model
predict(reg1,data.frame(cem=c(100,200,300,400,500))) # use the same name 'cem'

