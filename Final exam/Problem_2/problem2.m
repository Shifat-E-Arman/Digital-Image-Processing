clear; 
clc;
%%
a = imread('problem_two.tif');
%% Histogram
[row col]=size(a);
ah=uint8(zeros(row,col));
n=row * col;
L = zeros(256,1);
freq=zeros(256,1);
pdf=zeros(256,1);
cdf=zeros(256,1);
cum=zeros(256,1);
out=zeros(256,1);
%% PDF
for r=1:row
    for c=1:col
        value=a(r,c);   
        freq(value+1)=freq(value+1)+1;  
        pdf(value+1)=freq(value+1)/n;   
    end
end
%% CDF & Quantization
sum=0;
L=256;
for i=1:size(pdf)
    sum=sum+freq(i);   
    cum(i)=sum; 
    cdf(i)=cum(i)/n;    
    q(i)=round(cdf(i)*(L-1)); 
end
%% Output - Original Image
subplot(131)
imshow(a);
title('Original image')
subplot(132)
stem(freq)
title('Histogram')
subplot(133)
stem(cdf)
title('Cumulative Histogram')
%% Reconstruct
for r=1:row
    for c=1:col
        ah(r,c)=q(a(r,c)+1);
    end
end
%% Histogram
[row col]=size(ah);
n=row * col;
L = zeros(256,1);
freq=zeros(256,1);
pdf=zeros(256,1);
cdf=zeros(256,1);
cum=zeros(256,1);
out=zeros(256,1);
%% PDF
for r=1:row
    for c=1:col
        value=ah(r,c);
        freq(value+1)=freq(value+1)+1;  
        pdf(value+1)=freq(value+1)/n;  
    end
end
%% CDF & Quantization
sum=0;
L=256;
for i=1:size(pdf)
    sum=sum+freq(i);  
    cum(i)=sum; 
    cdf(i)=cum(i)/n;    
    q(i)=round(cdf(i)*(L-1)); 
end
%% Output - Transformed Image
subplot(131)
imshow(ah);
title('Transformed image')
subplot(132)
stem(freq)
title('Histogram')
subplot(133)
stem(cdf)
title('Cumulative Histogram')
%% Comparison between transformed image obtained from implemented and built-in function
subplot(2,2,1)
imshow(ah)
title('Transformed image - Implemented function')
subplot(2,2,2)
stem(freq)
title('Transformed image histogram - Implemented function')
subplot(2,2,3)
imshow(histeq(a,255))
title('Transformed image - Builtin Function')
subplot(2,2,4)
stem(imhist(histeq(a,255)))
title('Transformed image histogram - Builtin Function')