clc
clear

A = imread('Fig0906(a).tif');
B = [0 1 0
     1 1 1
     0 1 0];
 A2 = imdilate(A, B);
 A3 = imdilate(A2, B); % 二次膨胀
 A4 = imdilate(A3, B); % 三次膨胀
%  A2 = imdilate(B,A); 
subplot(221)
imshow(A)
title('原始图像')

subplot(222)
imshow(A2)
title('使用结构元素[B]一次膨胀后的图像')

subplot(223)
imshow(A3)
title('使用结构元素[B]二次膨胀后的图像')

subplot(224)
imshow(A4)
title('使用结构元素[B]三次膨胀后的图像')

figure(2)
imshow(A2-A) % 显示增加的部分
title('使用结构元素[B]一次膨胀后和原图像相比较增加的部分')
