clear;
clc;
%% Image Preprocessing
I=imread('dhrubo.png');
R=I(:,:,1);
[row col]=size(R);
%% Number of quantization level or segments
levels=2;
m=256/levels;
%%
for r=1:row
    for c=1:col
        for l=0:levels-1
            if(R(r,c)>=(l-1)*m && R(r,c)<l*m)
                R(r,c)=l; 
            end
        end
    end
end

%% Scaling
scln = 255/levels;

imshow(R*scln)
