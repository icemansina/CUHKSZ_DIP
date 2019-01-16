% read image into workspace
I = imread('imgs/circlesBrightDark.png');
I = rgb2gray(I);
figure;imshow(I);
axis off
title('Original Image')
% check meta info of x
whos I

% single 
BW = im2bw(I, 0.5);
figure;imshow(BW)
axis off
title('Single Thresholding Image')

% multi
thresh = multithresh(I,2),
seg_I = imquantize(I,thresh);
RGB = label2rgb(seg_I); 	 
figure;imshow(RGB)
axis off
title('RGB Segmented Image')
