%PITCH_HARM: Detects pitch of a frame using harmonic information. 
%Syntax: F0 = pitch_jzdt(frame,range,sampleRate,limit)

function F0 = pitch_harm(frame,range,sampleRate,limit)

	% -- DEFINE VARIABLES -- %
	NFFT = length(frame);
	t = linspace(0,(1/sampleRate)*NFFT,NFFT);
	f = sampleRate*(0:NFFT/2-1)/NFFT;

	% -- COMPUTE SPECTRUM -- % 
	X = abs(fft(frame,NFFT)/NFFT); X = X(1:NFFT/2);
	X = X./max(X);

	% -- PITCH DETECTION -- %
	medianLength = 5; notValid = limit;
    weight = zeros(limit,1); harmonic = zeros(limit,1);
	for k = 1:limit
		[weight(k),harmonic(k)] = max(X);
        if(harmonic(k)==1)
            notValid = k;
            break;
        end
 		H = [round(harmonic(k)/4) round(harmonic(k)/2) harmonic(k) harmonic(k)*2 harmonic(k)*3 harmonic(k)*4];
		H(H<=medianLength) = medianLength+1; H(H>NFFT/2) = (NFFT/2)-medianLength;
 		for l = 1:length(H)
 			X(H(l)-medianLength:H(l)+medianLength) = 0;
 		end
    end

    % -- CORRECTING DETECTION -- %
    harmonic = harmonic(1:notValid);
    weight = weight(1:notValid);

    % -- COMPUTING F0 -- %
    candidates = f(harmonic)';
    F0 = sum(candidates.*weight)/sum(weight);

    % -- PITCH NOT FOUND -- %
    if(isnan(F0))
    	F0 = range(1);
    end
    
    % -- LIMITING PITCH -- %
	F0(F0>range(2)) = range(2);
	F0(F0<range(1)) = range(1);
end