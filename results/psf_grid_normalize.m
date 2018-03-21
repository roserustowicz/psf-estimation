% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

% For each k_size x k_size block, normalize to 1.
k_size = 15;

r_edges = 1:k_size:size(psf_grid, 1);
c_edges = 1:k_size:size(psf_grid, 2);

num_psfs = zeros(numel(r_edges), numel(c_edges));
normalized = zeros(size(final));
for r = 1:numel(num_psfs(:,1))
    for c = 1:numel(num_psfs(1,:))
        cur_psf = final((r-1)*k_size+1:r*k_size,(c-1)*k_size+1:c*k_size,:);
        norm_psf = cur_psf/max(cur_psf(:));
        normalized((r-1)*k_size+1:r*k_size,(c-1)*k_size+1:c*k_size,:) = norm_psf;
    end
end

imshow(normalized, [])