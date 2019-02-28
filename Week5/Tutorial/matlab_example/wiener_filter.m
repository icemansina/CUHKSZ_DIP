f = checkerboard();

figure(1);
subplot(3, 2, 1);
imshow(f);
title('original image');

PSF = fspecial('motion', 7, 45);

gb = imfilter(f, PSF, 'circular');
noise = imnoise(zeros(size(f)), 'gaussian', 0, 0.001);
g = gb + noise;
subplot(3, 2, 2);
imshow(g);
title('motion image');


f1 = deconvwnr(g, PSF);
subplot(3, 2, 3);
imshow(f1);
title('NSPR zero & inverse filter');

Sn = abs(fft2(noise).^2);           % noise power spectrum
nA = sum(Sn(:))/prod(size(noise));  % noise average power
Sf = abs(fft2(f)).^2;               % image power spectrum
fA = sum(Sf(:))/prod(size(f));      % image average power
R = nA/fA;

f2 = deconvwnr(g, PSF, R);
subplot(3, 2, 4);
imshow(f2);
title('using a constant ratio');


NCORR = fftshift(real(ifft2(Sn)));
ICORR = fftshift(real(ifft2(Sf)));
f3 = deconvwnr(g, PSF, NCORR, ICORR);
subplot(3, 2, 5);
imshow(f3);
title('using autocorrelation functions');







