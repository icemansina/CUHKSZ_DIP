clc
clear all
img_in=imread('lena.jpg');
img_in=rgb2gray(img_in);
figure,imshow(img_in);
title('原图');

[rows,cols]=size(img_in);
thresh=graythresh(img_in);
img_bw=im2bw(img_in,thresh);%二值图像

%%%%step1:高斯滤波
template=fspecial('gaussian',3,0.8);%生成一个3*3的高斯模板，标准差选0.8
img_filt=imfilter(img_bw,template);

%%%%step2:计算梯度（幅度和方向）
%Prewitt梯度模板
%也可选择一阶差分卷积模板：
%dx=[-1,-1;1,1] dy=[1,-1;1,-1]
%*********************
dx = [-1 -1 -1;0 0 0;1 1 1];%x方向的梯度模板
dy = [-1 0 1; -1 0 1;-1 0 1];%y方向的梯度模板
img_filt=double(img_filt);

grad_x=conv2(img_filt,dx,'same');%获取x方向的梯度图像.使用梯度模板进行二维卷积,结果与原图像大小相同
grad_y=conv2(img_filt,dy,'same');%获取y方向的梯度图像.使用梯度模板进行二维卷积,结果与原图像大小相同
grad=sqrt((grad_x.^2)+(grad_y.^2));%梯度幅值图像

figure,imshow(grad);
title('梯度幅值图');

grad_dir=atan2(grad_y,grad_x);%获取梯度方向弧度
grad_dir=grad_dir*180/pi;
%%%%step3:对梯度幅值进行非极大值抑制
%首先将角度划分成四个方向范围:水平(0°)、-45°、垂直(90°)、+45°
for i = 1:rows
    for j = 1:cols
        if((grad_dir(i,j)>=-22.5 && grad_dir(i,j)<=22.5) || (grad_dir(i,j)>=157.5 && grad_dir(i,j)<=180)...
                                       ||(grad_dir(i,j)<=-157.5 && grad_dir(i,j)>=-180) )
            grad_dir(i,j) = 0;
        elseif((grad_dir(i,j) >= 22.5) && (grad_dir(i,j) < 67.5) || (grad_dir(i,j) <= -112.5) && (grad_dir(i,j) > -157.5))
            grad_dir(i,j) = -45;
        elseif((grad_dir(i,j) >= 67.5) && (grad_dir(i,j) < 112.5) || (grad_dir(i,j) <= -67.5) && (grad_dir(i,j) >- 112.5))
            grad_dir(i,j) = 90;
        elseif((grad_dir(i,j) >= 112.5) && (grad_dir(i,j) < 157.5) || (grad_dir(i,j) <= -22.5) && (grad_dir(i,j) > -67.5))
            grad_dir(i,j) = 45;  
        end
    end
end

%讨论对3x3区域的四个基本边缘方向进行非极大值抑制.获取非极大值抑制图像
Nms = zeros(rows,cols);%定义一个非极大值抑制图像
for i = 2:rows-1
    for j= 2:cols-1
        if (grad_dir(i,j) == 90 && grad(i,j) == max([grad(i,j), grad(i,j+1), grad(i,j-1)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == -45 && grad(i,j) == max([grad(i,j), grad(i+1,j-1), grad(i-1,j+1)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == 0 && grad(i,j) == max([grad(i,j), grad(i+1,j), grad(i-1,j)]))
            Nms(i,j) = grad(i,j);
        elseif (grad_dir(i,j) == 45 && grad(i,j) == max([grad(i,j), grad(i+1,j+1), grad(i-1,j-1)]))
            Nms(i,j) = grad(i,j);
        end;
    end;
end;

figure,imshow(Nms);
title('非极大值抑制图');

%%%%step4:双阈值检测和连接边缘
img_out=zeros(rows,cols);%定义一个双阈值图像
YH_L=0.1*max(max(Nms));%低阈值
YH_H=0.3*max(max(Nms));%高阈值
for i = 1:rows
    for j = 1:cols
        if(Nms(i,j)<YH_L)
           img_out(i,j)=0;
        elseif(Nms(i,j)>YH_H)
                img_out(i,j)=1;
        %对TL < Nms(i, j) < TH 使用8连通区域确定
        
        elseif ( Nms(i+1,j) < YH_H || Nms(i-1,j) < YH_H || Nms(i,j+1) < YH_H || Nms(i,j-1) < YH_H ||...
                Nms(i-1,j-1) < YH_H || Nms(i-1, j+1) < YH_H || Nms(i+1, j+1) < YH_H || Nms(i+1, j-1) < YH_H)
                   img_out(i,j) = 1;   
        end  
    end
end
bw=edge(img_bw,'canny');

figure,imshow(img_out);
title('本实验结果图');

figure,imshow(bw);
title('工具箱Canny算子效果图');
