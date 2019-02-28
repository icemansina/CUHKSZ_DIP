f = imread('imgs/Fig0219.tif');

figure(1);
subplot(4, 2, 1);
imshow(f);
title('original image');
[M,N] = size(f);

% add pepper noise
R = imnoise2('salt & pepper', M, N, 0.1, 0);
c = find(R==0);
gp = f;
gp(c) = 0;
subplot(4, 2, 3);
imshow(gp);
title('image with pepper noise');

% add salt noise
R = imnoise2('salt & pepper', M, N, 0, 0.1);
c = find(R==1);
gs = f;
gs(c) = 255;
subplot(4, 2, 4);
imshow(gs);
title('image with salt noise');

fn = spfilt(gp, 'chmean', 3, 3, 1.5);
subplot(4, 2, 5);
imshow(fn);
title('remove pepper noise');

fn = spfilt(gs, 'chmean', 3, 3, -1.5);
subplot(4, 2, 6);
imshow(fn);
title('remove salt noise');

fn = spfilt(gp, 'max', 3, 3);
subplot(4, 2, 7);
imshow(fn);
title('remove pepper noise by max filter');

fn = spfilt(gs, 'min', 3, 3);
subplot(4, 2, 8);
imshow(fn);
title('remove salt noise by min filter');
