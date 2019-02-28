%% MyMainScript

%% RMSD values for filtered images obtained with (i) 0.9 sigma_space and 1.0 sigma_intensity
tic;
myBilateralFiltering(5, 0.9, 1.0);
toc;
w = waitforbuttonpress;
%% RMSD values for filtered images obtained with (ii) 1.1 sigma_space and 1.0 sigma_intensity
tic;
myBilateralFiltering(5, 1.1, 1.0);
toc;
%% RMSD values for filtered images obtained with (iii) 1.0 sigma_space and 0.9 sigma_intensity
tic;
myBilateralFiltering(5, 1.0, 0.9);
toc;
%% RMSD values for filtered images obtained with (iv) 1.0 sigma_space and 1.1 sigma_intensity
tic;
myBilateralFiltering(5, 1.0, 1.1);
toc;