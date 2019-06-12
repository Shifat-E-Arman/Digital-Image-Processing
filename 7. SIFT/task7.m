clear; clc;
%% Read image
IA = imread('cat2.jpg');
IB = imread('cat&dog.jpg');
%% Convert image to grayscale
Ia = single(rgb2gray(IA));
Ib = single(rgb2gray(IB));
%% Compute SIFT frames(keypoints) and descriptors
[fa,da] = vl_sift(Ia);
[fb,db] = vl_sift(Ib);
%% Matching
[matches, scores] = vl_ubcmatch(da, db);
%%
figure(1) ; 
imshow(cat(2, IA, IB)) ;

figure(2) ; 
imshow(cat(2, IA, IB)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

%hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ; % first image scale
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ; % second image scale


%% References
%https://www.youtube.com/watch?v=PU6BKIh1y4o
%https://stackoverflow.com/questions/5565225/sift-feature-matching-through-euclidean-distance-matlab-help-pls
%https://github.com/vlfeat/vlfeat/blob/master/toolbox/demo/vl_demo_sift_match.m
%https://docs.opencv.org/3.4/da/df5/tutorial_py_sift_intro.html