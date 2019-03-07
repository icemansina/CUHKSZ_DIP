from matplotlib.pyplot import imshow, show, subplot, gray, title, axis
import numpy as np
import cv2

if __name__ == '__main__':
    from sys import argv
    if len(argv) < 2:
        print("Usage: python %s <image>" % argv[0])
        exit()
    im = cv2.imread(argv[1],0)
    subplot(1, 2, 1)
    imshow(im,cmap='gray')
    axis('off')
    title('Original')
    m = np.max(im)
    edges=cv2.Canny(im, m*0.1, m*0.8)

    # subplot(1, 2, 1)
    # imshow()
    # axis('off')
    # title('double')

    subplot(1, 2, 2)
    imshow(edges,cmap='gray')
    axis('off')
    title('Edges')

    show()
