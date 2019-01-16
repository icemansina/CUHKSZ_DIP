I = imread('imgs/Fig0203(a).tif');
whos I
figure;imshow(I);
title('Original Image')

% Reverse & Linear Transform
G = imadjust(I, [0, 1],[1 0], 1);
figure;imshow(G);
title('Reverse Image')

