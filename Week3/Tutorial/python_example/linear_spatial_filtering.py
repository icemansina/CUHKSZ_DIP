# coding: utf-8
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from skimage import io
from skimage import data
from scipy.ndimage import convolve
from demo import read, show
I = read('imgs/Fig0216.tif') 
show(I, 'raw_image')

# get a filter
f = np.ones((31,31))
# nearest is same as replicate in matlab
I1 = convolve(I, f, mode='nearest')
I2 = convolve(I, f, mode='mirror')
I3 = convolve(I, f, mode='constant', cval=0)
show(I1, 'using nearest padding')
show(I2, 'using mirror padding')
show(I3, 'using constant 0 padding')






