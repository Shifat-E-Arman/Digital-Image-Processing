I = imread('problem_one.png');
%I = rgb2gray(I);
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
subplot(132); imshow(med_final); title('Sharpened image using median filter')
subplot(133); imshow(avg_final); title('Sharpened image using average filter')