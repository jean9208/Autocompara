#Scraper

rm( list = ls() )

init <- Sys.time()

library(readxl)

source("Autocompara.R")


#type        <- "AUTOS"
#brand       <- "KIA"
#model       <- "2016"
#description <- "FORTE EX AUT 2.0L 4CIL"

cuam <- read_excel(path = "CUAM.xlsx", sheet = 1, col_types = rep("text",4))

names(cuam) <- c("TYPE","BRAND","MODEL","DESCRIPTION")

#cuam$DESCRIPTION <- gsub("  "," ",cuam$DESCRIPTION)


#autocompara(type, brand, model, description)

prices <- data.frame(matrix(NA,nrow(cuam),11))


names(prices) <-  c("ABA", "AIG",
                    "ATLAS", "AXA",
                    "GNP", "HDI",
                    "INBURSA", "MAPFRE",
                    "QUALITAS", "ZURICH",
                    "DATE")

prices$DATE <- as.Date(prices$DATE)

ind <- 63
i=0

while(i<= nrow(cuam)){

for (i in ind+1:nrow(cuam)){
  
  cot <-  c(autocompara(cuam[i,"TYPE"], cuam[i,"BRAND"], 
                      cuam[i,"MODEL"], cuam[i,"DESCRIPTION"]))


  
  prices[i,] <- cot
  
  ind <- i
}
}

Sys.time() - init
