import numpy as np
from demo import read, show

raw_img = read("../matlab_example/imgs/0402.tif")
img = np.pad(raw_img, ((0, raw_img.shape[0]), (0, raw_img.shape[1])), 'constant') 
show(img, cmap='gray')

fft2 = np.fft.fft2(img)
shift2center = np.fft.fftshift(fft2)
show(np.log(1+np.abs(shift2center)), cmap='gray')

def dftuv(m, n):
    u = np.array(list(range(0, m)))
    v = np.array(list(range(0, n)))
    u[m//2:] -= m
    v[n//2:] -= n
    u,v = np.meshgrid(u, v)
    return u**2 + v**2


sigma = 0.05 * img.shape[0]
d = dftuv(img.shape[0], img.shape[1])
h = np.exp(-d/(2*(sigma**2)))

res = np.fft.fft2(raw_img, (img.shape[0], img.shape[1])) * h
res = np.fft.ifft2(res)

show(np.abs(res), cmap='gray')
