% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

% Get all fnames in folder and read them into a datacube
folder = '';
imagefiles = dir(strcat(folder,'*.mat'));      
nfiles = length(imagefiles);    % Number of files found

for idx = 1:nfiles
    cur_fname = imagefiles(idx).name;
    load(cur_fname)
    psf_grid_all{idx} = psf_grid;
end

final = zeros(size(psf_grid));
for idx = 1:numel(psf_grid_all)
    final = final + psf_grid_all{idx};
end

green_chans = zeros(size(psf_grid(:,:,1)));
for idx = 1:numel(psf_grid_all)
    curimg = psf_grid_all{idx};
    green_chans(:,:,idx) = curimg(:,:,2);
end

% For each grid section, figure out how many to average by
center_rows = linspace(1, 276, 24+23);
center_rows = round(center_rows(2:2:end));
center_cols = linspace(1, 372, 32+31);
center_cols = round(center_cols(2:2:end));

num_psfs = zeros(numel(center_rows), numel(center_cols));
for r_idx = 1:numel(center_rows)
    cur_r = center_rows(r_idx);
    for c_idx = 1:numel(center_cols)
        cur_c = center_cols(c_idx);
        vals = green_chans(cur_r, cur_c, :);
        num_psfs(r_idx, c_idx) = sum((vals ~= 0));
    end
end

figure; imagesc(num_psfs); title('Number of PSFs')

% Fill 12 x 12 grids with denominator values
denominators = zeros(size(psf_grid(:,:,1)));
for r = 1:numel(num_psfs(:,1))
    for c = 1:numel(num_psfs(1,:))
        denominators((r-1)*12+1:r*12,(c-1)*12+1:c*12) = num_psfs(r, c);
    end
end
denominators(denominators == 0) = 1;

figure; imagesc(denominators)

%final = final ./ denominators;
figure; imshow(final); title('Estimate of all PSFs')