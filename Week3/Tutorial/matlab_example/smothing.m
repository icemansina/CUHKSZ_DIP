% Gaussian Smoothing
% https://ww2.mathworks.cn/help/images/ref/imgaussfilt.html

f = imread('cameraman.tif');

figure(1);
subplot(2, 2, 1);
imshow(f);
title('raw image');

% add salt & pepper noise
filter1 = fspecial('average', [15, 15]);
fg1 = imfilter(f, filter1);
subplot(2, 2, 2);
imshow(fg1);
title('average smoothing');

% filter2 = fspecial('gaussian', [15, 15], 3);
fg2 = imgaussfilt(f, 3);
subplot(2, 2, 3);
imshow(fg2);
title('gaussian smoothing, sigmma=3');

% filter3 = fspecial('gaussian', [15, 15], 10);
fg3 = imgaussfilt(f, 10);
subplot(2, 2, 4);
imshow(fg3);
title('gaussian smoothing, sigmma=10');

