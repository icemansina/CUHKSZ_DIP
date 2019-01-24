% laplacian vs gradient

f = imread('imgs/Fig0219.tif');
figure(1);
subplot(1, 3, 1);
imshow(f);
title('raw image');

w1 = fspecial("laplacian", 0.5);
gd1 = imfilter(f, w1);
subplot(1, 3, 2);
imshow(gd1, []);
title('laplacian');

w2 = fspecial("sobel");
gd2 = imfilter(f, w2);
subplot(1, 3, 3);
imshow(gd2, []);
title('sobel');

