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

def show(img,title='', cmap=None):
    plt.figure()
    plt.title(title)
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
    print("Don't run it directly")
