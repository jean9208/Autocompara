#AUTOCOMPATRA

#Limpiar area de trabajo

rm( list = ls() )

#Cargar librerias
library( RSelenium )
library( rvest )

#Ejecutar si es la primera vez con Selenium
#checkForServer()

mybrowser <- remoteDriver(browserName="chrome")

mybrowser$open()

url <- "https://www.autocompara.com/ExpressoAutoCompara/index.htm"

mybrowser$navigate(url)


#TIPO
type <- "AUTOS"
tipo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "tipo")]/option[contains(text(), "',type,'")]'))
tipo$clickElement()

#MARCA
brand <- "KIA"
marca <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "marca")]/option[contains(text(), "',brand,'")]'))
marca$clickElement()

#MODELO
model <- "2016"
modelo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "modelo")]/option[contains(text(), "',model,'")]'))
modelo$clickElement()

#DESCRIPCION
description <- "FORTE EX AUT 2.0L 4CIL"
vehiculo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "vehiculo")]/option[contains(text(), "',description,'")]'))
vehiculo$clickElement()

#Datos del asegurado
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

#Zona
codpost <- "55717"
cp <- mybrowser$findElement(using = 'xpath', '//*[(@id = "cp")]')
cp$sendKeysToElement( list(codpost) )


#Cotizar
cotizar <- mybrowser$findElement(using = 'xpath', '//*[(@id = "cotizar")]')
cotizar$clickElement()

#Captcha
cap <- mybrowser$findElement(using = 'xpath', '//*[(@id = "uword")]')
cap$sendKeysToElement( list('edomdn') )
but<- mybrowser$findElement(using = 'xpath', '//*[@id="nodo"]/p[3]/input[2]')
but$clickElement()

#Obtener html fuente
code <- mybrowser$getPageSource()
page <- read_html(code[[1]]) #Convertir a xml
