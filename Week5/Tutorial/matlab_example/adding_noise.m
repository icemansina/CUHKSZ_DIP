f = imread('imgs/Fig0219.tif');

figure(1);
subplot(2, 2, 1);
imshow(f);
title('original image');

% add gaussian noise
fn = imnoise(f, 'gaussian', 0.1, 0.01);
subplot(2, 2, 2);
imshow(fn);
title('image with gaussian noise');

% add gaussian noise with zero-mean local variance V
fn = imnoise(f, 'localvar', 0.05*rand(size(f)));
subplot(2, 2, 3);
imshow(fn);
title('image with localvar noise');

% add salt & pepper noise
fn = imnoise(f, 'salt & pepper', 0.2);
subplot(2, 2, 4);
imshow(fn);
title('image with salt & pepper noise');











