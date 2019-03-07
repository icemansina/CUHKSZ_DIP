% edge detection
% https://ww2.mathworks.cn/help/images/ref/edge.html

f = imread('./img1.tif');
figure(1)
imshow(f)
title('origin image')

figure(2)
[g_sobel_default,  ts] = edge(f, 'sobel');
subplot(321)
imshow(g_sobel_default)
title('results of Sobel edge detection with default params')

% log is Laplacian of a Gaussian
[g_log_default, tlog] = edge(f, 'log');
subplot(323)
imshow(g_log_default)
title('results of LoG edge detection with default params')

[g_canny_default, tc] = edge(f, 'canny');
subplot(325)
imshow(g_canny_default)
title('results of Canny edge detection with default params')

[g_sobel_best,ts] = edge(f, 'sobel', 0.05);
subplot(322)
imshow(g_sobel_best)
title('results of edge(f, sobel, 0.05) ')

[g_log_best,tlog] = edge(f, 'log', 0.003, 2.25);
subplot(324)
imshow(g_log_best)
title('results of edge(f, log, 0.003, 2.25) ')

[g_canny_best,tc] = edge(f, 'canny', [0.04 0.10], 1.5);
subplot(326)
imshow(g_canny_best)
title('results of edge(f, canny, [0.04 0.10], 1.5) ')