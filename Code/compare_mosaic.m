%COMPARE_MOSAIC: given two images, compares the two images giving different metrics
%Syntax: [MSE,ADF] = compare_mosaic(file1,file2)

function [MSE,ADF] = compare_mosaic(file1,file2)

	% -- SET FLAG -- %
	MSE = 0; ADF = 0;

	% -- GET IMAGE INFO -- %
	fileInfo1 = imfinfo(file1);
	fileInfo2 = imfinfo(file2); 

	% -- READ IMAGES -- %
	M1 = imread(file1);
	M2 = imread(file2);

	% -- GET MINIMUM SIZE -- % 
	commonSize = min(fileInfo1.Width,fileInfo2.Width);

	% -- MODIFY IMAGES -- %
	M1 = M1(1:commonSize,1:commonSize,:);
	M2 = M2(1:commonSize,1:commonSize,:);
    
    % -- TRANSFORM TO HSV -- %
    H1 = rgb2hsv(M1);
    H2 = rgb2hsv(M2);

	% -- GET ADF -- %
	Diff = imabsdiff(H1,H2);
    ADF = hsv2rgb(Diff);
    
    % -- GET MSE -- %
    MSE = sum(sum(sum(Diff)))/(commonSize^2);

end