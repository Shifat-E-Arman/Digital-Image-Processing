%% Read image
clear; clc;
I = imread('4-lane-road.jpg');
I = rgb2gray(I);
I = imgaussfilt(I,2);
%% Find the edges in the image using the |edge| function. 
BW = edge(I,'prewitt');
imshow(BW);
%% Compute the Hough transform of the binary image returned by |edge|.
[H,theta,rho] = hough(BW);
% H is the accumulator array
% theta contains the possible values of theta
% rho contains the possible values of rho
%% Find the peaks in the Hough transform matrix, |H|, using the |houghpeaks| function.
P = houghpeaks(H,1);
% houghpeaks(H,numpeaks)
% P contains row and column coordinates of peaks found.
% Which lines peak will be taken if only one peak is taken.
%% Find lines in the image using the |houghlines| function.
lines = houghlines(BW,theta,rho,P,'fillgap',10,'minlength',0.1);
% Length of lines is the number of merged line segment found.
% point1 is an end-point of the line
% point1 is an end-point of the line
% theta s theta
% row is row
%% Create a plot that displays the original image with the lines superimposed on it.
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
