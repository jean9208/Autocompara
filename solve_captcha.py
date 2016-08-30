# -*- coding: utf-8 -*-
"""
Created on Tue Aug 30 00:04:42 2016

@author: Jean
"""

#Edit pytesser.py
#Change "import Image" to "from PIL import Image"


from pytesser import *

imff = Image.open("C:\Users\Jean\Documents\Autocompara\prueba.png")
texto = image_to_string(imff)

file = open("solved.txt", "w") 
file.write(texto)