# coding: utf-8

import cv2
import numpy as np
from numpy import fft
import matplotlib.pyplot as plt
img=cv2.imread('1.png',0)
tmp=cv2.imread('2.png',0)


img_pad=np.pad(img,((0,tmp.shape[0]-1),(0,tmp.shape[1]-1)),'constant')
tmp_pad=np.pad(tmp,((0,img.shape[0]-1),(0,img.shape[1]-1)),'constant')



cor_freq=np.abs(fft.ifft2(fft.fft2(img_pad)*fft.fft2(tmp_pad).conj()))[:img.shape[0],:img.shape[1]]
cor_freq=cor_freq/cor_freq.sum()


plt.gray()
plt.figure(1)
plt.subplot(321)
plt.imshow(img)
plt.subplot(322)
plt.imshow(tmp)
plt.subplot(323)
plt.imshow(img_pad)
plt.subplot(324)
plt.imshow(tmp_pad)
plt.subplot(325)
plt.imshow(cor_freq)
plt.subplot(326)
plt.plot(cor_freq.max(axis=0))
plt.tight_layout()



def correlation2d(img,kernal):
    kernal = kernal/kernal.sum()
    res=np.zeros((img.shape[0]-kernal.shape[0]+1,img.shape[1]-kernal.shape[1]+1))
    for i in range(res.shape[0]):
        for j in range(res.shape[1]):
            res[i,j]=(img[i:i+kernal.shape[0],j:j+kernal.shape[1]]*kernal).sum()
    return res



cor_spac=correlation2d(img_pad,tmp)
cor_spac=cor_spac/cor_spac.sum()


plt.figure(2)
plt.subplot(121)
plt.imshow(cor_spac)
plt.subplot(122)
plt.plot(cor_spac.max(axis=0))
plt.tight_layout()
plt.show()


print('The difference between two image:',(cor_freq-cor_spac).sum())

