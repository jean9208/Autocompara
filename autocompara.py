# -*- coding: utf-8 -*-
"""
Created on Wed Apr 13 21:16:54 2016

@author: jean
"""

#Importar librerias

import time
from selenium import webdriver
import os
from PIL import Image
from operator import itemgetter
import easygui
import xlrd
from selenium.common.exceptions import WebDriverException
import pandas as pd


#Definir directorio de trabajo

path = "/home/jean/Dropbox/Python_Scripts/"
os.chdir(path)

from pytesser import *


#Variables
#typ = "AUTOS"
#brand = "KIA"
#model = "2016"
#description = "FORTE EX AUT 2.0L 4CIL"


#AUTOCOMPARA

def scrape(typ,brand,model,description):

    
    
    
    
    aba = None    
    
    while not aba:
        try:
            
            path_to_chromedriver = "/home/jean/Documentos/chromedriver"
    
            mybrowser = webdriver.Chrome(executable_path = path_to_chromedriver)
            
            
            url = "https://www.autocompara.com/ExpressoAutoCompara/index.htm"
            
            mybrowser.get(url)
            
            time.sleep(10)
            
            #TIPO
            tipo = mybrowser.find_element_by_xpath('//*[(@id = "tipo")]/option[contains(text(), "'+typ+'")]')
            tipo.click()
            time.sleep(1)
            
            #MARCA
            marca = mybrowser.find_element_by_xpath('//*[(@id = "marca")]/option[contains(text(), "'+brand+'")]')
            marca.click()
            time.sleep(1)
            
            #MODELO
            modelo = mybrowser.find_element_by_xpath('//*[(@id = "modelo")]/option[contains(text(), "'+model+'")]')
            modelo.click()
            time.sleep(1)
            
            
            #DESCRIPCION
            vehiculo = mybrowser.find_element_by_xpath('//*[(@id = "vehiculo")]/option[contains(text(), "'+description+'")]')
            vehiculo.click()
            
            
            #Datos del asegurado
            name        = "Jose"
            first_name  = "Aguilar"
            last_name   = "Mendoza"
            mail        = "aaa@hotmail.com"
            cel         = "5556566778"
            
            nombre = mybrowser.find_element_by_xpath('//*[(@id = "nombre")]')
            nombre.send_keys(name)
            primer_apellido = mybrowser.find_element_by_xpath('//*[(@id = "apPaterno")]')
            primer_apellido.send_keys(first_name)
            segundo_apellido = mybrowser.find_element_by_xpath('//*[(@id = "apMaterno")]')
            segundo_apellido.send_keys( last_name )
            correo = mybrowser.find_element_by_xpath('//*[(@id = "eMail")]')
            correo.send_keys( mail )
            celular = mybrowser.find_element_by_xpath('//*[(@id = "Cel")]')
            celular.send_keys( cel )
            sexo = mybrowser.find_element_by_css_selector(".radio > label:nth-child(2)")
            sexo.click()
            dia = mybrowser.find_element_by_xpath('//*[(@id = "dia")]/option[contains(text(), "02")]')
            dia.click()
            mes = mybrowser.find_element_by_xpath('//*[(@id = "mes")]/option[contains(text(), "ENERO")]')
            mes.click()
            anio = mybrowser.find_element_by_xpath('//*[(@id = "anio")]/option[contains(text(), "1980")]')
            anio.click()
            
            #Zona
            codpost = "55717"
            cp = mybrowser.find_element_by_xpath('//*[(@id = "cp")]')
            cp.send_keys( codpost )
            
            
            #Cotizar
            cotizar = mybrowser.find_element_by_xpath('//*[(@id = "cotizar")]')
            cotizar.click()
            
            time.sleep(3)
            mybrowser.save_screenshot('autocompara/captcha.png')
            
            pre_captcha = mybrowser.find_element_by_css_selector('#nodo > p:nth-child(1)')
            location = pre_captcha.location
            size = pre_captcha.size
            left = location['x'] 
            top = location['y'] 
            right = left + size['width']
            bottom = top + size['height']
            imm = Image.open("autocompara/captcha.png") 
            imm2 = imm.crop((left, int(top-size['height']), right, int(top)))
            imm2.save("autocompara/captcha_crop.png")
            
            imf = Image.new("P",imm2.size,255)
            
            
            temp = {}
            
            for x in range(imm2.size[1]):
              for y in range(imm2.size[0]):
                r,g,b = imm2.getpixel((y,x))
                if r > 180 and g >180 and b < 100 : #or pix == 221: # these are the numbers to get
                  imf.putpixel((y,x),0)
            
            
            imf.save("captcha_nocolor.gif")
            
            
            os.system('convert captcha_nocolor.gif -auto-level -compress none captcha.tif')
            
            imff = Image.open("captcha.tif")
            texto = image_to_string(imff)
            
            
            
            #Captcha
            cap = mybrowser.find_element_by_xpath( '//*[(@id = "uword")]')
            cap.send_keys(texto[0:6])
            but =  mybrowser.find_element_by_xpath('//*[@id="nodo"]/p[3]/input[2]')
            but.click()
            
            time.sleep(10)
            
            #Obtener precios
            aba = mybrowser.execute_script("return document.getElementById('abaAnual').value;")
            aig = mybrowser.execute_script("return document.getElementById('chartisAnual').value;")
            atlas = mybrowser.execute_script("return document.getElementById('atlasAnual').value;")
            axa = mybrowser.execute_script("return document.getElementById('axaAnual').value;")
            gnp = mybrowser.execute_script("return document.getElementById('gnpAnual').value;")
            hdi = mybrowser.execute_script("return document.getElementById('hdiAnual').value;")
            inbursa = mybrowser.execute_script("return document.getElementById('inbAnual').value;")
            mapfre = mybrowser.execute_script("return document.getElementById('mapAnual').value;")
            qualitas = mybrowser.execute_script("return document.getElementById('quaAnual').value;")
            zurich = mybrowser.execute_script("return document.getElementById('zurichAnual').value;")
            mybrowser.close()
            os.system("rm /home/jean/Dropbox/Python_Scripts/autocompara/captcha.png")
            os.system("rm /home/jean/Dropbox/Python_Scripts/autocompara/captcha_crop.png")
            os.system("rm /home/jean/Dropbox/Python_Scripts/captcha_nocolor.gif")
            os.system("rm /home/jean/Dropbox/Python_Scripts/captcha.tif")
    
            pre = [aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich]
            break
        except WebDriverException:
            aba = 0
            aig = 0
            atlas = 0
            axa = 0
            gnp = 0
            hdi = 0
            inbursa = 0
            mapfre = 0
            qualitas = 0
            zurich = 0
            mybrowser.close()
            os.system("rm /home/jean/Dropbox/Python_Scripts/autocompara/captcha.png")
            os.system("rm /home/jean/Dropbox/Python_Scripts/autocompara/captcha_crop.png")
            os.system("rm /home/jean/Dropbox/Python_Scripts/captcha_nocolor.gif")
            os.system("rm /home/jean/Dropbox/Python_Scripts/captcha.tif")
            
            pre = [aba,aig,atlas,axa,gnp,hdi,inbursa,mapfre,qualitas,zurich]
            break
    return pre
    
    
    

file_to_scrape  = easygui.fileopenbox()
   

wb = xlrd.open_workbook(file_to_scrape)

wb_cotz = wb.sheet_by_index(0)

prices = []

for rows in range(wb_cotz.nrows):
    typ         = wb_cotz.row(rows)[0]
    brand       = wb_cotz.row(rows)[1]
    model       = wb_cotz.row(rows)[2]
    description = wb_cotz.row(rows)[3]
    typ         = typ.value
    brand       = brand.value
    model       = str(int(model.value))
    description = description.value
    z = scrape(typ,brand,model,description)
    prices.append(z)
    del z
  

#import csv
  
base = pd.read_excel(file_to_scrape, sheetname = 0) 
to_base = pd.DataFrame(prices)
prices_merged = pd.concat([base, to_base], axis = 1)
prices_merged.columns = ['TIPO', 'MARCA','MODELO','VERSION','ABA','AIG',
                         'ATLAS', 'AXA', 'GNṔ', 'HDI', 'INBURSA', 'MAPFRE',
                         'QUALITAS', 'ZURICH']
prices_merged.to_excel("autocompara/prices.xlsx")                        

#myfile = open("prices.csv", 'wb')
#wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
#wr.writerow(prices)


