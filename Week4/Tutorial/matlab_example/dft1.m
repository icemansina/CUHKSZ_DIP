% Computing and Visualizing the 2-D DFT
figure(2)
f = imread('imgs/0401.tif');
subplot(221)
imshow(f, [ ])
title("Raw Image")

F = fft2(f);
subplot(222)
imshow(abs(F), [ ])
title("Fourier Spectrum")

Fc = fftshift(F);
subplot(223)
imshow(abs(Fc), [ ])
title("Centered Spectrum")

S2 = log(1 + abs(Fc));
subplot(224)
imshow(S2, [ ])
title("Spectrum visually enhanced by a log transformation")
