close all;
clear all;
clc;
%% Read Images
i = imread('concordaerial.png');
Img = rgb2gray(i);
%Img = i;
r = imread('concordorthophoto.png');
%Ref = rgb2gray(r);
Ref = r;
k = numel(Img);
%% Computing CDF
cdf1 = cumsum(imhist(Img))/numel(Img);  % cdf of original image
cdf2 = cumsum(imhist(Ref))/numel(Ref);  % cdf of reference image
%% Computing the mapping
M = zeros(256,1,'uint8');               % Mapping - casted to uint8
for r=1:256
    [~,s] = min(abs(cdf1(r)-cdf2));
    M(r) = s-1;     % s-1 here because s goes from 1 to 256 but M(r) ranges from 0 to 255
end
%% Now apply the mapping to get the final image
out = M(double(Img)+1);
%% Results
% Display all the images
figure(1);
set(gcf, 'Position', get(0, 'ScreenSize'));
subplot(231),imshow(Img),title('Original Image');
subplot(232),imshow(Ref),title('Reference Image');
subplot(233),imshow(out),title('Final Image');
% display the histograms
subplot(234),imhist(Img),title('Histogram :Original Image');
subplot(235),imhist(Ref),title('Histogram :Reference Image');
subplot(236),imhist(out),title('Histogram :Final Image');