function [x1, y1, x2, y2] = LineDetection(imageFile)
% imageFile = 'One Cell.tif';
I = imread(imageFile);
I = im2gray(I(:,:,1));
level = 0.99;
BW = imbinarize(I,level);
%imshowpair(I, BW, 'montage');
[H,theta,rho] = hough(BW);
P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
lines = houghlines(BW,theta,rho,P,'FillGap',100,'MinLength',2);
%imshow(I), hold on
if (~isempty(lines))
   xy = [lines(1).point1; lines(1).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   x1 = xy(1,1);
   y1 = xy(1,2);
   x2 = xy(2,1);
   y2 = xy(2,2);
else
    disp(['No lines founded: ', imageFile]);
    x1 = 0;
    y1 = 0;
    x2 = 0;
    y2 = 0;
end

end