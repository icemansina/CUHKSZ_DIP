# coding: utf-8

import cv2
import matplotlib.pyplot as plt
import numpy as np
plt.gray()


def calcLookupTable(img):
    hist = cv2.calcHist([img],[0],None,[256],[0,256])
    h,w = img.shape
    L = 256 - 1
    hist /= float(h*w)
    lookupTable = np.zeros(len(hist),dtype = np.uint8)
    accumulatedProb = 0
    for i in range(len(hist)):
        accumulatedProb += hist[i]
        lookupTable[i] = int(accumulatedProb*L)
    return lookupTable

def equalize(img):
    h,w = img.shape
    lookupTable = calcLookupTable(img)
    equalizedImg = np.zeros((h,w),dtype=np.uint8)
    for i in range(h):
        for j in range(w):
            equalizedImg[i,j] = lookupTable[img[i,j]]
    return equalizedImg


img = cv2.imread('800px-Unequalized_Hawkes_Bay_NZ.jpg',0)


hist_origin=cv2.calcHist([img],[0],None,[256],[0,256])

img_eqi=equalize(img)

hist_eqi=cv2.calcHist([img_eqi],[0],None,[256],[0,256])

plt.figure(1)
plt.subplot(121)
plt.title('origin image')
plt.imshow(img)
plt.subplot(122)
plt.title('equilized image')
plt.imshow(img_eqi)
plt.tight_layout()


plt.figure(2)
plt.subplot(121)
plt.title('origin histogram')
plt.plot(range(256),hist_origin)
plt.subplot(122)
plt.title('equilized histogram')
plt.plot(range(256),hist_eqi)
plt.tight_layout()
plt.show()

