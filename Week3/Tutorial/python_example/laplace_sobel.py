# coding: utf-8
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from skimage import io, util
from skimage import data
from scipy.ndimage import convolve,laplace,sobel
from scipy.signal import medfilt
from demo import read, show


I = read('imgs/lenna.tif') 
show(I, 'raw_image', 'gray')

# apply laplace filter
I1 = laplace(I)
show(I1, 'after applying laplace filter', 'gray')


# apply a gussian filter
I2 = sobel(I)
show(I2, 'after applying sobel filter', 'gray')




