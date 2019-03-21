clc
clear

figure(1)
BW = imread('Fig0914(a).tif');
imshow(BW)
title('原始图像')

figure(2)
BW2 = bwmorph(BW,'remove'); % 有时达不到理想的提取边界效果
subplot(221)
imshow(BW2)

BW3 = bwmorph(BW,'skel',Inf);
subplot(222)
imshow(BW3)

BW4 = bwmorph(BW,'shrink',Inf); % 去掉毛刺的“骨骼化”
subplot(223)
imshow(BW4)

ginf = bwmorph(BW, 'thin', Inf); 
subplot(224)
imshow(ginf)
title('使用函数[bwmorph]细化到稳定状态后的图像')