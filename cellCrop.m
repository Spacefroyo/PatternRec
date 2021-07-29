function [tempC] = cellCrop()
testFolder = 'Test_images/';
imageType = '.tif';

fileList = dir([testFolder '*' imageType]);

numFiles = length(fileList);
radius = 55;
% maxCell = 20; 

if(numFiles > 0)
%     weightedCentroid = zeros(numFiles, maxCell, 2);
%     
%     centroid = zeros(numFiles, maxCell, 2);
    centroidFile = fileList(1).name;
        
    fileName = [testFolder centroidFile];
    centroidImage = imread(fileName);
    [sizeImage1,sizeImage2] = size(centroidImage);
        
    [tempWC, tempC] = cellCentroidLocate(fileName);
    [numCentroid, numCol] = size(tempC);
    for i = 1:numFiles
        currFile = fileList(i).name;  
        fileName2 = [testFolder currFile];
        
        currImage = imread(fileName2);
        %weightedCentroid(i,1:numCentroid, 1:2) = tempWC;
        %centroid(i,1:numCentroid, 1:2) = tempC;
        mkdir([testFolder currFile(1:end-4)]);
        for ci = 1:numCentroid
            currC = round(tempC(ci,:));
            xMin = currC(1) - radius;
            xMax = currC(1) + radius;
            yMin = currC(2) - radius;
            yMax = currC(2) + radius;
            if xMin < 0 || xMax > sizeImage1 || yMin < 0 || yMax > sizeImage2
                continue
            end
            currCell = currImage(yMin:yMax, xMin:xMax);
            imwrite(currCell,[testFolder currFile(1:end-4) '/' currFile(1:end-4) '_' num2str(ci) '.tif'])
        end
    end
end
end
