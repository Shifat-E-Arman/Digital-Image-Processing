%% Read image
I = vl_impattern('roofs1');
image(I)
%% Convert image to grayscale
I = single(rgb2gray(I));
%% Compute SIFT frames(keypoints) and descriptors
[f,d] = vl_sift(I);
%% Visualize a random selection of 50 features
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
%% Overlay the descriptor
h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(h3,'color','g') ;