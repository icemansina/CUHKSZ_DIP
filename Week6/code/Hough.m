%读取图像
I  = imread('huofu.jpg');
% 转换成灰度图
grayI = rgb2gray(I);

% 创建二进制图像
BW = edge(grayI,'canny');
% 使用二值图像创建Hough变换。
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
% 在图像的霍夫变换中查找峰值
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
% 找到线条并绘制它们
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % 绘制线条的开始和结束
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % 确定最长线段的端点
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% 通过为青色着色来突出显示最长的线段
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');