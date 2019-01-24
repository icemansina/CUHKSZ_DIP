# coding: utf-8
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from skimage import io, util
from skimage import data
from scipy.ndimage import convolve
from scipy.signal import medfilt
from demo import read, show


I = read('imgs/Fig0219.tif') 
show(I, 'raw_image', 'gray')

# add random noisy
I1 = util.random_noise(I, mode='gaussian')
show(I1, 'after adding noisy', 'gray')

# apply a median filter
I2 = medfilt(I1)
show(I2, 'using median filter', 'gray')







