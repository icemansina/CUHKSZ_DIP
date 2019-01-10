from scipy.misc import imread,imresize,imsave
import numpy as np
import scipy
import matplotlib.pyplot as plt


def read(path):
    img = imread(path)
    return img

def save(path, img):
    img = imsave(path, img)

def show(img,  cmap=None):
    plt.figure()
    plt.imshow(img, cmap=cmap)
    plt.show()

if __name__ == "__main__":
    img = read('./rabbit.jpg')
    #show(img)
    #print(img)
    #save('rabbit2.jpg', img)
    #print(img.shape)
    img[:,:,0] = np.zeros_like(img[:,:,0])
    show(img)

def to_binary(img):
    for i in range(img.shape[0]):
        for j in range(img.shape[1]):
            val = img[i][j]
            if val < 0.5:
                img[i][j] = 0
            else:
                img[i][j] = 1
    return img


