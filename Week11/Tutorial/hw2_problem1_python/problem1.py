# coding: utf-8

import cv2
import numpy as np
import matplotlib.pyplot as plt


# (a)
license_plate_clean=cv2.imread('figs/pro1_license_plate_clean.png', cv2.IMREAD_GRAYSCALE)
license_plate_noisy=cv2.imread('figs/pro1_license_plate_noisy.png', cv2.IMREAD_GRAYSCALE)
thresh, license_plate_clean_binary = cv2.threshold(license_plate_clean, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)
plt.figure(1)
plt.imshow(license_plate_clean_binary,'gray')

_, license_plate_noisy_binary = cv2.threshold(license_plate_noisy, thresh, 255, cv2.THRESH_BINARY_INV)

plt.figure(2)
plt.imshow(license_plate_noisy_binary,'gray')

templates=[chr(i) for i in range(ord('0'),ord('9')+1)]
templates.extend([chr(i) for i in range(ord('A'),ord('Z')+1)])


import os
if not os.path.exists('result/'):
    os.mkdir('result/')
if not os.path.exists('result/problem1'):
    os.mkdir('result/problem1')
    
def save(name,img):
    cv2.imwrite('result/problem1/'+name+'.png', img)

for char in templates:
    img = cv2.imread('figs/Templates/'+char+'.png', cv2.IMREAD_GRAYSCALE)
    _, img_binary = cv2.threshold(img, thresh, 255, cv2.THRESH_BINARY_INV)
    save(char,img_binary)

save('license_plate_clean_binary',license_plate_clean_binary)
save('license_plate_noisy_binary',license_plate_noisy_binary)


# (b)

def getBinaryTemplate(char):
    img = cv2.imread('result/problem1/'+char+'.png', cv2.IMREAD_GRAYSCALE)
    return img

res = []
for char in templates:
    element = getBinaryTemplate(char)
    element = cv2.erode(element,np.ones((3,3)))
    eroded=cv2.erode(license_plate_clean_binary,element)
    img=cv2.dilate(eroded,element[::-1,::-1])
    if img.sum()>0:
        res.append(img)
plt.figure(3)
for i,img in enumerate(res):
    plt.subplot(int(np.ceil(len(res)/3)),3,i+1)
    plt.imshow(img+license_plate_clean_binary/2,'gray')


# 3,8,B,E,F,H,I,L,T is detected by this approach.
# There are many false positive detections, because some character could be a subset of other characters.

# (c)

def hitMissFilter(char,img,inv_img):
    element=getBinaryTemplate(char)
    foreground = cv2.erode(element,np.ones((3,3)))
    background=cv2.dilate(element,np.ones((5,5)))-cv2.dilate(element,np.ones((3,3)))
    output_image1=cv2.erode(img,foreground)
    output_image2=cv2.erode(inv_img,background)
    img=cv2.dilate((np.logical_and(output_image1,output_image2)*255).astype(np.uint8),foreground[::-1,::-1])
    return img

not_license_plate_clean_binary = cv2.threshold(license_plate_clean, thresh, 255, cv2.THRESH_BINARY)[1]
res = []
for char in templates:
    img = hitMissFilter(char,license_plate_clean_binary,not_license_plate_clean_binary)
    if img.sum()>0:
        res.append(img)
plt.figure(4)
for i,img in enumerate(res):
    plt.subplot(int(np.ceil(len(res)/3)),3,i+1)
    plt.imshow(img+license_plate_clean_binary/2,'gray')


# Erosion detector only detect the foreground the characters. Hit-miss filter detect both foreground and background of the characters, and combine the informations. So hit-miss filter will have less false positive detections.

# (d)

not_license_plate_noisy_binary = cv2.threshold(license_plate_clean, thresh, 255, cv2.THRESH_BINARY)[1]
res = []
for char in templates:
    img = hitMissFilter(char,license_plate_noisy_binary,not_license_plate_noisy_binary)
    if img[:,1:].sum()>0:
         res.append(img)
plt.figure(4)
for i,img in enumerate(res):
    plt.subplot(int(np.ceil(len(res)/3)),3,i+1)
    plt.imshow(img+license_plate_clean_binary/2,'gray')


# Because of the noise, there are some unmatched point on the noise when doning the erosion. The erosion will fail because of the noisy, this would influent the accuracy of hit-miss detector.

# (e)

def ordfilt2(img,p,se):
    h,w = se.shape
    delta=(se==0).sum()
    res = np.zeros(img.shape)
    for i in range(img.shape[0]-h+1):
        for j in range(img.shape[1]-w+1):
            reg = img[i:i+h,j:j+w]*se
            res[i+h//2,j+w//2] = 255 if delta+p>(reg==0).sum() else 0
    return res

p1 = 10
p2 = 3
res = []
for char in templates:
    element=getBinaryTemplate(char)
    foreground = cv2.erode(element,np.ones((3,3)))
    background=cv2.dilate(element,np.ones((5,5)))-cv2.dilate(element,np.ones((3,3)))
    output_image1=ordfilt2(not_license_plate_noisy_binary,p2,background)
    output_image2=ordfilt2(license_plate_noisy_binary,p1,foreground)
    img = cv2.dilate((np.logical_and(output_image1,output_image2)*255).astype(np.uint8),foreground[::-1,::-1])
    if img.sum()>0:
         res.append(img)
plt.figure(5)
for i,img in enumerate(res):
    plt.subplot(int(np.ceil(len(res)/3)),3,i+1)
    plt.imshow(img+license_plate_clean_binary/2,'gray')


# p1 is 10 and p2 is 3, there are no false positives.
plt.show()