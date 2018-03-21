% Validate the PSF approach by simulating images and solving for results
% Author: Rose Rustowicz, rose.rustowicz@gmail.com
% Date: 16 March 2018

k_size = 13;
k_init = zeros(k_size); k_init(ceil(k_size/2), ceil(k_size/2)) = 1;   
figure;

p=0.5;        %probability of success
n=128;
cur_uimg=rand(n);
cur_uimg=double((cur_uimg<p));
k1 = fspecial('gaussian',k_size,0.5);
cur_bimg = imfilter(cur_uimg, k1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
k1 = (k1 - min(k1(:))) / (max(k1(:)) - min(k1(:)));
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 1)
imagesc(k1)
imwrite(k1, 'kernel01_gt.png')
title('Ground Truth')
subplot(4, 5, 6)
imwrite(psf, 'kernel01_only.png')
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k1))]) 

cur_bimg1 = cur_bimg;

cur_bimg = imnoise(cur_bimg,'gaussian',0,0.01);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 11)
imwrite(psf, 'kernel01_0.01noise.png')
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k1))]) 

cur_bimg = imnoise(cur_bimg1,'gaussian',0,0.1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 16)
imagesc(psf)
imwrite(psf, 'kernel01_0.1noise.png')
title(['PSNR: ',num2str(psnr(psf, k1))]) 

% --------------------------

k2 = fspecial('gaussian',k_size,1.5);
cur_bimg = imfilter(cur_uimg, k2);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
subplot(4, 5, 2)
imagesc(k2)
imwrite(k2, 'kernel02.png')
title('Ground Truth')
subplot(4, 5, 7)
imagesc(psf)
imwrite(psf, 'kernel02_only.png')
k2 = (k2 - min(k2(:))) / (max(k2(:)) - min(k2(:)));
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
title(['PSNR: ',num2str(psnr(psf, k2))]) 

cur_bimg1 = cur_bimg;

cur_bimg = imnoise(cur_bimg,'gaussian',0,0.01);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel02_0.01noise.png')
subplot(4, 5, 12)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k2))]) 

cur_bimg = imnoise(cur_bimg1,'gaussian',0,0.1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel02_0.1noise.png')
subplot(4, 5, 17)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k2))]) 

% --------------------------

k3 = fspecial('gaussian',k_size,2.5);
cur_bimg = imfilter(cur_uimg, k3);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
k3 = (k3 - min(k3(:))) / (max(k3(:)) - min(k3(:)));
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 3)
imagesc(k3)
imwrite(k3, 'kernel03.png')
title('Ground Truth')
subplot(4, 5, 8)
imagesc(psf)
imwrite(psf, 'kernel03_only.png')
title(['PSNR: ',num2str(psnr(psf, k3))]) 

cur_bimg1 = cur_bimg;

cur_bimg = imnoise(cur_bimg,'gaussian',0,0.01);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel03_0.01noise.png')
subplot(4, 5, 13)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k3))]) 

cur_bimg = imnoise(cur_bimg1,'gaussian',0,0.1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel03_0.1noise.png')
subplot(4, 5, 18)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k3))]) 

% --------------------------

k4 = zeros(k_size, k_size);
k4(5:9,7) = 1;
k4(7,5:9) = 1;
cur_bimg = imfilter(cur_uimg, k4);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
k4 = (k4 - min(k4(:))) / (max(k4(:)) - min(k4(:)));
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 4)
imagesc(k4)
imwrite(k4, 'kernel04.png')
title('Ground Truth')
subplot(4, 5, 9)
imagesc(psf)
imwrite(psf, 'kernel04_only.png')
title(['PSNR: ',num2str(psnr(psf, k4))]) 

cur_bimg1 = cur_bimg;

cur_bimg = imnoise(cur_bimg,'gaussian',0,0.01);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel04_0.01noise.png')
subplot(4, 5, 14)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k4))]) 

cur_bimg = imnoise(cur_bimg1,'gaussian',0,0.1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel04_0.1noise.png')
subplot(4, 5, 19)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k4))]) 

% --------------------------

k5 = rand(6, 6);
k5 = imresize(k5, [k_size, k_size]);
cur_bimg = imfilter(cur_uimg, k5);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
k5 = (k5 - min(k5(:))) / (max(k5(:)) - min(k5(:)));
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
subplot(4, 5, 5)
imagesc(k5)
imwrite(k5, 'kernel05.png')
title('Ground Truth')
subplot(4, 5, 10)
imagesc(psf)
imwrite(psf, 'kernel05_only.png')
title(['PSNR: ',num2str(psnr(psf, k5))]) 

cur_bimg1 = cur_bimg;

cur_bimg = imnoise(cur_bimg,'gaussian',0,0.01);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel05_0.01noise.png')
subplot(4, 5, 15)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k5))]) 

cur_bimg = imnoise(cur_bimg1,'gaussian',0,0.1);
cur_bimg = (cur_bimg - min(cur_bimg(:))) / (max(cur_bimg(:)) - min(cur_bimg(:)));
save 'tmp_uimg.mat' 'cur_uimg'
save 'tmp_bimg.mat' 'cur_bimg'
pause(2);
[psf] = PSF_estimation_fnct_FINAL(k_init);
psf = (psf - min(psf(:))) / (max(psf(:)) - min(psf(:)));
imwrite(psf, 'kernel05_0.01noise.png')
subplot(4, 5, 20)
imagesc(psf)
title(['PSNR: ',num2str(psnr(psf, k5))]) 

% --------------------------



