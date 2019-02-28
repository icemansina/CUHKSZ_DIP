# -*- coding: utf-8 -*-
"""
Created on Thu Feb 28 14:28:27 2019

Adding Noise

@author: Zeng Bin
"""

import matplotlib.pyplot as plt
from skimage import io
from skimage.util import random_noise

plt.rcParams['font.size'] = 18

fig = plt.figure(figsize=(16, 9))
ax1, ax2 = fig.subplots(1, 2)
f = io.imread("./img.tif")
ax1.axis('off')
ax1.imshow(f, cmap='gray')
ax1.set_title("origin image")

# you can change param 'mode' to get different type of noise
mode = 'gaussian'
f_gaussian = random_noise(f, mode=mode, clip=True)
ax2.axis('off')
ax2.imshow(f, cmap='gray')
ax2.set_title("added %s noise" % mode)

if __name__ == '__main__':
    plt.show()

