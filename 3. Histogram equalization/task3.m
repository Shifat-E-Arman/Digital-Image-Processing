clear; 
clc;
%%
A = imread('download.jpg');
a = rgb2gray(A);
%% 
[row col]=size(a);
ah=uint8(zeros(row,col));
n=row * col;
freq=zeros(256,1);
pdf=zeros(256,1);
cdf=zeros(256,1);
cum=zeros(256,1);
out=zeros(256,1);
%% PDF
for r=1:row
    for c=1:col
        value=a(r,c);   %intensity level of this pixel
        freq(value+1)=freq(value+1)+1;  %increment the number of pixels in this intensity level
        pdf(value+1)=freq(value+1)/n;   %pdf %not necessary if cdf is not calculated directly from pdf
    end
end
%% CDF & Quantization
sum=0;
L=256;
%out = round(L*cumsum(pdf)); % cumsum of pdf is cdf
for i=1:size(pdf)
    sum=sum+freq(i);    %cumulative sum of freqency
    cum(i)=sum; %cumulative sum of freqency
    cdf(i)=cum(i)/n;    %cdf
    q(i)=round(cdf(i)*(L-1)); %quantization
end
%% Reconstruct
for r=1:row
    for c=1:col
        ah(r,c)=q(a(r,c)+1);
    end
end
%% 
%% Output
subplot(6,2,1); imshow(a);
subplot(6,2,2); plot(imhist(a));
subplot(6,2,3); imshow(ah);
subplot(6,2,4); plot(imhist(ah));
%% Histogram Equalization (Built-in function)
subplot(6,2,5)
imshow(histeq(a,255))
subplot(6,2,6)
plot(imhist(histeq(a,255)))