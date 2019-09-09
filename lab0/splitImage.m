function splitImage(image_path)
OG_image = imread(image_path);
[height, width, channels] = size(OG_image);
upperLeftChunk = OG_image(1:height / 2, 1:width/ 2, :);
bottomLeftChunk = OG_image((height / 2)+1:end, 1:width / 2, :);
upperRightChunk = OG_image(1:height / 2, (width / 2) + 1: end, :);
bottomRightChunk = OG_image((height / 2)+1:end, (width / 2) + 1: end, :);
plotTo2x2Grid({upperLeftChunk, bottomLeftChunk, upperRightChunk, bottomRightChunk});
end