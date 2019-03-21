

from skimage.morphology import thin, skeletonize
import numpy as np
import matplotlib.pyplot as plt

square = np.zeros((7, 7), dtype=np.uint8)
square[1:-1, 2:-2] = 1
square[0, 1] =  1
thinned = thin(square)
skel = skeletonize(square)

f, ax = plt.subplots(2, 2)
ax[0,0].imshow(square)
ax[0,0].set_title('original')
ax[0,0].get_xaxis().set_visible(False)
ax[0,1].axis('off')
ax[1,0].imshow(thinned)
ax[1,0].set_title('morphology.thin')
ax[1,1].imshow(skel)
ax[1,1].set_title('morphology.skeletonize')
plt.show()
