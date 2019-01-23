% nonlinear spatial filtering

% for general nonliear filtering: nlfilter, colfilt
% nlfilter performs operations directly in 2-D
% colfilt ogranizes the data in the form of columns
% colfilt requires more memory but faster

% generate filters: 
% ordfilt2 generates order-statistic filters
% medfilt2 is a useful tool for reducing salt-and-pepper noise

% f = imread('cameraman.tif');
f = imread('imgs/Fig0219.tif');

figure(1);
subplot(2, 2, 1);
imshow(f);
title('raw image');

% add salt & pepper noise
fn = imnoise(f, 'salt & pepper', 0.2);
subplot(2, 2, 2);
imshow(fn);
title('image with noise');

gm = medfilt2(fn);
subplot(2, 2, 3);
imshow(gm);
title('median filtering results');

gms = medfilt2(fn, 'symmetric');
subplot(2, 2, 4);
imshow(gms);
title('median filtering (symmetric) results');











