from scipy.misc import imread,imresize,imsave
import numpy as np
import scipy
import matplotlib.pyplot as plt


def read(path):
    img = imread(path)
    return img

def save(path, img):
    img = imsave(path, img)

def show(img):
    plt.figure()
    plt.imshow(img)
    plt.show()


img = read('./rabbit.jpg')
#show(img)
#print(img)
#save('rabbit2.jpg', img)
#print(img.shape)
img[:,:,0] = np.zeros_like(img[:,:,0])
show(img)


