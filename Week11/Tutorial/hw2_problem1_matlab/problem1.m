% solution of homework2 problem1
close all; clear;
src_dir = './imgs/';

% part (a)

clean_lic = imread(strcat(src_dir, 'pro1_license_plate_clean.png'));
noisy_lic = imread(strcat(src_dir, 'pro1_license_plate_noisy.png'));

% change to grayscale with background back
clean_lic_gray = 255 - rgb2gray(clean_lic); 
noisy_lic_gray = 255 - rgb2gray(noisy_lic); 

%show binarized clean
threshold_clean = graythresh(clean_lic_gray);
clean_lic_bin = im2bw(clean_lic_gray, threshold_clean);
imwrite(clean_lic_bin, 'binarized_license_plate_clean.png');

figure(1)
imshow(clean_lic_bin);
title('binarized clean');

%show binarized noisy
threshold_noisy = graythresh(noisy_lic_gray);
noisy_lic_bin = im2bw(noisy_lic_gray, threshold_noisy);
imwrite(noisy_lic_bin, 'binarized_license_plate_noisy.png');

figure(2)
imshow(noisy_lic_bin);
title('binarized noisy');

character = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

% template
figure(3)
for n = 1 : length(character)
    tmp = imread(strcat(src_dir, 'Templates\', character(n), '.png'));
    tmp_gray = 255 - rgb2gray(tmp); % background back
    threshold_tmp = graythresh(tmp_gray);
    tmp_bin = im2bw(tmp_gray, threshold_tmp);
    subplot(6, 6, n);
    imshow(tmp_bin);
end


% part (b)

[rows, cols, channle] = size(clean_lic);
height = 1 : rows;
width = 1 : cols ;


for n = 1 : length(character)
    tmp = imread(strcat(src_dir, 'Templates/', character(n), '.png'));
    tmp_gray = 255 - rgb2gray(tmp);     % background back
    threshold_tmp = graythresh(tmp_gray);
    tmp_bin = im2bw(tmp_gray, threshold_tmp);

    SE = imerode(tmp_bin, ones(3,3));   % erode characters to create struct element
    clean_lic_eroded = imerode(clean_lic_bin, SE);
    
    if sum(sum(clean_lic_eroded(height, width))) > 0
        figure
        clean_lic_dilate = imdilate(clean_lic_eroded, SE);
        orig_vs_dilate = max(0.5 .* clean_lic_gray, uint8(clean_lic_dilate * 255));
        imshow(orig_vs_dilate);
    end
end


% part (c)

for n = 1 : length(character)

    tmp = imread(strcat(src_dir, 'Templates/', character(n), '.png'));
    tmp_gray = 255 - rgb2gray(tmp);     % background back
    threshold_tmp = graythresh(tmp_gray);
    tmp_bin = im2bw(tmp_gray, threshold_tmp);

    SE_fore = imerode(tmp_bin, ones(3, 3));   % erode to create struct element
    SE_back = imdilate(tmp_bin, ones(5, 5)) - imdilate(tmp_bin, ones(3, 3));

    clean_lic_hitmiss = bwhitmiss(clean_lic_bin, SE_fore, SE_back);

    if sum(sum(clean_lic_hitmiss(height, width))) > 0
        figure
        clean_lic_dilate = imdilate(clean_lic_hitmiss, SE_fore);
        orig_vs_dilate = max(0.5 .* clean_lic_gray, uint8(clean_lic_dilate * 255));
        imshow(orig_vs_dilate);
    end
end



% part (d)

for n = 1 : length(character)

    tmp = imread(strcat(src_dir, 'Templates/', character(n), '.png'));
    tmp_gray = 255 - rgb2gray(tmp);     % background back
    threshold_tmp = graythresh(tmp_gray);
    tmp_bin = im2bw(tmp_gray, threshold_tmp);

    SE_fore = imerode(tmp_bin, ones(3, 3));   % erode to create struct element
    SE_back = imdilate(tmp_bin, ones(5, 5)) - imdilate(tmp_bin, ones(3, 3));

    noisy_lic_hitmiss = bwhitmiss(noisy_lic_bin, SE_fore, SE_back);

    if sum(sum(noisy_lic_hitmiss(height, width))) > 0
        figure
        noisy_lic_dilate = imdilate(noisy_lic_hitmiss, SE_fore);
        orig_vs_dilate = max(0.5 .* noisy_lic_gray, uint8(noisy_lic_dilate * 255));
        imshow(orig_vs_dilate);
    end
end


% part (e)

for n = 1 : length(character)

    tmp = imread(strcat(src_dir, 'Templates/', character(n), '.png'));

    tmp_gray = 255 - rgb2gray(tmp);     % background back
    threshold_tmp = graythresh(tmp_gray);
    tmp_bin = im2bw(tmp_gray, threshold_tmp);

    SE_fore = imerode(tmp_bin, ones(3, 3));   % erode to create struct element
    noisy_lic_rank_fore = ordfilt2(noisy_lic_bin, 12, SE_fore);

    SE_back = imdilate(tmp_bin, ones(5, 5)) - imdilate(tmp_bin, ones(3, 3));
    noisy_lic_rank_back = ordfilt2(~noisy_lic_bin, 12, SE_back);

    noisy_lic_rank = min(noisy_lic_rank_fore, noisy_lic_rank_back);

    if sum(sum(noisy_lic_rank(height, width))) > 0
        figure
        noisy_lic_dilate = imdilate(noisy_lic_rank, SE_fore);
        orig_vs_dilate = max(0.5 .* noisy_lic_gray, uint8(noisy_lic_dilate * 255));
        imshow(orig_vs_dilate);
    end
end