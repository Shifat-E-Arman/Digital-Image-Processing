close all;
clear all;
clc;
%% Read Images
in = imread('concordaerial.png');
in = rgb2gray(in);
ref = imread('concordorthophoto.png');
%% Variables
%variables for original image
[row1 col1]=size(in);
ih=uint8(zeros(row1,col1));
n1=row1 * col1;
freq1=zeros(256,1);
pdf1=zeros(256,1);
cdf1=zeros(256,1);
cum1=zeros(256,1);
out1=zeros(256,1);
%variables for reference image
[row2 col2]=size(ref);
rh=uint8(zeros(row2,col2));
n2=row2 * col2;
freq2=zeros(256,1);
pdf2=zeros(256,1);
cdf2=zeros(256,1);
cum2=zeros(256,1);
out2=zeros(256,1);
%% PDF
for r=1:row1
    for c=1:col1
        value1=in(r,c);   %intensity level of this pixel
        freq1(value1+1)=freq1(value1+1)+1;  %increment the number of pixels in this intensity level
        pdf1(value1+1)=freq1(value1+1)/n1;   %pdf %not necessary if cdf is not calculated directly from pdf
    end
end
for r=1:row2
    for c=1:col2
        value2=ref(r,c);   %intensity level of this pixel
        freq2(value2+1)=freq2(value2+1)+1;  %increment the number of pixels in this intensity level
        pdf2(value2+1)=freq2(value2+1)/n2;   %pdf %not necessary if cdf is not calculated directly from pdf
    end
end
%% CDF & Quantization
sum1=0;
L1=255;
%out = round(L*cumsum(pdf)); % cumsum of pdf is cdf
for i=1:size(pdf1)
    sum1=sum1+freq1(i);    %cumulative sum of freqency
    cum1(i)=sum1; %cumulative sum of freqency
    cdf1(i)=cum1(i)/n1;    %cdf
    %q1(i)=round(cdf1(i)*(L1-1)); %quantization
end
sum2=0;
L2=255;
%out = round(L*cumsum(pdf)); % cumsum of pdf is cdf
for i=1:size(pdf2)
    sum2=sum2+freq2(i);    %cumulative sum of freqency
    cum2(i)=sum2; %cumulative sum of freqency
    cdf2(i)=cum2(i)/n2;    %cdf
    %q2(i)=round(cdf2(i)*(L1-1)); %quantization
end
%% Mapping
M = zeros(256,1,'uint8');               
for r=1:256
    [~,s] = min(abs(cdf1(r)-cdf2));
    M(r) = s-1;
end
out = M(double(in)+1); %final image
%% Results
figure;
subplot(2,3,1);
imshow(in);
title('Original image');
subplot(2,3,2);
imshow(ref);
title('Reference image');
subplot(2,3,3);
imshow(out);
title('Final image');
subplot(2,3,4);
imhist(in);
subplot(2,3,5);
imhist(ref);
subplot(2,3,6);
imhist(out);