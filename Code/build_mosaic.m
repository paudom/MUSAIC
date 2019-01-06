%BUILD_MOSAIC: Given a HSV image, this function constructs the mosaic and save the image on a folder
%Syntax: M = build_mosaic(HSV,outFile)

function M = build_mosaic(HSV,outFile)

	% -- DEFINE VARIABLES -- %
	imageFormat = '.png';
	[~,numFrames,~] = size(HSV);
	pixel = 8;
	imageSize = ceil(sqrt(numFrames));

	% -- CONVERT IMAGE TO RGB -- %
	RGB = hsv2rgb(HSV);

	% -- RESHAPE IMAGE TO SQUARE -- %
	M = zeros(pixel*imageSize,pixel*imageSize);
	for k = 1:3
		mosaic = buffer(RGB(:,:,k),imageSize);
		[X,Y] = size(mosaic);
		if(X~=Y)
			mosaic = [mosaic zeros(imageSize,1)];
		end
		M(:,:,k) = repelem(mosaic,pixel,pixel);
	end

	% -- SAVE MOSAIC AS PNG - %
	imwrite(M,[outFile imageFormat]);
end

