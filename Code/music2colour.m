%MUSIC2COLOUR: function that transforms the audio selected into a HSV image.
%Syntax: [HSV,outFile,octave,note] = music2colour(fileName,numHarm,method)

function [HSV,outFile,octave,note] = music2colour(fileName,numHarm,method)

	% -- SET PROGRESS BAR -- %
    progress = 0;

	% -- READ AUDIO -- %
	w = waitbar(progress,'READING SELECTED AUDIO...');
	[wave,sampleRate,songTitle] = wave_format(fileName);
	waitbar(progress+1,w,'DONE');

	% -- CONVERT WAVE TO FRAMES -- %
	[signal,numFrames] = signal_buffer(wave,sampleRate);

	% -- GET FEATURES -- %
	waitbar(progress,w,sprintf('GETTING FEATURES (%d OUT OF %d)',0,numFrames));
	F0 = zeros(1,numFrames);
	E = zeros(1,numFrames);
	for k = 1:numFrames
		[F0(k),E(k)] = feature_extraction(signal(:,k),sampleRate,numHarm,method);
		waitbar((k/numFrames),w,sprintf('GETTING FEATURES (%d OUT OF %d)',k,numFrames));
    end
    waitbar(progress+1,w,'DONE');

	% -- CONVERT FEATURES TO HSV -- %
	[HSV,octave,note] = features2hsv(F0,E,numFrames);

	% -- CONSTRUCT OUTFILE -- %
	outFile = [songTitle '_' num2str(method) '_' num2str(numHarm)];

	% -- CLOSE WAITBAR -- %
	close(w);

end