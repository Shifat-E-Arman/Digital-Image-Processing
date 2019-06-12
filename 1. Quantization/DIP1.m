clear;
clc;
%% Read image
I=imread('dhrubo.png');
A=I(:,:,1); % Take only 1 channel of the image
[m n]=size(A); % No. of row and column of the image
level=2; % No. of levels
Range(1,1)=0;

for l=1:level
    Range(1,l+1)=floor((255/level)*l);
end

for i=1:m
    for j=1:n
        for l=1:level
            if(l==level)
                A(i,j)=255;
            end
            if(A(i,j)>=Range(1,l)&&A(i,j)<Range(1,l+1))
                A(i,j)=Range(1,l);
                break;
            end
        end
    end
end
imshow(A)
