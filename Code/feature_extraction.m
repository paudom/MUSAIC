%FEATURE_EXTRACTION: Extracts the F0 (fundamental frequency) and E (enerfy) of one frame
%Syntax: [F0,E] = feature_extraction(frame,sampleRate,numHarm,method)

function [F0,E] = feature_extraction(frame,sampleRate,numHarm,method)

	% -- DEFINE VARIABLES -- %
	range = [27.5 sampleRate/2];

	% -- COMPUTE F0 -- %
	switch method
		% -- MONOPHONIC -- %
		case 1
			F0 = pitch_cepstrum(frame,range,sampleRate,numHarm);
		case 2
			F0 = pitch_jzdt(frame,range,sampleRate,numHarm);
		otherwise
			F0 = pitch_harm(frame,range,sampleRate,numHarm);
	end

	% -- COMPUTE ENERGY -- %
    E = sqrt(sum((frame).^2));
end