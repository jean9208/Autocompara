# -*- coding: utf-8 -*-
"""
Created on Thu Sep 01 23:45:57 2016

@author: Jean
"""

from PIL import Image

imm = Image.open("auto_captcha.png") 
imm2 = imm.crop((334, 68,639, 125))
#imm2 = imm.crop((16, 62,376, 130))
imm2.save("auto_captcha_crop.png")
            
imf = Image.new("P",imm2.size,255)
            
            
temp = {}
     
#For phantomjs
       
#for x in range(imm2.size[1]):
#    for y in range(imm2.size[0]):
#        r,g,b,a = imm2.getpixel((y,x))
#        if r > 180 and g >180 and b < 100: #or pix == 221: # these are the numbers to get
#            imf.putpixel((y,x),0)
            
            
for x in range(imm2.size[1]):
    for y in range(imm2.size[0]):
        r,g,b = imm2.getpixel((y,x))
        if r > 180 and g >180 and b < 100: #or pix == 221: # these are the numbers to get
            imf.putpixel((y,x),0)            
            
imf.save("auto_captcha_nocolor.gif")