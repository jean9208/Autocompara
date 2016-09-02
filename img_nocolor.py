# -*- coding: utf-8 -*-
"""
Created on Thu Sep 01 23:45:57 2016

@author: Jean
"""

from PIL import Image

im = Image.open("Autocompara/auto_captcha.png.png") 

imf = Image.new("P",im.size,255)
            
temp = {}
            
for x in range(im.size[1]):
    for y in range(im.size[0]):
        r,g,b = im.getpixel((y,x))
        if r > 180 and g >180 and b < 100 : #or pix == 221: # these are the numbers to get
            imf.putpixel((y,x),0)
            
imf.save("Autocompara/auto_captcha_nocolor.gif")