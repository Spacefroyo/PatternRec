function [weightedCellCentroid, cellCentroid] = cellCentroidLocate(imageFile)
%imageFile = 'Cell 25s.tif';
I = imread(imageFile);
I_eq = adapthisteq(I);
%imshow(I_eq)
bw = imbinarize(I_eq, graythresh(I_eq));
%imshow(bw)
bw2 = imfill(bw,'holes');
bw3 = imopen(bw2, ones(5,5));
bw4 = bwareaopen(bw3, 40);
%bw4_perim = bwperim(bw4);
%overlay1 = imoverlay(I_eq, bw4_perim, [.3 1 .3]);
%imshow(bw4)
s = regionprops(bw4,I,{'Centroid','WeightedCentroid'});
%figure, imshow(I)
% title('Weighted (red) and Unweighted (blue) Centroids'); 
% hold on
numObj = numel(s);
for k = 1 : numObj
    %plot(s(k).WeightedCentroid(1), s(k).WeightedCentroid(2), 'r*')
    weightedCellCentroid(k,:) = [s(k).WeightedCentroid(1), s(k).WeightedCentroid(2)];
   % plot(s(k).Centroid(1), s(k).Centroid(2), 'bo')
    cellCentroid(k,:) = [s(k).Centroid(1), s(k).Centroid(2)];
end
end