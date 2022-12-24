function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
numpixels = numel(origImg)/3;

% reshapes origImg so pixels = rows , RGB = columns
X = reshape(origImg, [numpixels, 3]);
X = double(X); % kmeans only takes doubles
[clusterIds, meanColors] = kmeans(X, k);

for i = 1:numpixels
    X(i,:) = meanColors(clusterIds(i),:);
end

% double values need to be rescaled
X(:,:) = X(:,:)./255;

outputImg = reshape(X, size(origImg));
end