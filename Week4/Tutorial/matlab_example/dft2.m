% Computing and Visualizing the 2-D DFT

f = imread('imgs/0401.tif');
subplot(221)
imshow(f, [ ])
title("Raw Image")

F = fft2(f);
subplot(222)
S1 = log(1 + abs(F));
imshow(S1, [ ])
title("Corresonding Spectrum")

% you can use 'imrotate(A,angle,method,bbox)' for image rotation
Fc = fftshift(F);
subplot(223)
imshow(abs(Fc), [ ])
title("Centered Spectrum")

S2 = log(1 + abs(Fc));
subplot(224)
imshow(S2, [ ])
title("Spectrum visually enhanced by a log transformation")
