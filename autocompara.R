#AUTOCOMPARA

#Load Libraries
library(RSelenium)

autocompara <- function(type, brand, model, description){
  
  #Phantomjs
  #pJS <- phantom()
  
  #Run if it's the first time on Selenium
  checkForServer()
  
  #Connect to a running server
  mybrowser <- remoteDriver(browserName="chrome")
  #mybrowser <- remoteDriver(browserName="phantomjs")
  
  #Create a server (only for chromedriver)
  startServer()
  
  mybrowser$open()
  
  url <- "https://www.autocompara.com/ExpressoAutoCompara/index.htm"
  
  mybrowser$navigate(url)
  Sys.sleep(5)
  
  
  ###
  email <- "abcd@hotmail.com"
  correo <- mybrowser$findElement(using = 'xpath', '//*[(@id = "eMail")]')
  #correo$clickElement()
  #correo$clearElement()
  correo$sendKeysToElement( list(email))


  #mybrowser$executeScript("document.getElementById('eMail').value='{0}';",email)
  ###
  
  #Set Type
  #type <- "AUTOS"
  tipo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "tipo")]/option[contains(text(), "',type,'")]'))
  tipo$clickElement()
  Sys.sleep(1)
  
  #Set Brand
  #brand <- "KIA"
  marca <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "marca")]/option[contains(text(), "',brand,'")]'))
  marca$clickElement()
  Sys.sleep(1)
  
  
  #Set Model
  #model <- "2016"
  modelo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "modelo")]/option[contains(text(), "',model,'")]'))
  modelo$clickElement()
  Sys.sleep(1.5)
  
  #Set make
  #description <- "FORTE EX AUT 2.0L 4CIL"
  vehiculo <- mybrowser$findElement(using = 'xpath', paste0('//*[(@id = "vehiculo")]/option[contains(text(), "',description,'")]'))
  vehiculo$clickElement()
  Sys.sleep(1)
  
  #Set client variables
  name <- "Jose"
  first_name <- "Aguilar"
  last_name <- "Mendoza"
  #email <- "aaa@hotmail.com"
  cel <- "5556566778"
  
  nombre <- mybrowser$findElement(using = 'xpath', '//*[(@id = "nombre")]')
  nombre$sendKeysToElement( list(name) )
  primer_apellido <- mybrowser$findElement(using = 'xpath', '//*[(@id = "apPaterno")]')
  primer_apellido$sendKeysToElement( list(first_name) )
  segundo_apellido <- mybrowser$findElement(using = 'xpath', '//*[(@id = "apMaterno")]')
  segundo_apellido$sendKeysToElement( list(last_name) )
  #correo <- mybrowser$findElement(using = 'xpath', '//*[(@id = "eMail")]')
  #correo$clickElement()
  #correo$clearElement()
  #correo$sendKeysToElement( list('aaa@hotmail.com') )
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
  Sys.sleep(5)
  
  while(exists("plan")==F){
    
  
  #Save screenshot
  mybrowser$screenshot(file = "auto_captcha.png")
  
  
  #Crop the captcha
  
  system("python img_nocolor.py")
  
  system("python solve_captcha.py")
  
  solved <- readLines("solved.txt")[1]
  
  #Captcha
  cap <- mybrowser$findElement(using = 'xpath', '//*[(@id = "uword")]')
  cap$sendKeysToElement( list(solved) )
  but<- mybrowser$findElement(using = 'xpath', '//*[@id="nodo"]/p[3]/input[2]')
  but$clickElement()
  Sys.sleep(10)
  
  
  #Validation
  try(plan <- mybrowser$findElement(using = 'xpath','//*[(@id = "plan")]'), T)
  
  }
  
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

  #pre = list(aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich)
  #prices <- unlist(pre)
  
  output <- c(ABA = aba, AIG = aig,
              ATLAS = atlas, AXA = axa,
              GNP = gnp, HDI = hdi,
              INBURSA = inbursa, MAPFRE = mapfre,
              QUALITAS = qualitas, ZURICH = zurich,DATE = as.character(as.Date(Sys.time())))
  
  #Erase variables
  rm(aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich)

  #Close webdriver
  
  mybrowser$close()
  
  #Close phantomjs
  #pJS$stop()
  
  
  
  return(output)
}



