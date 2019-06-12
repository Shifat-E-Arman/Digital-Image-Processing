clear; clc;
%% Read image
IA = imread('Roll01_left_b copy.JPG');
IB = imread('Roll01_left_b_gt.jpg');
%% Convert image to grayscale
Ia = single(rgb2gray(IA));
Ib = single(rgb2gray(IB));
%% Compute SIFT frames(keypoints) and descriptors
[fa,da] = vl_sift(Ia);
[fb,db] = vl_sift(Ib);
imshow(IA)
%% Visualizing features - fa
perm = randperm(size(fa,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(fa(:,sel)) ;
h2 = vl_plotframe(fa(:,sel)) ;

set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
%% Visualizing descriptors - da
h3 = vl_plotsiftdescriptor(da(:,sel),fa(:,sel)) ;
set(h3,'color','g') ;
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