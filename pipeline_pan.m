% This is the alignment procedure for the panchromatic images
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

%% Read in raw images from Huawei phone
folder = 'PSF_IMGS_ALL/subset_clc_20180312/';
imagefiles = dir(strcat(folder,'*.raw'));      
nfiles = length(imagefiles);    % Number of files found
k_size = 12;

for idx = 1:nfiles
   cur_fname = imagefiles(idx).name;
   cur_fname = strcat(folder, cur_fname);
   cur_img = raw2png(cur_fname);
   my_imgs{idx} = cur_img;
end

%% Put raw images into cell arrays for each camera
bggr_count = 0;
pan_count = 0;
for idx = 1:nfiles
    img = my_imgs{idx};
    if mod(idx, 2) == 0
        bggr_count = bggr_count + 1;
        png_bggr{bggr_count} = img;
    else
        pan_count = pan_count + 1;
        png_pan{pan_count} = img;
    end
end

%% Assign images to variable names
cb_img = im2double(png_pan{1});
black_img = im2double(png_pan{2});
white_img = im2double(png_pan{3});
%noise_img = im2double(png_pan{4});

for idx = 4:numel(png_pan)
    noise_img(:,:,idx-3) = im2double(png_pan{idx});
end

%% Read in pristine targets 
cb = im2double(imread('targets/cb_img.png'));
black = im2double(imread('targets/black.png'));
white = im2double(imread('targets/white.png'));
%noise = im2double(imread('targets/noise_01.png'));
noise(:,:,1) = im2double(imread('targets/noise_01.png'));
noise(:,:,2) = im2double(imread('targets/noise_02.png'));
noise(:,:,3) = im2double(imread('targets/noise_03.png'));
noise(:,:,4) = im2double(imread('targets/noise_04.png'));
noise(:,:,5) = im2double(imread('targets/noise_05.png'));

%% Project pristine image targets into image space

%iprime_norm = warp_function(cb, noise, black, white, cb_img, noise_img, black_img, white_img);
for idx = 1:5
    iprime_norm(:,:,idx) = warp_function(cb, noise(:,:,idx), black, white, cb_img, noise_img(:,:,idx), black_img, white_img);
end 

%% Correct for colors in pristine image with black and white image
%u_img = black_img + iprime_norm .* (white_img - black_img);
for idx = 1:5
    u_img(:,:,idx) = black_img + iprime_norm(:,:,idx) .* (white_img - black_img);
end

save('subset_20180312_uimgs_bimgs_pan.mat','noise_img','u_img')
