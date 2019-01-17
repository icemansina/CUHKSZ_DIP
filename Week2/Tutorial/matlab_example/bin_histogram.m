% read image into workspace
I = randi([1, 2^14], 1000, 1000);
whos I

% computing bin histogram
[x, y] = size(I);
H = zeros(1, 255);
for i = 1:x
    for j = 1:y
        intensity = (I(i,j) / 2^14)*255;
        intensity = ceil(intensity);
        H(1,intensity) = H(1,intensity) + 1;
    end
end
figure;bar(H);