clear;clc;
%% Read images
A = imread('woman1.jpg');
B = imread('woman2.jpg');
C = imread('clown1.jpg');
%% Histogram
h1 = imhist(A);
h2 = imhist(B);
%% Contrast Stretching
D = imadjust(A,stretchlim(A));
E = imadjust(B,stretchlim(B));
%% Log & Power Transformation
Ad = im2double(A);
L = Ad;
P = Ad;
c = 5;
[row,col]=size(A);
for x = 1:row
    for y = 1:col
        L(x,y)=c*log(1+Ad(x,y));
        P(x,y)=c*Ad(x,y)^2;
    end
end
%% Results
subplot(7,2,1);imshow(A);title('woman1'); 
subplot(7,2,2);stem(h1);title('woman1'); 
subplot(7,2,3);imshow(D);title('cs1'); 
subplot(7,2,4);stem(imhist(D));;title('cs1');
subplot(7,2,5);imshow(B);title('woman2');
subplot(7,2,6);stem(h2);title('woman2');
subplot(7,2,7);imshow(E);title('cs2');
subplot(7,2,8);stem(imhist(E));title('cs2');
subplot(7,2,9);imshow(A);title('woman1')
subplot(7,2,10);stem(imhist(A));title('woman1')
subplot(7,2,11);imshow(L);title('log')
subplot(7,2,12);stem(imhist(L));title('log')
subplot(7,2,13);imshow(P);title('power')
subplot(7,2,14);stem(imhist(P));title('power')