# coding: utf-8
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from skimage import io
from skimage import data

matplotlib.rcParams['font.size'] = 18


c = data.camera()


def im2negative(img):
    """transform image to negative

    :param img: np.array
    :return: np.array
    """
    return 255.0 - img


def log_transform(img, c):
    """logarithmic transformations

    :param img:
    :param c:
    :return:
    """
    return float(c) * np.log(1.0 + img)


def power_law_transform(img, gamma, c):
    return float(c) * np.power(img, float(gamma))


def im2bw(img, th=128):
    """transform image to binary

    :param img: np.array
    :param th: int
        threshold
    :return: np.array
    """
    return img > th


def show_threshold():
    fig = plt.figure(figsize=(16, 9))
    ax1, ax2 = fig.subplots(1, 2)

    img = data.page()
    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("raw image")

    y = im2bw(img, th=128)
    ax2.axis('off')
    ax2.imshow(y, cmap='gray')
    ax2.set_title("binary image")
    plt.show()


def show_log_transform():
    fig = plt.figure(figsize=(16, 9))
    ax1, ax2 = fig.subplots(1, 2)

    img = io.imread('./imgs/Fig0205(a).tif')
    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("raw image")

    y = log_transform(img, 42.0)
    ax2.axis('off')
    ax2.imshow(y, cmap='gray')
    ax2.set_title("log transformation")
    plt.show()


def show_image_negatives():
    fig = plt.figure(figsize=(16, 9))
    ax1, ax2 = fig.subplots(1, 2)

    img = data.camera()
    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("raw image")

    y = im2negative(img)
    ax2.axis('off')
    ax2.imshow(y, cmap='gray')
    ax2.set_title("negative image")
    plt.show()


def show_power_low_transform():
    fig = plt.figure(figsize=(16, 9))
    (ax1, ax2), (ax3, ax4) = fig.subplots(2, 2)

    img = data.camera()
    # img = io.imread('./imgs/Fig0208(a).tif')
    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("raw image")

    y1 = power_law_transform(img, 0.3, 10)
    ax2.axis('off')
    ax2.imshow(y1, cmap='gray')
    ax2.set_title("gamma=0.3")

    y2 = power_law_transform(img, 0.5, 10)
    ax3.axis('off')
    ax3.imshow(y2, cmap='gray')
    ax3.set_title("gamma=0.5")

    y3 = power_law_transform(img, 2, 10)
    ax4.axis('off')
    ax4.imshow(y3, cmap='gray')
    ax4.set_title("gamma=2.0")
    plt.show()


if __name__ == '__main__':
    functions = [
        show_threshold,
        show_image_negatives,
        show_log_transform,
        show_power_low_transform
    ]
    for func in functions:
        y = input("run %s? (yes/no): " % func.__name__)
        if y.lower() == "yes" or y.lower() == 'y':
            func()
        print("=" * 88)


