function [img] = raw2png(cur_fname)
%RAW2PNG converts raw images from Huawei phone to png files
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018
    
    if strfind(cur_fname,'0.raw')
        imgsize = [3968, 2976];
    elseif strfind(cur_fname,'1.raw')
        imgsize = [5120, 3840];
    else
        error('The filename should contain "main" for the main bayer array sensor, or "second" for the mono sensor.')
    end
    
    fid = fopen(cur_fname, 'rb');
    data = double(fread(fid, 'uint16', 'ieee-le'));

    data = reshape(data,imgsize)';
    data = uint16(data);
    
    % Demosaic
    data = demosaic(data, 'bggr');
    
    % Adjust from 12 bit to 8 bit
    img = uint8(data/4);
    
    imwrite(img, strcat(cur_fname(1:numel(cur_fname) - 4), '_matlab_8bit', '.png'));
end

