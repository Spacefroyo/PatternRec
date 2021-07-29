function [] = write(intensity)
for i = 1:size(intensity, 1)
    time(i, 1) = i;
end
for i = 1:size(intensity, 2)
    cellIndex(1, i) = i;
end
writecell({'time'}, 'output.xlsx', 'Range', 'A2');
writecell({'cellIndex'}, 'output.xlsx', 'Range', 'B1');
writematrix(time, 'output.xlsx', 'Range', 'A3');
writematrix(cellIndex, 'output.xlsx', 'Range', 'C1');
writematrix(intensity, 'output.xlsx', 'Range', 'C3');
winopen('output.xlsx');
end

