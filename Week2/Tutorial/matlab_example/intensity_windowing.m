I = imread('imgs/Fig0203(a).tif');
whos I
figure;imshow(I);
title('Original Image')

% Specific intensity Enhance 
G = imadjust(I, [0.5 0.75], [0 1]);
figure;imshow(G);
title('Specific intensity Enhance')

