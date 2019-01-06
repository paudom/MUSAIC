%MARK_MATCH: Given a musaic and the start and finish marks for the match mark the image
%Syntax: M = mark_match(IM,match)

function M = mark_match(IM,match)

	% -- DEFINE VARIABLES -- %
	[~,numFrames,~] = size(IM);
	numPixels = 8;
    marker = numPixels/2;

	% -- FIND COORDINATES -- %
	startX = ceil(match(1)/(numFrames/numPixels))*numPixels-numPixels+1;
	startY = mod(match(1),(numFrames/numPixels))*numPixels-numPixels+1;
	finishX = ceil(match(2)/(numFrames/numPixels))*numPixels-numPixels+1;
	finishY = mod(match(2),(numFrames/numPixels))*numPixels-numPixels+1;

	% -- MARK IMAGE -- %
	pos = [startX+marker startY+marker;finishX+marker finishY+marker];
    color = {'white','white'};
    M = insertMarker(IM,pos,'s','color',color,'size',marker*2);
    M = insertMarker(M,pos,'+','color',color,'size',marker*2);
end