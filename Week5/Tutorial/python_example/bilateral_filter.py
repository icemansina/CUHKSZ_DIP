# -*- coding: utf-8 -*-
"""
Created on Thu Feb 28 14:28:27 2019

Bilateral Filter

@author: Zeng Bin
"""

import cv2
import matplotlib.pyplot as plt

plt.rcParams['font.size'] = 18


img = cv2.imread("img.tif", 0)
new = cv2.bilateralFilter(img, 3, 140, 140)


plt.figure(2)
plt.gray()
plt.subplot(121)
plt.imshow(img)
plt.title("raw image")

plt.subplot(122)
plt.imshow(new)
plt.title("after filtering")

plt.show()

