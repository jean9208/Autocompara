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

prices <-  apply(cuam, 1, function(x) autocompara(x["TYPE"],x["BRAND"], x["MODEL"], x["DESCRIPTION"]))
prices_t <- t(prices)
prices_t <- data.frame(prices_t)

names(prices_t) <-  c("ABA", "AIG",
                      "ATLAS", "AXA",
                      "GNP", "HDI",
                      "INBURSA", "MAPFRE",
                      "QUALITAS", "ZURICH")

cotizaciones <- cbind(cuam,prices_t)

Sys.time() - init
