import numpy as np
from demo import read, show
from scipy.misc import imread,imresize,imsave


img = read("../matlab_example/imgs/0401.tif")
img = imresize(img, (32,32))
show(img, cmap='gray')

h , w = img.shape
# 生成一个同样大小的复数矩阵
F = np.zeros([h,w],'complex128')
for u in range(h):
    for v in range(w):
        res = 0
        for x in range(h):
            for y in range(w):
                res += img[x,y] * np.exp(-1.j * 2 * np.pi * (u * x / h + v * y / w))
        F[u,v] = res
log_F = np.log(1 + np.abs(F))

show(np.abs(log_F), cmap='gray')
