% This is the alignment procedure for the bayer images
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

%% Read in raw images from Huawei phone
folder = 'PSF_IMGS_ALL/subset_clc_20180312/';
imagefiles = dir(strcat(folder,'*.raw'));      
nfiles = length(imagefiles);    % Number of files found

for idx = 1:nfiles
   cur_fname = imagefiles(idx).name;
   cur_fname = strcat(folder, cur_fname);
   cur_img = raw2png_demosaic(cur_fname);
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
cb_img = im2double(png_bggr{1});
black_img = im2double(png_bggr{2});
white_img = im2double(png_bggr{3});

for idx = 4:numel(png_pan)
    noise_img{idx-3} = im2double(png_bggr{idx});
end

%% Read in pristine targets 
cb = im2double(imread('targets/cb_img.png'));
black = im2double(imread('targets/black.png'));
white = im2double(imread('targets/white.png'));
noise(:,:,2) = im2double(imread('targets/noise_02.png'));
noise(:,:,3) = im2double(imread('targets/noise_03.png'));
noise(:,:,4) = im2double(imread('targets/noise_04.png'));
noise(:,:,5) = im2double(imread('targets/noise_05.png'));

%% FOR EACH COLOR CHANNEL:
for c = 1:3
    cur_cb_img = cb_img; 
    cur_black_img = black_img(:,:,c);
    cur_white_img = white_img(:,:,c);
    % cur_noise_img = noise_img(:,:,c);
    % iprime_norm = warp_function(cb, noise, black, white, cur_cb_img, cur_noise_img, cur_black_img, white_img);   
    % u_img = cur_black_img + iprime_norm .* (cur_white_img - cur_black_img);

    for n_idx = 1:numel(noise_img)
        cur_noise = noise_img{n_idx};
        cur_noise_img(:,:,n_idx) = cur_noise(:,:,c);
    end
    
    % Project pristine image targets into image space
    for idx = 1 :5
       iprime_norm(:,:,idx) = warp_function(cb, noise(:,:,idx), black, white, cur_cb_img, cur_noise_img(:,:,idx), cur_black_img, white_img);   
    end

    % Correct for colors in pristine image with black and white image
    for idx = 1:5
       u_img(:,:,idx) = cur_black_img + iprime_norm(:,:,idx) .* (cur_white_img - cur_black_img);
    end
    
    fname = strcat('subset_20180312', num2str(c), '_uimgs_bimgs_bayer.mat');
    save(fname,'cur_noise_img','u_img')
end
