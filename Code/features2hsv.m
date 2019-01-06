%CONVERT_HSI: converts the features extracted to HSI
%Syntax: [HSV,octave,note] = features2hsv(F0,E,numFrames)

function [HSV,octave,note] = features2hsv(F0,E,numFrames)

	% -- DEFINE VARIABLES -- %
    reference = 27.5;
    hue = [0 30 60 90 120 150 180 210 240 270 300 330]/360;
    valThresh = 7; 

	% -- GET OCTAVE & MUSICAL SCALE -- %
	octave = floor(log2(F0./reference));
	note = 1+floor((F0-(reference*2.^octave))./((reference*2.^octave)/12));

	% -- NORMALIZE ENERGY -- %
    
	O = rescale((octave/valThresh),(min(octave)+1)/8,(max(octave)+1)/8);
	E = E./max(E); E = rescale(E,0.5,1);
    
	% -- CONVERT HSI -- %
	H = hue(note);
	S = E;
	V = O;
    
	% -- CREATE HSV IMAGE -- %
	HSV = zeros(1,numFrames,3);
	HSV(:,:,1) = H; HSV(:,:,2) = S; HSV(:,:,3) = V;
end