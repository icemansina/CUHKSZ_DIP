import numpy as np
import time
from collections import Counter
import matplotlib
import matplotlib.pyplot as plt
import cv2

matplotlib.rcParams['font.size'] = 18


def simple_version(img):
    img_h = img.reshape(1, -1)
    c = Counter(img_h[0].data)
    return dict(c)


def compute_histogram_v1(img):
    s = time.time()

    hist = {}
    w, h = img.shape

    for i in range(w):
        for j in range(h):
            pixel = img[i][j]
            v = hist.get(pixel, 0)
            hist[pixel] = v + 1
    print("compute_histogram_v1 - time used: ", time.time() - s)
    return hist


def compute_histogram_v2(img, bits=np.power(2, 8)):
    """

    :param img: np.array
        shape is (10000, 10000)
    :param bits: int
    :return: dict
    """
    s = time.time()
    hist = {}
    for i in range(bits):
        hist[i] = np.sum(img == i)
    print("compute_histogram_v2 - time used: ", time.time() - s)
    return hist


def compare_v1_v2():
    img = np.random.randint(0, 256, (1000, 1000))
    hist1 = compute_histogram_v1(img)
    hist2 = compute_histogram_v2(img)


def hist_bins_example():
    fig = plt.figure(figsize=(16, 9))
    ax1, ax2, ax3 = fig.subplots(1, 3)

    bits = np.power(2, 14)
    img = np.random.randint(0, bits, (512, 512))

    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("image(bits=2^14)")

    raw_hist = simple_version(img)
    ax2.bar(raw_hist.keys(), raw_hist.values(), color='red', alpha=0.6)
    ax2.set_title("histogram without bins")

    # compute histogram with bins
    w, h = img.shape
    hist_b = {}
    for i in range(w):
        for j in range(h):
            v = int((img[i][j] / bits) * 255)
            c = hist_b.get(v, 0)
            hist_b[v] = c + 1

    ax3.bar(hist_b.keys(), hist_b.values(), color='red', alpha=0.8)
    ax3.set_title("histogram with bins")

    plt.show()

# https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_histograms/py_histogram_equalization/py_histogram_equalization.html


def show_histogram_equalization():
    img = cv2.imread('./imgs/Fig0208(a).tif', 0)
    equ = cv2.equalizeHist(img)

    fig = plt.figure(figsize=(16, 9))
    ax1, ax2 = fig.subplots(1, 2)
    ax1.axis('off')
    ax1.imshow(img, cmap='gray')
    ax1.set_title("raw image")

    ax2.axis("off")
    ax2.imshow(equ, cmap='gray')
    ax2.set_title("Histograms Equalization")
    plt.show()


if __name__ == '__main__':
    functions = [
        compare_v1_v2,
        hist_bins_example,
        show_histogram_equalization
    ]
    for func in functions:
        y = input("run %s? (yes/no): " % func.__name__)
        if y.lower() == "yes" or y.lower() == 'y':
            func()
        print("=" * 88)

