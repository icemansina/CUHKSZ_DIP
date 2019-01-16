I = imread('imgs/Fig0205(a).tif');
whos I
figure;imshow(I);
title('Original Image')


% log transform
G = log(1+double(I))
G = mat2gray(G)
figure;imshow(G);
title('Original Image')
