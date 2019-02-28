# -*- coding: utf-8 -*-
"""
Created on Thu Feb 28 14:28:27 2019

Adaptive Spatial Filters

@author: Zeng Bin
"""

# scipy.signal.medfilt2d

import matplotlib.pyplot as plt
from skimage import io
from skimage.util import random_noise
from skimage.filters import threshold_local
from skimage.morphology import disk
from skimage.filters import rank

plt.rcParams['font.size'] = 18

fig = plt.figure(figsize=(16, 9))
# ax1, ax2, ax3, ax4, ax5, ax6 = fig.subplots(2, 3)
f = io.imread("./img.tif")
f_sp = random_noise(f, mode='s&p', salt_vs_pepper=0.25, clip=True)
ax1 = fig.add_subplot(131)
ax1.axis('off')
ax1.imshow(f_sp, cmap='gray')
ax1.set_title("image with s&p noise")

f1 = rank.median(f_sp, disk(7))
ax2 = fig.add_subplot(132)
ax2.axis('off')
ax2.imshow(f1, cmap='gray')
ax2.set_title("median filter of size 7*7")

f2 = threshold_local(f_sp, 7, 'mean')
ax3 = fig.add_subplot(133)
ax3.axis('off')
ax3.imshow(f2, cmap='gray')
ax3.set_title("adaptive median filtering")

if __name__ == '__main__':
    plt.show()

