import numpy as np
from demo import read, show
from skimage import transform


img = read("../matlab_example/imgs/0401.tif")
#tf_rotate = transform.SimilarityTransform(rotation=np.deg2rad(30))
#img = transform.warp(img, tf_rotate)
#tf_shift = transform.SimilarityTransform(translation=[60, 60])
#img = transform.warp(img, tf_shift)

show(img, cmap='gray')


fft2 = np.fft.fft2(img)
show(np.abs(fft2), cmap='gray')

shift2center = np.fft.fftshift(fft2)
show(np.abs(fft2), cmap='gray')

log_fft2 = np.log(1 + np.abs(fft2))
show(np.abs(log_fft2), cmap='gray')


log_shift2center = np.log(1 + np.abs(shift2center))
show(np.abs(log_shift2center), cmap='gray')


