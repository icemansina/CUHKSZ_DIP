clc
clear

A = imread('Fig0908(a).tif');
se = strel('disk', 10);

subplot(221)
imshow(A)
title('原始图像')

A2 = imerode(A, se);
subplot(222)
imshow(A2)
title('使用结构元素[disk（10）]腐蚀后的图像')

se = strel('disk', 5);
A3 = imerode(A, se);
subplot(223)
imshow(A3)
title('使用结构元素[disk（5）]腐蚀后的图像')

A4 = imerode(A, strel('disk', 20));
subplot(224)
imshow(A4)
title('使用结构元素[disk（20）]腐蚀后的图像')