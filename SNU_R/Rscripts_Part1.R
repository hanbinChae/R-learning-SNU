##### "R... a powerful calculator" / pg.6 #####
a = pi; a
b <- 2.0; b
c1 <- a; c1
b -> c2; c2
sin(c1*c2)

i = complex(real=0, imaginary=1)
exp(i*pi) == cos(pi)+i*sin(pi)
exp(i*pi) != cos(pi)+i*sin(pi)


##### Types of Data and Data Structures in R / pg.7 #####
x = 1.25 # numerical
y = "Hello" # character
z = x > 3 # logical


##### Data Type: Vector (1D Array) / pg.8 #####
v1 = c(1.3, 2*pi, sqrt(2))
v1[3]

v2 = v1*2
v3 = v1+3
v4 = v2*v3 # Element-wise multiplication
v5 = v3*v3^(-1) # Element-wise inversion and product 
v1 <= 1.3 # Element-wise logical operation

c(1:10)
c(1,3:10)
array(1:3,8) # Repeat 1:3 but NOT exceed 8
seq(1,10) # 1 to 10 (default increment = 1)
seq(1,10, by=2) # Increment = 2
seq(1,10, length.out=3) # Increment automatically determined for 3 elements

v1[c(1,3)] # 1st and 3rd element only
v1[v1>1.3] # elements greater than 1.3 only
v1[-2] # Excluding 2nd element
which(v1>1.3) # Locating elements satisfying the equation


##### Data Type: Matrix (2D Array) / pg.9 #####
matrix(0,2,5) # matrix of zeros, 2x5
matrix(1:12, nrow=3) # Put 1 to 12 into 3x? matrix (column-wise)
matrix(1:12, ncol=3, byrow=TRUE) # row-wise

m = 1:6
dim(m) = c(2,3) # vector to 2x3 matrix

y = matrix(c(1,3:17),4,4) # 4x4 matrix with 1,3,?€?,17
y[2,3] # Element at 2nd row and 3rd column
y[2,] # 2nd row
y[,2] # 2nd column
y[3] # 3rd element in column-wise sequence
y[1:2, 3:4] # submatrix: 1st and 2nd rows + 3rd and 4th columns

?quakes # '?' to get help regarding data, packages and functions
dim(quakes) # check the dimension of the matrix
View(quakes)
summary(quakes) # summarize the data set
head(quakes) # show the first few rows
pairs(quakes, main = "Fiji Earthquakes, N = 1000", cex.main = 1.2, pch = "o") # Create a scatterplot matrices


##### Data Type: Data Frame / pg.10 #####
cities = c("Berlin", "New York", "Paris", "Tokyo")
area = c(892, 1214, 105, 2188)
population = c(3.4, 8.1, 2.1, 12.9)
continent = factor(c("Europe", "North America", "Europe", "Asia"))
myframe = data.frame(cities, area, population, continent)
rownames(myframe) = c("Berlin", "New York", "Paris", "Tokyo")
colnames(myframe) = c("City", "Area", "Pop.", "Continent")

f = factor(c("Inland", "Coastal", "Inland", "Coastal"))
myframe = data.frame(myframe, f)
colnames(myframe)[5] = "Prox.Sea"

myframe$Area
myframe[,2]
myframe[,"Area"]

?CO2 
dim(CO2) 
summary(CO2)
View(CO2)
plot(CO2[,"conc"],CO2[,"uptake"])