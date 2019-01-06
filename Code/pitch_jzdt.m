%PITCH_JZDT: Detects pitch of a frame using harmonic information. It uses only the first 5 harmonics.
%Syntax: F0 = pitch_jzdt(frame,range,sampleRate)

function F0 = pitch_jzdt(frame,range,sampleRate,limit)

	% -- DEFINE VARIABLES -- %
	NFFT = length(frame);
	t = linspace(0,(1/sampleRate)*NFFT,NFFT);
	f = sampleRate*(0:NFFT/2-1)/NFFT;

	% -- COMPUTE SPECTRUM -- % 
	X = abs(fft(frame,NFFT)/NFFT).^2; X = X(1:NFFT/2);
	X = X./max(X);

	% -- PITCH DETECTION -- %
	medianLength = 5; notValid = limit;
    weight = zeros(limit,1); location = zeros(limit,1);
    for k = 1:limit
    	[weight(k),location(k)] = max(X);
        if(location(k)==1)
        	notValid = k;
            break;
        end
        location(location<=medianLength) = medianLength+1;
        location(location>=(NFFT/2)-medianLength) = (NFFT/2)-medianLength;
    	X(location(k)-medianLength:location(k)+medianLength) = 0;
    end

    % -- CORRECTING DETECTION -- %
    location = location(1:notValid);
    weight = weight(1:notValid);

    % -- COMPUTING F0 -- %
    candidates = f(location)';
    F0 = sum(candidates.*weight)./sum(weight);
    
    % -- PITCH NOT FOUND -- %
    if(isnan(F0))
    	F0 = range(1);
    end
    
    % -- LIMITING PITCH -- %
	F0(F0>range(2)) = range(2);
	F0(F0<range(1)) = range(1);
end