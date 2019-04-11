% Image warp

figure(1)
I = imread('1.tif');
subplot(121)
imshow(I)
% Create a 2-D geometric transformation object.
tform = affine2d([1 0 0; .5 1 0; 0 0 1]);

% Apply the transformation to the image.
J = imwarp(I,tform, 'cubic');
subplot(122)
imshow(J)

