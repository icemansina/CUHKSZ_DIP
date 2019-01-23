% Linear Spatial Filtering
% f = imread('cameraman.tif');
f = imread('imgs/Fig0216.tif');
figure(1);
subplot(2, 2, 1);
imshow(f);
title('raw image');

w = ones(31);
% w = fspecial("laplacian", 0);

gd1 = imfilter(f, w);
subplot(2, 2, 2);
imshow(gd1, []);
title('pads the border with 0');

gd2 = imfilter(f, w, 'replicate');
subplot(2, 2, 3);
imshow(gd2, []);
title('replicate pads');

gd3 = imfilter(f, w, 'symmetric');
subplot(2, 2, 4);
imshow(gd3, []);
title('symmetric pads');
