%SIGNAL_BUFFER: Stores a matrix representing a buffer for both channels
%Syntax [signal,numFrames] = flac_buffer(filename)

function [signal,numFrames] = signal_buffer(audioSignal,sampleRate)

	% -- AUDIO VARIABLES -- %
	time = 128E-3/2;
	frameLength = 2^nextpow2(time*sampleRate);
	numFrames = ceil(length(audioSignal)/frameLength);

	% -- WINDOW OF 2N -- %
	window = zeros(frameLength*2,numFrames);
	H = hamming(frameLength*2);
	for k = 1:numFrames window(:,k) = H; end

	% -- FILL BUFFER (OVERLAP 50%)-- %
	signal = buffer(audioSignal,frameLength*2,frameLength);

	% -- APPLY WINDOW -- %
	signal = window.*signal;
end