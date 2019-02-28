function myBilateralFiltering(windowsize, sigmaSpacial, sigmaRange )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
inpImg = 'data\barbara.mat';
f1 = load(inpImg,'-mat');
f2 = f1.imageOrig;
original = mat2gray(f2);
in_rows = size(original,1);
in_cols = size(original,2);
corrupted =  original + 0.05*randn(size(original));

iMin=0;
iMax=0;
jMin=0;
jMax=0;
w = (windowsize-1) /2; % half windowsize
w = round(w);
num = zeros(in_rows,in_cols);
den = zeros(in_rows,in_cols);
spacialDiff = zeros(windowsize, windowsize);
window = zeros(windowsize, windowsize);
rangeDifference = zeros(windowsize, windowsize);
for i = 1:in_rows
    if ((i - w)>1)
        iMin = i-w;
    else
        iMin = 1;
    end;
    if ((i + w)< in_rows)
        iMax = i+w;
    else
        iMax = in_rows;
    end;
    for j = 1:in_cols 
        if ((j - w)>1)
            jMin = j-w;
        else
            jMin = 1;
        end;
        if ((j + w)< in_cols)
            jMax = j+w;
        else
            jMax = in_cols;
        end;
        for i1 = iMin:iMax
            for j1 = jMin:jMax
                window((i1 - iMin + 1),(j1-jMin+1)) = corrupted(i1, j1);
                spacialDiff((i-iMin+1), (j - jMin+1)) = (i - i1)*(i - i1) +(j - j1)*(j-j1);
                rangeDifference((i1 - iMin + 1),(j1-jMin+1)) = window((i1 - iMin + 1),(j1-jMin+1)) - corrupted(i, j);
            end;
        end;
        % p pixel is at location i,j
        
        gsSpacial = exp((spacialDiff*(-0.5))/(sigmaSpacial*sigmaSpacial));
        gsRange = exp((rangeDifference*(-0.5))/(sigmaRange*sigmaRange));
        t = gsSpacial.*gsRange;
        num(i,j) = sum(sum(window.*t));
        den(i,j) = sum(sum(t));
    end;
end;
filtered = num./den;
rmsd = sqrt((1/(in_rows*in_cols))*(sum(sum((original-filtered)*(original-filtered)))));
disp(rmsd);

figure(1);
subplot(1,3,1);
imagesc ((original)); % phantom is a popular test image
colormap('Gray');
title('Original');
daspect ([1 1 1]);
axis tight;
subplot(1,3,2);
imagesc ((corrupted)); % phantom is a popular test image
colormap('Gray');
title('Corrupted');
daspect ([1 1 1]);
axis tight;
subplot(1,3,3);
imagesc ((filtered)); % phantom is a popular test image
colormap('Gray');
title('Filtered');
daspect ([1 1 1]);
axis tight;
set(gcf,'Position',get(0,'ScreenSize'));%maximize figure


imwrite(corrupted,'images\barbaraCorrupted.png');
imwrite(filtered,'images\barbaraBilateralFiltered.png');
end
