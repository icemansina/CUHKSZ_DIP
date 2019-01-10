from scipy.misc import imread,imresize,imsave
import numpy as np
import scipy
import matplotlib.pyplot as plt
from skimage.color import rgb2gray


def read(path):
    img = imread(path)
    return img

def save(path, img):
    img = imsave(path, img)

def show(img,  cmap=None):
    plt.figure()
    plt.imshow(img, cmap=cmap)
    plt.show()

def to_binary(img):
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            val = img[i][j]
            if val < 0.5:
                img[i][j] = 0
            else:
                img[i][j] = 1
    return img


if __name__ == "__main__":
    img = read('./rabbit.jpg')
    show(img)
    # save to png
    save('rabbit.png', img)
    #print(img.shape)
    img_gray = rgb2gray(img)
    show(img_gray, cmap='gray')
    img_binary = to_binary(img_gray)
    show(img_binary, cmap='gray')
    low_res = imresize(img, (120, 120), interp='nearest')
    high_res = imresize(low_res, (360, 360), interp='nearest')
    imsave('low_res.png', low_res)
    imsave('high_res.png', high_res)
