% read image into workspace
x = imread('imgs/landscape.jpg');

% show image as figure window
imshow(x)

% check meta info of x
whos x

% rotate image & show second image
fx = x(end:-1:1, :, :);
figure(2), imshow(fx)

% rotate image & show second image
fx1 = x(600:100, 600:100, 600:100);
figure(3), imshow(fx1)

% matlab built-in images
% cameraman.tif, 
I = imread('cameraman.tif');
figure;imshow(I);title('Original Image');
text(size(I,2),size(I,1)+15, ...
    'Image courtesy of Massachusetts Institute of Technology', ...
    'FontSize',7,'HorizontalAlignment','right');
