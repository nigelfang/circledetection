function [centers] = detectCircles(im, edges, radius, top_k) 
im = rgb2gray(im);
% quantization_value = 5;
binSize = 5;
h = zeros(size(im'));

for i = 1:size(edges,1) % every point x,y
    x = edges(i,1);
    y = edges(i,2);
    theta = edges(i,4); % estimated gradient direction at (x,y)
    a = x - radius * cosd(theta);
    b = y - radius * sind(theta);
    aBin = ceil(a/binSize);
    bBin = ceil(b/binSize);
    if aBin <= 0 || bBin <= 0
        continue
    end
    h(aBin,bBin) = h(aBin,bBin) + 1;
end

% finds k max values in h
centers = zeros(top_k,2);
for k = 1:top_k
    ind1 = 0;
    ind2 = 0;
    max = 0;
    for aBin = 1:size(h,1)
        for bBin = 1:size(h,2)
            if h(aBin,bBin) > max
                max = h(aBin,bBin);
                ind1 = aBin;
                ind2 = bBin;
            end
        end
    end
    h(ind1,ind2) = 0;
    % revert bin index back to a,b 
    centers(k,1) = ind1 * binSize;
    centers(k,2) = ind2 * binSize;
end

end