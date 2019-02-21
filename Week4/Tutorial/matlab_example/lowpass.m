% lowpass frequency domain filters
figure(4)
f = imread('imgs/0402.tif');
subplot(221)
imshow(f, [ ])
title("a) original image")

PQ = paddedsize(size(f));
[U, V] = dftuv(PQ(1), PQ(2));
D0 = 0.05 * PQ(2);
F = fft2(f, PQ(1), PQ(2));
H = exp(-(U.^2 + V.^2) / (2 * (D0^2)));
g = dftfilt(f, H);

subplot(222)
imshow(fftshift(H), [ ])
title("b) Gaussian lowpass filter")

subplot(223)
imshow(log(1 + abs(fftshift(F))), [ ])
title("c) Corresponding spectrum")

subplot(224)
imshow(g, [ ])
title("d) Processed image - lowpass")

