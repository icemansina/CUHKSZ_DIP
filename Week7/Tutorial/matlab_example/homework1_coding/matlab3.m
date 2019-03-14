% answer for matlab problem 3

image = imread('./800px-Unequalized_Hawkes_Bay_NZ.jpg');

subplot(3,2,1);
imshow(image);
title('raw');
subplot(3,2,2);
imhist(image);
title('histogram - raw');

%% calculate histogram

% histogram equlization manual
image_eq = histeq_my(image, 256);
subplot(3,2,3);
imshow(image_eq);
title('equalized');

subplot(3,2,4);
imhist(image_eq);
% bar(Licheng_eq_m, hist_fast, 500);
title('histogram - equalized');

%% calculate again

% histogram equlization manual
image_eq_again = histeq_my(image_eq, 256);
subplot(3,2,5);
imshow(image_eq);
title('equalized again');

subplot(3,2,6);
imhist(image_eq_again);
% bar(Licheng_eq_m, hist_fast, 500);
title('histogram - equalized again');
