close all;
clear all;
clc;
%% Read Images
i = imread('concordaerial.png');
Img = rgb2gray(i);
r = imread('concordorthophoto.png');
%Ref = rgb2gray(r);
Ref = r;
%% Number of pixels
[row1 col1]=size(Img);
n1 = row1 * col1;
[row2 col2]=size(Ref);
n2 = row2 * col2;
%% Computing CDF
cdf1 = cumsum(imhist(Img));
cdf1 = cumsum(imhist(Img))/n1;  % Normalize
cdf2 = cumsum(imhist(Ref));  
cdf2 = cumsum(imhist(Ref))/n2;   % Normalize
%% Computing the mapping
M = zeros(256,1,'uint8');               
for r=1:256
    [~,s] = min(abs(cdf1(r)-cdf2));
    M(r) = s-1;
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