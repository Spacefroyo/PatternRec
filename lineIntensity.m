function [intensity] = lineIntensity(imageFile, x1, y1, x2, y2)
I = imread(imageFile);
I_eq = adapthisteq(I(:, :, 1));
bw = im2bw(I_eq, graythresh(I_eq));
bw2 = imfill(bw,'holes');
bw3 = imopen(bw2, ones(5,5));
bw4 = bwareaopen(bw3, 40);

numPixels = 0;
background = [];
for i = 1 : size(I_eq, 1)
    for j = 1 : size(I_eq, 2)
        if bw4(i, j) == 1
            numPixels = numPixels + 1;
            background(numPixels) = int32(I_eq(i, j));
        end
    end
end
backgroundIntensity = 0;
background = sort(background);
IQR = background(round(numPixels*3/4))-background(round(numPixels/4));
count = 0;
for i = 1 : numPixels
    if ((background(round(numPixels/2))-(IQR*3/2) <= background(i)) && (background(round(numPixels/2))+(IQR*3/2) >= background(i)))
        backgroundIntensity = backgroundIntensity + background(i);
        count = count + 1;
    end
end
intensity = mean(improfile(I_eq, [x1 x2], [y1 y2])) - backgroundIntensity/count;

hold off
