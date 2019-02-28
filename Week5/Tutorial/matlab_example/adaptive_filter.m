f = imread('imgs/Fig0508.tif');

figure(1);
subplot(2, 2, 1);
imshow(f);
title('original image');

% add salt & pepper noise
fn = imnoise(f, 'salt & pepper', 0.5);
subplot(2, 2, 2);
imshow(fn);
title('image with salt & pepper noise');

% using median filter
f1 = medfilt2(fn, [7,7], 'symmetric');
subplot(2, 2, 3);
imshow(f1);
title('denose with median filter');

% using adaptive median filter
f2 = adpmedian(fn, 7);
subplot(2, 2, 4);
imshow(f2);
%title('denose with adaptive median filter');

