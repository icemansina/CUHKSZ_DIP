% answers for matlab problem 2 

%% load image
close all;


utk = imread('figures/Fig4.41(a).jpg');
t = imread('figures/Fig4.41(b).jpg');

% plot padded utk and t
utkpad = padarray(utk, size(t),'post');
tpad = padarray(t, size(utk),'post');


%% freq domain correlation

close all;
figure('Name', 'Frequency domain filtering');

% plot utk and t
subplot(3,2,1);
imshow(utk);
subplot(3,2,2);
imshow(t);

subplot(3,2,3);
imshow(utkpad, []);
subplot(3,2,4);
imshow(tpad, []);

% plot padded utk and t
% tr = rot90(t,2);
% PQ = paddedsize(size(utkpad)); % padding
% 
% H = freqz2(tpad, PQ(2), PQ(1));
% H1 = ifftshift(H);
H1 = fft2(tpad);

% utkpad = padarray(utk, size(t),'post');
% tpad = padarray(t, size(utk),'post');
% subplot(3,2,3);
% imshow(utkpad, []);
% subplot(3,2,4);
% imshow(tpad, []);


% f = randn(256); % generate the random noise
% PQ = paddedsize(size(utk)); % padding
UTKPAD = fft2(utkpad); % fft
% [U, V] = dftuv(PQ(1), PQ(2));
% H = 1./(U.^2+V.^2); % prepare H
% H(1,1) = 0;
GF = H1 .* conj(UTKPAD); % passing the filter
gf = ifft2(GF); % inverse fft
gf = gf(1:size(UTKPAD,1), 1:size(UTKPAD,2)); % depadding



% do correlation through convolution
% gf = dftfilt(utk, H1);
% g = conv2(utkpad, rot90(tpad,2));

% depadding
% g = g(size(utkpad, 1):end, size(utkpad, 2):end);

% plot the result of correlation
subplot(3,2,5);
gfreal = real(gf);
gfreal = rot90(gfreal, 2);
% gfreal = gfreal(size(utkpad, 1):end, size(utkpad, 2):end);
imshow(gfreal, []);

% plot the correlation result of the horizonal line contains the maximum
subplot(3,2,6);
[M,I] = max(gfreal(:));
plot(gfreal(round(I/size(gfreal,1)), :));
% surf(gfabs); shading flat;
xlim([0,200]);
axis off

% close all;


%% spatial domain correlation

% close all;
figure('Name', 'Spatial domain correlation');

% plot utk and t
subplot(3,2,1);
imshow(utk);
subplot(3,2,2);
imshow(t);

% plot padded utk and t
% utkpad = padarray(utk, size(t),'post');
% tpad = padarray(t, size(utk),'post');
subplot(3,2,3);
imshow(utkpad, []);
subplot(3,2,4);
imshow(tpad, []);

% do correlation through convolution
g = conv2(utkpad, rot90(tpad,2));

% depadding
g = g(size(utkpad, 1):end, size(utkpad, 2):end);

% plot the result of correlation
subplot(3,2,5);
imshow(g, []);

% plot the correlation result of the horizonal line contains the maximum
subplot(3,2,6);
[M,I] = max(g(:));
plot(g(round(I/size(g,1)), :));
xlim([0,200]);
axis off;


% close all;
