clear; clc;
A = imread('download.jpg');
a = rgb2gray(A);
%% Real Image
subplot(1,2,1)
imshow(a)
subplot(1,2,2)
plot(imhist(a))
%% Histogram Equalization (Built-in function)
subplot(1,2,1)
imshow(histeq(a,255))
subplot(1,2,2)
plot(imhist(histeq(a,255)))
%% Histogram Equalization (implemented)
[row col] = size(a);
in = zeros(1,255);
out= zeros(1,255);
for r=1:row
    for c=1:col
        in(a(r,c)+1) = in(a(r,c)+1) + 1; 
    end
end
in = in/(row*col);
out = round(256-1)*cumsum(in);
stem(out);
for r=1:row
    for c=1:col
        px  = a(r,c);
        new(r,c) = out(px+1);
    end
end
new = new/255

subplot(1,2,1)
imshow(new)
subplot(1,2,2)
plot(imhist(new))
%m = max(max(max(A)))
%imshow(new)
%% Comparative Analysis
%images
subplot(3,3,1)
imshow(a)
title('original')
subplot(3,3,2)
imshow(histeq(a,255))
title('built in')
subplot(3,3,3)
imshow(new)
title('implemented')
%histograms
subplot(3,3,4)
plot(imhist(a))
subplot(3,3,5)
plot(imhist(histeq(a,255)))
subplot(3,3,6)
plot(imhist(new))