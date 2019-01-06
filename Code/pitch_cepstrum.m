%PITCH_CEPSTRUM: Detects the pitch using cepstrum method.
%Syntax: F0 = pitch_cepstrum(frame,range,sampleRate,limit)

function F0 = pitch_cepstrum(frame,range,sampleRate,limit)

	% -- DEFINE VARIABLES -- %
	NFFT = length(frame); 
	t = linspace(0,(1/sampleRate)*NFFT,NFFT); 
	f = sampleRate*(0:NFFT/2-1)/NFFT;

    % -- CEPSTRUM -- %
    C = ifft(log(abs(fft(frame,NFFT)).^2)); C = C(1:NFFT/2);
    
    % -- CLEAR CEPSTRUM SIGNAL -- % 
    Nmax = floor(sampleRate/range(1));
    Nmin = ceil(sampleRate/1200);
    C(1:Nmin) = 0; C = C(1:Nmax); C = C/max(C);

    % -- PITCH DETECTION -- %
    medianLength = 5; notValid = limit;
    weight = zeros(limit,1); location = zeros(limit,1);
    for k = 1:limit
    	[weight(k),location(k)] = max(C);
        if(location(k)==1)
        	notValid = k;
            break;
        end
        location(location<=medianLength) = medianLength+1;
        location(location>=Nmax-medianLength) = Nmax-medianLength;
    	C(location(k)-medianLength:location(k)+medianLength) = 0;
    end

    % -- CORRECTING DETECTION -- %
    location = location(1:notValid);
    weight = weight(1:notValid);

    % -- COMPUTING F0 -- %
    candidate = sum(location.*weight)./sum(weight);
    F0 = sampleRate/candidate;
    
    % -- PITCH NOT FOUND -- %
    if(isnan(F0))
    	F0 = range(1);
    end
    
	% -- LIMITING PITCH -- %
	F0(F0>range(2)) = range(2);
	F0(F0<range(1)) = range(1);
end