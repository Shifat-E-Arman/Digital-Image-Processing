I = imread('tasin.jpg');
I = rgb2gray(I);
%% Unsharp Masking Using Median Filter
M = medfilt2(I);
edges = I-M;
med_final = I+edges;
subplot(121); imshow(M)
subplot(122); imshow(med_final)
%% Average
A = imfilter(I,fspecial('average'),'replicate');
edges = I-A;
avg_final = I+edges;
subplot(122); imshow(A)
subplot(122); imshow(avg_final)
%% Result
subplot(131); imshow(I); title('Original')
subplot(132); imshow(med_final); title('Median')
subplot(133); imshow(avg_final); title('Average')
%% Gradient
[Gx, Gy] = imgradientxy(I);
subplot(121); imshow(Gx); title('Gx')
subplot(122); imshow(Gy); title('Gy')