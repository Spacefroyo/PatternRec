function [] = graph(intensity)
figure
p = plot(intensity);

title('Line Intensity vs. Time')
xlabel('Image Index')
ylabel('Line Intensity')
end

