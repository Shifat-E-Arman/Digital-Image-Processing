%% Read image
IA = vl_impattern('roofs1');
IB = vl_impattern('roofs2');
%% Convert image to grayscale
Ia = single(rgb2gray(IA));
Ib = single(rgb2gray(IB));
%% Compute SIFT frames(keypoints) and descriptors
[fa,da] = vl_sift(Ia);
[fb,db] = vl_sift(Ib);
%% Matching
[matches, scores] = vl_ubcmatch(da, db);
%%
[drop, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;

figure(1) ; clf ;
imshow(cat(2, Ia, Ib)) ;
%axis image off ;
%vl_demo_print('sift_match_1', 1) ;

figure(2) ; clf ;
imshow(cat(2, Ia, Ib)) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;

%vl_demo_print('sift_match_2', 1) ;
%%
% check for sizes and take longest width and longest height into
% account
if (size(Ia,1) > size(Ib,1))
    longestWidth = size(Ia,1);       
else
    longestWidth = size(Ib,1);
end

if (size(Ia,2) > size(Ib,2))
    longestHeight = size(Ia,2);
else
    longestHeight = size(Ib,2);
end


% create new matrices with longest width and longest height
newim = uint8(zeros(longestWidth, longestHeight, 3)); %3 cuz image is RGB
newim2 = uint8(zeros(longestWidth, longestHeight, 3));

% transfer both images to the new matrices respectively.
newim(1:size(Ia,1), 1:size(Ia,2), 1:3) = Ia;
newim2(1:size(Ib,1), 1:size(Ib,2), 1:3) = Ib;

% with the same proportion and dimension, we can now show both
% images. Parts that are not used in the matrices will be black.
imshow([newim newim2]);

hold on;

    X = zeros(2,1);
    Y = zeros(2,1);

    % draw line from the matched point in one image to the respective matched point in another image.
    for k=1:numel(matches(1,:))

        X(1) = f(1, matches(1, k));
        Y(1) = f(2, matches(1, k));
        X(2) = f2(1, matches(2, k)) + longestHeight; % for placing matched point of 2nd image correctly.
        Y(2) = f2(2, matches(2, k));

        line(X,Y);

    end
