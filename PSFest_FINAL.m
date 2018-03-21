function [f, df] = PSFest_FINAL(k)
%PSF_EST Uses minFunc to estimate a PSF kernel, k
% The function outputs the value of the objective function, f and a vector
%  of the objective derivative, df.
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

% Set constants
k_size = sqrt(size(k(:),1));
lambda = 10; 
mu = 10; 
gamma = 0;

k = reshape(k, [k_size, k_size]);

dx = [0,  0, 0;
    0, -1, 1;
    0, 0, 0];

dy = [0,  0, 0;
    0, -1, 0;
    0,  1, 0];

% Read in patterns for estimation
load('tmp_uimg.mat')
load('tmp_bimg.mat')
u_img = cur_uimg(:,:,1);
b_img = cur_bimg(:,:,1);

% --------- Compute f, the Expected value of k. ---------- %
b_hat = b_img(:);
[r, c] = size(b_img);

u_hat = generate_block_circ_u(u_img, k_size);
    
% Calculate expectation of k

% First term
f1 = lambda .* sum(sum(k(:).^2));
df1 = 2 * lambda .* k(:);

% Second term
f2 = norm(u_hat * k(:) - b_hat).^2;
df2 = 2 *(u_hat' * u_hat * k(:)) - (2*u_hat' * b_hat);

% Third term
kx = conv2(k, dx,'same');
ky = conv2(k, dy,'same');
f3 = mu * ((sum(sum(kx(:).^2))) + sum(sum(ky(:).^2)));
dxt = circshift(ifft2( conj(fft2(circshift(dx, [-1 -1]))) ),[1 1]);
dyt = circshift(ifft2( conj(fft2(circshift(dy, [-1 -1]))) ),[1 1]);
dxk = conv2(dxt,dx);
dyk = conv2(dyt,dy);
dfx = 2 * mu * ifft2(fft2(k) .* psf2otf(dxk, size(k)));
dfy = 2 * mu * ifft2(fft2(k) .* psf2otf(dyk, size(k)));
df3 = dfx + dfy;
df3 = df3(:);

f = f1 + f2 + f3;
df = df1 + df2 + df3;

% Flatten k again so the output is a vector
k = k(:);

end

