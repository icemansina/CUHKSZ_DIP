% answer for matlab problem 3

clc;
% clear all;
close all;

calc_std = @(block_struct) std2(block_struct.data);

file_names = {'./figures/pro4_satellite_1_degraded.tiff', './figures/pro4_satellite_2_degraded.tiff'};
% file_names = {'./figures/pro4_satellite_1_degraded.tiff'};


figure();
n_cols = 4;
for idx = 1:length(file_names)
    img = im2double(imread(file_names{idx}));
    
    [path, name, ext] = fileparts(file_names{idx});
    
    
%     figure("Name", sprintf('%s - std2', name));
    subplot(length(file_names), n_cols, n_cols*(idx-1)+1);
    imshow(img);
    title('original');
    
    
    % we divide the image into different block size 
    % and estimate the noise varience (we choose the block with second small standard deviation)
    n_blocks = 5:3:50;
    second_smallest_std = zeros(1, length(n_blocks));
    for i = 1:length(n_blocks)
        img_size = size(img);
        img_std = blockproc(img,[ceil(img_size(1)/n_blocks(i)) ceil(img_size(2)/n_blocks(i))],calc_std);
        block_std_list = sort(img_std(:));
        second_smallest_std(i) = block_std_list(2);
    end
    figure(1);
    
    % accoring to experience the n_blocks should be slightly larger to
    % approxmiate noise
    noise_std = second_smallest_std(5);
    fprintf('%s noise std: %f\n', name, noise_std);
    
    row_idx = 180;
    subplot(length(file_names), n_cols, n_cols*(idx-1)+2);
    plot(img(row_idx, :));
    axis tight;
    ylim([0 1]);
    hold on;
    
    
    % apply morphological sharpening
    SE = strel('disk', 10);
    im_d = imdilate(img, SE);
    im_e = imerode(img, SE);
    im_h = .5*(im_d + im_e);
    ind_d = find(img >= im_h);
    ind_e = find(img < im_h);
    img_sharpen = img;
    img_sharpen(ind_d) = im_d(ind_d);
    img_sharpen(ind_e) = im_e(ind_e);
    
    
    % finding the best gaussian filter by searching the one with least
    % 1-norm difference
    min_delta = inf;
    best_sigma = 0;
    % by experience, the best sigma should be in [3, 10]
    for sigma = 3:0.1:10
        img_regauss = imgaussfilt(img_sharpen, sigma);
        img_regauss_delta = norm(img_regauss - img, 1);
        if img_regauss_delta < min_delta
            min_delta = img_regauss_delta;
            best_sigma = sigma;
        end
    end
    fprintf('%s gaussian sigma estimate: %f\n', name, best_sigma);
    img_regauss = imgaussfilt(img_sharpen, 8);
    
    plot(img_sharpen(row_idx, :));
    plot(img_regauss(row_idx, :), '-.r');
    hold off;
    axis tight;
    ylim([0 1]);
    
    % deblur without noise estimatation
    PSF = fspecial('gaussian', 2*ceil(2*best_sigma)+1, best_sigma);
    img_deblur = deconvwnr(img, PSF, 0);
    imwrite(img_deblur, fullfile(path, strcat(name, '_deblur.jpg')));

    subplot(length(file_names), n_cols, n_cols*(idx-1)+3);
    imshow(img_deblur);
    title('de-blurred, NSR = 0')
    
    % deblur with noise consideration
    estimated_nsr = noise_std^2/var(img(:));
    img_deblur_denoise = deconvwnr(img, PSF, estimated_nsr);
    imwrite(img_deblur_denoise, fullfile(path, strcat(name, '_deblur_denoise.jpg')));
    
    subplot(length(file_names), n_cols, n_cols*(idx-1)+4);
    imshow(img_deblur_denoise);
    title(sprintf('de-blurred, NSR = %f', estimated_nsr));
end

