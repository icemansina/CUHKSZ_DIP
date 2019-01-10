% read image into workspace
img = 'imgs/landscape.jpg';
X = imread(img);

% check meta info of x
whos X

% X = imread('cameraman.tif');

% check image info stored in disk
% imfinfo(img)

% show image as figure window
subplot(2, 2, 1); imshow(X); title("row image")

% convert rgb image to gray image
X_gray = rgb2gray(X); % 
subplot(2, 2, 2); imshow(X_gray); title("gray image")

% convert rgb image to ind image
map = jet(256);
X_ind = rgb2ind(X, map);
subplot(2, 2, 3); imshow(X_ind, map); title("index image")

% convert rgb image to binary image
X_bw = im2bw(X_gray, 0.5);
subplot(2, 2, 4); imshow(X_bw); title("binary image")

% write images
imwrite(X_gray, 'imgs/landscape_gray.jpg')

% rotate image & show second image
fx = x(end:-1:1, :, :);
figure(2), imshow(fx)

% image resize
figure(1)
[M, N, C] = size(X);
imshow(X); title("row image")

X1 = imresize(X, [600, 800]);
figure(2); imshow(X1); title("size: 600 * 800")

X2 = imresize(X, [300, 400]);
figure(3); imshow(X2); title("size: 300 * 400")

X3 = imresize(X, [150, 200]);
figure(4); imshow(X3); title("size: 150 * 200")

X4 = imresize(X, [75, 100]);
figure(5); imshow(X4); title("size: 75 * 100")

% for convenient, use close all to close all figure window.
close all

% matlab built-in images
% cameraman.tif, 
I = imread('cameraman.tif');
figure;imshow(I);title('Original Image');
text(size(I,2),size(I,1)+15, ...
    'Image courtesy of Massachusetts Institute of Technology', ...
    'FontSize',7,'HorizontalAlignment','right');
