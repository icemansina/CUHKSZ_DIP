from __future__ import division
from numpy import array, zeros, abs
from numpy.fft import fft2, ifft2
from PIL import Image
from matplotlib.pyplot import imshow, show, subplot, figure, gray, title, axis
import numpy as np

def matlab_style_gauss2D(shape=(5,5),sigma=0.5):
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

def gaussian(im):
    b = matlab_style_gauss2D(shape=(5,5), sigma=0.1)
    kernel = zeros(im.shape)
    kernel[:b.shape[0], :b.shape[1]] = b

    fim = fft2(im)
    fkernel = fft2(kernel)
    fil_im = ifft2(fim * fkernel)

    return abs(fil_im).astype(int)

if __name__ == "__main__":
    from sys import argv
    if len(argv) < 2:
        print("Usage: python %s <image>" % argv[0])
        exit()
    im = array(Image.open(argv[1]))
    im = im[:, :, 0]
    gray()

    subplot(1, 2, 1)
    imshow(im)
    axis('off')
    title('Original')

    subplot(1, 2, 2)
    imshow(gaussian(im))
    axis('off')
    title('Filtered')

    show()
