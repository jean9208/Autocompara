#Scraper

rm( list = ls() )

source("Autocompara.R")

type        <- "AUTOS"
brand       <- "KIA"
model       <- "2016"
description <- "FORTE EX AUT 2.0L 4CIL"

autocompara(type, brand, model, description)
  
