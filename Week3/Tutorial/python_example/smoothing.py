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
show(I, 'raw_image','gray')

# get an average filter

r = 10
f = np.full((r,r),1/r**2)

I1 = convolve(I, f)
show(I1, 'after applying average filter', 'gray')

def matlab_style_gauss2D(shape=(3,3),sigma=0.5):
    """
    2D gaussian mask - should give the same result as MATLAB's
    fspecial('gaussian',[shape],[sigma])
    """
    m,n = [(ss-1.)/2. for ss in shape]
    y,x = np.ogrid[-m:m+1,-n:n+1]
    h = np.exp( -(x*x + y*y) / (2.*sigma*sigma) )
    h[ h < np.finfo(h.dtype).eps*h.max() ] = 0
    sumh = h.sum()
    if sumh != 0:
        h /= sumh
    return h


# apply a gussian filter
sigma=10
r = 50
f = matlab_style_gauss2D(shape=(r,r), sigma=sigma)
I2 = convolve(I, f)
show(I2, 'using gaussian filter with sigma %.02f' % sigma, 'gray')







