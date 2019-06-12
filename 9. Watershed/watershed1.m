clear;
clc;
%% A
f = imread('egg.jpg');
g =rgb2gray(f);
%g = mesh(f)
subplot(2,4,1)
imshow(g) 
title('Original image')
%% B
[Gx Gy] = imgradientxy(g);
L = watershed(g);
wr=L==0;
subplot(2,4,2) 
imshow(wr) 
title('Direct Watershed')
%% C: Regional Minima
rm = imregionalmin(g);
subplot(2,4,3) 
imshow(rm) 
title('Regional Minima')
%% D: Internal Markers
im = imextendedmin(g,50);
fim=g;
fim(im) = 175;
subplot(2,4,4) 
imshow(fim) 
title('Internal Markers')
%% E: External Markers
Lim = watershed(bwdist(im));
em=Lim==0;
subplot(2,4,5) 
imshow(em) 
title('External Markers')
%% F: Modified gradient image obtained from internal and external markers
g2 = imimposemin(g, im | em);
subplot(2,4,6) 
imshow(g2) 
title('Modified gradient image obtained from internal and external markers')
%% Final Segmentation Result
L2 = watershed(g2);
f2 = g;
%f2 = f(:,:,2);
f2(L2 == 0) = 255;
subplot(2,4,7) 
imshow(f2) 
title('Final Segmentation Result')
%%
imshow(f2)
