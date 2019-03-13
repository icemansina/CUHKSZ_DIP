% answer for matlab problem 1


%% matlab 1

figure()

f = randn(256); % generate the random noise
PQ = paddedsize(size(f)); % padding
F = fft2(f, PQ(1), PQ(2)); % fft
[U, V] = dftuv(PQ(1), PQ(2));
H = 1./(U.^2+V.^2); % prepare H
H(1,1) = 0;
G = H .* F; % passing the filter
g = ifft2(G); % inverse fft
g = g(1:size(f,1), 1:size(f,2)); % depadding

subplot(1,2,1);
imshow(f, []);
title("a) random normal noise");

subplot(1,2,2);
imshow(g, []);
title("b) pass through filter");

% figure();
% HM = fftshift(H);
% mesh(HM(1:1:end, 1:1:end));
