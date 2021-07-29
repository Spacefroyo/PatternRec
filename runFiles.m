close all;
clear all;
clc;

[tempC] = cellCrop();
[numCentroid] = size(tempC);
rootFolder = 'Test_images/';
imageType = '.tif';
rootFolderList = dir([rootFolder '*']);
rootFolderList = rootFolderList(3:end);
iNumFold = 0;
radius = 55;
for i = 2:length(rootFolderList)
    currName = [rootFolderList(i).name '/'];
    
    if (isfolder([rootFolder currName]))
        iNumFold = iNumFold+1;
        fileList = dir([rootFolder currName '*' imageType]);
        numFiles = length(fileList);
        mkdir([rootFolder 'Cell Images']);
        currFile = [currName(1:end-1) '.tif'];
        currFilePath = [rootFolder currFile];
        for k = 2:numFiles
            currentFile = fileList(k).name;
            fileName = [rootFolder currName currentFile];
            currImage = imread(fileName);
            [x1(iNumFold,k), y1(iNumFold,k), x2(iNumFold,k), y2(iNumFold,k)] = LineDetection(fileName);
            intensity(i-1, k-1) = lineIntensity(fileName, x1(iNumFold,k), y1(iNumFold,k), x2(iNumFold,k), y2(iNumFold,k));
        end
    end 
end

graph(intensity)
