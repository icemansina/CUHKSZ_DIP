# -*- coding: utf-8 -*-
"""
Created on Thu Feb 28 14:28:27 2019

Spatial Noise Filters

@author: Zeng Bin
"""

import matplotlib.pyplot as plt
from skimage import io
from skimage.util import random_noise
from skimage.morphology import disk
from skimage.filters import rank

plt.rcParams['font.size'] = 18

fig = plt.figure(figsize=(16, 9))

f = io.imread("./img.tif")
f_pepper = random_noise(f, mode='pepper', clip=True)
ax1 = fig.add_subplot(221)
ax1.axis('off')
ax1.imshow(f_pepper, cmap='gray')
ax1.set_title("image with pepper noise")

f_salt = random_noise(f, mode='salt', clip=True)
ax2 = fig.add_subplot(222)
ax2.axis('off')
ax2.imshow(f_salt, cmap='gray')
ax2.set_title("image with salt noise")


f1 = rank.maximum(f_pepper, disk(3))
ax3 = fig.add_subplot(223)
ax3.axis('off')
ax3.imshow(f1, cmap='gray')
ax3.set_title("maximum")

f2 = rank.minimum(f_salt, disk(3))
ax4 = fig.add_subplot(224)
ax4.axis('off')
ax4.imshow(f2, cmap='gray')
ax4.set_title("minimum")


if __name__ == '__main__':
    plt.show()

