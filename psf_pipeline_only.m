% This is the main PSF estimation pipeline that takes in warped images, and
% outputs a grid of estimated PSFs.
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

% Load the u_imgs and b_imgs for PSF estimation
k_size = 15;

for channel = 1:3
    if channel == 1
        load 'U_B_IMGS/first_try/06_cul_channel1_uimgs_bimgs_bayer.mat';
        [or, oc, op] = size(u_img);
        r_total_grids = floor(or/128);
        c_total_grids = floor(oc/128);
        psf_grid = zeros(r_total_grids*k_size, c_total_grids*k_size,3);
        
        figure;
        imshow(u_img(:,:,1), []);
        rect = getrect();
        
        if mod(rect(1), 128) ~= 0
            rect(1) = rect(1) - mod(rect(1), 128) + 128;
        end
        
        if mod(rect(2), 128) ~= 0
            rect(2) = rect(2) - mod(rect(2), 128) + 128;
        end
        
        if mod(rect(3), 128) ~= 0
            rect(3) = rect(3) - mod(rect(3), 128);
        end
        
        if mod(rect(4), 128) ~= 0
            rect(4) = rect(4) - mod(rect(4), 128);
        end
        
    elseif channel == 2
        load 'U_B_IMGS/first_try/06_cul_channel2_uimgs_bimgs_bayer.mat';
    elseif channel == 3        
        load 'U_B_IMGS/first_try/06_cul_channel3_uimgs_bimgs_bayer.mat';
    end
    
    b_img = cur_noise_img;
    
    
    % Crop the image to the active region
    % Select region to evaluate PSFs from the u_img. Crop the region so that the rows
    % and columns begin at a multiple of 128. This way the estimated PSFs will overlap well
    % in the final PSF grid
    
    % Crop the u_imgs and b_imgs to the specified rect region
    u_img = u_img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),1);
    b_img = b_img(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3),1);
    
    % For every 128 x 128 region of the images, find the PSF and plot it
    [r, c, p] = size(u_img);
    r_grids = floor(r/128);
    c_grids = floor(c/128);
    
    k_init = zeros(k_size); k_init(ceil(k_size/2), ceil(k_size/2)) = 1;
    for r_grid_idx = 1:r_grids
        for c_grid_idx = 1:c_grids
            cur_uimg = u_img((r_grid_idx-1)*128+1:(r_grid_idx)*128,(c_grid_idx-1)*128+1:(c_grid_idx)*128,1);
            cur_bimg = b_img((r_grid_idx-1)*128+1:(r_grid_idx)*128,(c_grid_idx-1)*128+1:(c_grid_idx)*128,1);
            save 'tmp_uimg.mat' 'cur_uimg'
            save 'tmp_bimg.mat' 'cur_bimg'
            pause(1);
            [psf] = PSF_estimation_fnct_FINAL(k_init);
            psf_grid(rect(2)/128*k_size+((r_grid_idx-1)*k_size)+1:rect(2)/128*k_size+((r_grid_idx)*k_size), rect(1)/128*k_size+((c_grid_idx-1)*k_size)+1:rect(1)/128*k_size+((c_grid_idx)*k_size),channel) = psf;
        end
    end
end

figure; imshow(psf_grid, [])