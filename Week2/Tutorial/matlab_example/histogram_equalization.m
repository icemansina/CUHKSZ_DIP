% read image into workspace
I = imread('imgs/Fig0208(a).tif');
whos I
figure;imshow(I);title('Original Image');

% L = 256 which means uint8
figure;histeq(I, 256);title('After Histogram Equalize');
