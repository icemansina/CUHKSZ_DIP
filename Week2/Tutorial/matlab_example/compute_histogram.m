% read image into workspace
I = imread('imgs/Fig0208(a).tif');
whos I
figure;imshow(I);title('Original Image');

% computing histogram
[x, y] = size(I);
H = zeros(1, 255);

for i = 1:x
    for j = 1:y
        intensity = I(i,j);
        H(1,intensity) = H(1,intensity) + 1;
    end
end

figure;bar(H);


% simpler method
H = zeros(1, 255);

for i = 1:255
    H(1,i) = sum(I(:) == i); 
end

figure;bar(H);


% simplest 
figure;imhist(I);



