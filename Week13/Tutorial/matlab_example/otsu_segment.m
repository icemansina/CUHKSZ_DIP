% Otsu Method for segment
clc
clear
close all

x=imread('lena.png');

% convert to gray image
c=rgb2gray(x); 
a=im2double(c); 

subplot(221);
imhist(c);
title('gray');

subplot(222);
imshow(c,[]);
title('raw');


k=0;
gray_all=0;                  % 预设图像总灰度值为0
ICV_t=0;

[M,N]=size(a);
pixelall=M*N;             % 像素个数


for i=1:M
    for j=1:N
        gray_all=gray_all+a(i,j);
    end
end

ave=gray_all*255/pixelall;

% t为某个阈值，把原图像分为A部分（每个像素值>=t）与B部分（每个像素值<t）
for t=0:255
    A=0;    B=0;
    NA=0;
    NB=0;
    for i=1:M                     %遍历原图像每个像素的灰度值
        for j=1:N
            if (a(i,j)*255>=t)    %分割出灰度值>=t的像素
                NA=NA+1;  %得到A部分总像素
                A=A+a(i,j);   %得到A部分总灰度值
            elseif (a(i,j)*255<t) %分割出灰度值《t的像素
                NB=NB+1;  %得到B部分总像素
                B=B+a(i,j);   %得到B部分总灰度值
            end
        end
    end
    PA=NA/pixelall;            %得到A部分像素总数与图像总像素的比列
    PB=NB/pixelall;            %得到B部分像素总数与图像总像素的比列
    A_ave=A*255/NA;          %得到A部分总灰度值与A部分总像素的比例
    B_ave=B*255/NB;          %得到B部分总灰度值与B部分总像素的比例
    ICV=PA*((A_ave-ave)^2)+PB*((B_ave-ave)^2);  %Otsu算法
    if (ICV>ICV_t)                     %不断判断，得到最大方差
        ICV_t=ICV;
        k=t;                           %得到最大方差的最优阈值
    end
end

for i=1:M
    for j=1:N
        if c(i,j)>k
            c(i,j)=0;
        else
            c(i,j)=255;
        end
    end
end
subplot(223);

imshow(c,[]);
title('our implementation');

% use matlab api for otsu
I=im2double(c);
k1=graythresh(I);              %得到最优阈值
J=imbinarize(I,k1);                 %转换成二值图，k为分割阈值
subplot(224);
imshow(J);
title('otsu in matlab');

