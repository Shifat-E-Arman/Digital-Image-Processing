%% Read images
im = imread('coins.png');
e = edge(im, 'canny');
imshow(e)
%% Circle Hough Transform
Rmin = 30;
Rmax = 65;
[centersBright, radiiBright] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','bright');
[centersDark, radiiDark] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','dark');
imshow(im)
hold on
viscircles(centersBright, radiiBright,'Color','b');
viscircles(centersDark, radiiDark,'LineStyle','--');
