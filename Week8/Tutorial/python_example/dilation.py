# Erosion shrinks bright regions
import numpy as np
from skimage.morphology import square, dilation
bright_square = np.array([[0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0],
                          [0, 0, 1, 0, 0],
                          [0, 0, 0, 0, 0],
                          [0, 0, 0, 0, 0]], dtype=np.uint8)

print(bright_square)
print(dilation(bright_square, square(3)))



