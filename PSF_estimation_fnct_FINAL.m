function [psf] = PSF_estimation_fnct_FINAL(k_init)
% Estiate the PSF with call to PSFest_FINAL
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

showfigs = 0;

k_size = sqrt(size(k_init(:), 1));
k = k_init(:);

% Perform a deconvolution on the image and the noisy image
options.Method = 'sd';
options.NumIter = 500;
psf = minFunc(@PSFest_FINAL,k, options);
psf = reshape(psf, [k_size, k_size]);

if showfigs
    figure; imagesc(psf)
    title('Min using minFunc')
end

end
