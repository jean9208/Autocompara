#AUTOCOMPARA

#Clean workspace

rm( list = ls() )

#Set working space
setwd("Autocompara")

#Load Libraries
library( RSelenium )
library( rvest )

#Run if it's the first time on Selenium
#checkForServer()

#Connect to a running server
mybrowser <- remoteDriver(browserName="chrome")

#Create a server
startServer()

mybrowser$open()

url <- "https://www.autocompara.com/ExpressoAutoCompara/index.htm"

mybrowser$navigate(url)


#Set Type
type <- "AUTOS"
tipo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "tipo")]/option[contains(text(), "',type,'")]'))
tipo$clickElement()

#Set Brand
brand <- "KIA"
marca <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "marca")]/option[contains(text(), "',brand,'")]'))
marca$clickElement()

#Set Model
model <- "2016"
modelo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "modelo")]/option[contains(text(), "',model,'")]'))
modelo$clickElement()

#Set make
description <- "FORTE EX AUT 2.0L 4CIL"
vehiculo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "vehiculo")]/option[contains(text(), "',description,'")]'))
vehiculo$clickElement()

#Set client variables
name <- "Jose"
first_name <- "Aguilar"
last_name <- "Mendoza"
mail <- "aaa@hotmail.com"
cel <- "5556566778"

nombre <- mybrowser$findElement(using = 'xpath', '//*[(@id = "nombre")]')
nombre$sendKeysToElement( list(name) )
primer_apellido <- mybrowser$findElement(using = 'xpath', '//*[(@id = "apPaterno")]')
primer_apellido$sendKeysToElement( list(first_name) )
segundo_apellido <- mybrowser$findElement(using = 'xpath', '//*[(@id = "apMaterno")]')
segundo_apellido$sendKeysToElement( list(last_name) )
correo <- mybrowser$findElement(using = 'xpath', '//*[(@id = "eMail")]')
correo$sendKeysToElement( list(mail) )
celular <- mybrowser$findElement(using = 'xpath', '//*[(@id = "Cel")]')
celular$sendKeysToElement( list(cel) )
sexo <- mybrowser$findElement(using = "css", ".radio > label:nth-child(2)")
sexo$clickElement()
dia <- mybrowser$findElement(using = 'xpath', '//*[(@id = "dia")]/option[contains(text(), "02")]')
dia$clickElement()
mes <- mybrowser$findElement(using = 'xpath', '//*[(@id = "mes")]/option[contains(text(), "ENERO")]')
mes$clickElement()
anio <- mybrowser$findElement(using = 'xpath', '//*[(@id = "anio")]/option[contains(text(), "1980")]')
anio$clickElement()

#Postal Code
codpost <- "55717"
cp <- mybrowser$findElement(using = 'xpath', '//*[(@id = "cp")]')
cp$sendKeysToElement( list(codpost) )


#Cotizar
cotizar <- mybrowser$findElement(using = 'xpath', '//*[(@id = "cotizar")]')
cotizar$clickElement()

#Save screenshot
mybrowser$screenshot(file = "Autocompara//auto_captcha.png")


#Crop the captcha
library(png)
library(grid)
cap <- readPNG("Autocompara//auto_captcha.png")
png("Autocompara//auto_captcha_crop.png")
grid.raster(cap[60:110,390:580,])
dev.off()

##################################################################
#Change colors and convert to tiff
cap <- readPNG("Autocompara//auto_captcha_crop.png")
png("Autocompara//auto_captcha_nocolor.png")
grid.raster(cap[,,3])
dev.off()

########################################################
library("gridExtra")

# copy the image three times
cap.R <- cap
cap.G <- cap
cap.B <- cap

# zero out the non-contributing channels for each image copy
cap.R[,,2:3] <- 0
cap.G[,,1]   <- 0
cap.G[,,3]   <- 0
cap.B[,,1:2] <- 0

# build the image grid
img1 <- rasterGrob(cap.R)
img2 <- rasterGrob(cap.G)
img3 <- rasterGrob(cap.B)
#grid.arrange(img1, img2, img3, nrow=1)

# reshape image into a data frame
df <- data.frame(
  red = matrix(cap[,,1], ncol=1),
  green = matrix(cap[,,2], ncol=1),
  blue = matrix(cap[,,3], ncol=1)
)

### compute the k-means clustering
K <- kmeans(df,3)
df$label <- K$cluster

### Replace the color of each pixel in the image with the mean 
### R,G, and B values of the cluster in which the pixel resides:

# get the coloring
colors <- data.frame(
  label = 1:nrow(K$centers), 
  R = K$centers[,"red"],
  G = K$centers[,"green"],
  B = K$centers[,"blue"]
)

# merge color codes on to df
# IMPORTANT: we must maintain the original order of the df after the merge!
df$order <- 1:nrow(df)
df <- merge(df, colors)
df <- df[order(df$order),]
df$order <- NULL

# get mean color channel values for each row of the df.
R = matrix(df$R, nrow=dim(cap)[1])
G = matrix(df$G, nrow=dim(cap)[1])
B = matrix(df$B, nrow=dim(cap)[1])

# reconstitute the segmented image in the same shape as the input image
cap.segmented <- array(dim=dim(cap))
cap.segmented[,,1] <- R
cap.segmented[,,2] <- G
cap.segmented[,,3] <- B

png("Autocompara//auto_captcha_proc.png")
grid.raster(cap.segmented)
dev.off()
#######################################################




#Use Tesseract to extract text from the tif image
#Instructions for installing "ocR" can be found here:
#https://github.com/greenore/ocR
library(ocR)

ocrTesseract("C:\\Users\\Jean\\Documents\\Autocompara",
             "prueba.png",
             "cap.txt")
######################################################
library(imager)

captcha <- load.image("Autocompara//auto_captcha_crop.png")

#####################################################

system("python solve_captcha.py")

solved <- readLines("solved.txt")[1]

#Captcha
cap <- mybrowser$findElement(using = 'xpath', '//*[(@id = "uword")]')
cap$sendKeysToElement( list('ijhnlp') )
but<- mybrowser$findElement(using = 'xpath', '//*[@id="nodo"]/p[3]/input[2]')
but$clickElement()


#Obtain prices through javascript

aba = mybrowser$executeScript("return document.getElementById('abaAnual').value;")
aig = mybrowser$executeScript("return document.getElementById('chartisAnual').value;")
atlas = mybrowser$executeScript("return document.getElementById('atlasAnual').value;")
axa = mybrowser$executeScript("return document.getElementById('axaAnual').value;")
gnp = mybrowser$executeScript("return document.getElementById('gnpAnual').value;")
hdi = mybrowser$executeScript("return document.getElementById('hdiAnual').value;")
inbursa = mybrowser$executeScript("return document.getElementById('inbAnual').value;")
mapfre = mybrowser$executeScript("return document.getElementById('mapAnual').value;")
qualitas = mybrowser$executeScript("return document.getElementById('quaAnual').value;")
zurich = mybrowser$executeScript("return document.getElementById('zurichAnual').value;")
mybrowser.close()

pre = list(aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich)
prices <- unlist(pre)

#Erase variables
rm(aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich)

#Close webdriver

mybrowser$close()

