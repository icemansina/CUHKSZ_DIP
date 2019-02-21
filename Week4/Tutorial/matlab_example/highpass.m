% Highpass filtering
figure(5)
f = imread('imgs/0402.tif');
subplot(121)
imshow(f, [ ])
title("a) original image")

PQ = paddedsize(size(f));
D0 = 0.05 * PQ(1);
H = hpfilter('gaussian', PQ(1), PQ(2), D0);
g = dftfilt(f, H);

subplot(122)
imshow(g, [ ])
title("b) Processed image - highpass")

