% answer for matlab problem 3

clc;
clear all;
close all;

file_names = {'./figures/pro3_building.jpg', './figures/pro3_train.jpg'};
for idx = 1:length(file_names)
    img = im2double(imread(file_names{idx}));
    figure();
    subplot(4, 1, 1);
    imshow(img);
    title('original');
    
    [path, name, ext] = fileparts(file_names{idx});
    
    % median filtering
    img_med_filtered_3 = medfilt2(img, [3 3], 'symmetric');
    subplot(4, 1, 2);
    imshow(img_med_filtered_3);
    imwrite(img_med_filtered_3, fullfile(path, strcat(name, '_med_3x3.jpg')));
    title('3x3 median filtered');
    
    img_med_filtered_5 = medfilt2(img, [5 5], 'symmetric');
    subplot(4, 1, 3);
    imshow(img_med_filtered_5);
    imwrite(img_med_filtered_5, fullfile(path, strcat(name, '_med_5x5.jpg')));
    title('5x5 median filtered');
    
    % weighted median filtering
    weights = [0 1 1 1 0;
        1 2 2 2 1;
        1 2 4 2 1;
        1 2 2 2 1;
        0 1 1 1 0;];
    
    img_med_filtered_w = wmedfilt2(img, weights);
    subplot(4, 1, 4);
    imshow(img_med_filtered_w);
    imwrite(img_med_filtered_w, fullfile(path, strcat(name, '_med_weighted.jpg')));
    title('weighted median filtered');
end



function img_out = wmedfilt2(img_in, weights)
    [h, w, c] = size(img_in); [fh, fw] = size(weights);
    fh_half = floor(fh/2);
    fw_half = floor(fw/2);
    img_out = img_in;
    
    for x = 1:w
        for y = 1:h
            samples = [];
            for xs = max(1, x-fw_half):min(w, x+fw_half)
                for ys =  max(1, y-fh_half):min(h, y+fh_half)
                    dx = xs - x;
                    dx_idx = dx + fw_half + 1;
                    dy = ys - y;
                    dy_idx = dy + fh_half + 1;
                    if (weights(dy_idx, dx_idx) > 0)
                        samples = [samples img_in(ys, xs) * ones(1, weights(dy_idx, dx_idx))];
                    end
                end
            end
            img_out(y, x) = median(samples);
        end
    end
end