% hough transform

f = zeros(101,101);
f(1,1) = 1;
f(101,1) = 1;
f(1,101) = 1;
f(51,51) = 1;
f(101,101) = 1;
subplot(311)
imshow(f)
title('Binary image with five dots')

H = hough(f);
subplot(312)
imshow(H,[])
title('hough transform')

[H,theta,rho] = hough(f);
subplot(313)
imshow(H,'XData',theta,'YData',rho,  'InitialMagnification','fit');
axis on, axis normal
xlabel('\theta'),ylabel('\rho')
title('hough transform with axis labeling')


