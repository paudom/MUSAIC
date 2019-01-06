%WAVE_FORMAT: Function to standarize the input music for the system
%Syntax: [signal,sampleRate,songTitle] = wave_format(fileName)

function [signal,sampleRate,songTitle] = wave_format(fileName)

	% -- GLOBAL -- %
	global slash;

	% -- READ AUDIO-- %
	[x,Fs] = audioread(fileName);
	sampleRate = 8820;

	% -- RESAMPLE -- %
	if(sampleRate<Fs)
		signal = resample(x,sampleRate,Fs);
	else
		signal = resample(x,Fs,sampleRate);
	end

	% -- AVOID CLIPPING -- %
	signal = signal./max(abs(signal));

	% -- CONVERT TO MONO -- %
	signal = signal(:,1);

	% -- GET SONG TITLE -- %
	songTitle = strsplit(fileName,slash);
	songTitle = strsplit(songTitle{end},'.');
	songTitle = songTitle{1};
end