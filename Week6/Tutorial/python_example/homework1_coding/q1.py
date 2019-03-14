# coding: utf-8

import numpy as np
from numpy import fft
import matplotlib.pyplot as plt

img = np.random.randn(256,256) 

f = fft.fftshift(fft.fft2(img))

mesh = np.meshgrid(range(-127,129),range(-127,129))

H=1/(np.square(mesh[0])+np.square(mesh[1]))
H[127,127]=0

inv_f=fft.ifftshift(fft.ifft2(f*H))

plt.gray()
plt.subplot(131)
plt.title('original noise image')
plt.imshow(img)
plt.subplot(132)
plt.title('filtered image')
plt.imshow(np.real(inv_f))
plt.tight_layout()
plt.show()
