%MATCH_MOSAIC: Given a small sample of an audio transform it to colour and compare it to the database.
%Syntax: [outFile,error,match] = match_mosaic(inFile,databasePath,method,numHarm)

function [outFile,error,match] = match_mosaic(inFile,databasePath,method,numHarm)

	% -- ITERATE THROUGH DATABASE -- %
	file = dir([databasePath '*_' num2str(method) '_' num2str(numHarm) '.png']);
    if(~isempty(file))
        % -- CONVERT SAMPLE TO HSV -- %
        [HSV,~] = music2colour(inFile,numHarm,method);
        % -- CONVERT TO RGB -- %
        [~,numFrames,~] = size(HSV);
        RGB = hsv2rgb(HSV);
        % -- FIND MATCHES -- %
        MinError = zeros(1,length(file));
        match = zeros(1,length(file));
        w = waitbar(0,'SEARCHING A MATCH SONG...');
        for k = 1:length(file)
            M = imread([databasePath file(k).name]);
            M = M(1:8:end,1:8:end,:);
            M = double(reshape(M,1,[],size(M,3)))./256;
            [~,musicFrames,~]=size(M);
            zeroPadding = (ceil(musicFrames/numFrames)*numFrames)-musicFrames;
            M = [M zeros(1,zeroPadding,3)];
            L = musicFrames-numFrames;
            Error = zeros(1,L,3);samples = 0;
            for l = 1:L
                Error(1,l,:) = mean((M(1,samples+1:samples+numFrames,:)-RGB).^2);
                samples = samples+1;
            end
            [MinError(k),match(k)] = min(sum(Error,3));
            waitbar((k/length(file)),w,sprintf('REMAINING MATCHES (%d OUT OF %d)',k,length(file)));
        end
        % -- CLOSE WAITBAR -- %
        close(w);
        % -- COMPUTE ERROR -- %
        [error,position] = min(MinError);
        match = [match(position) match(position)+numFrames];
        outFile = file(position).name;
    else
       match = 0;
       error = 0;
       outFile = 'None'; 
    end
end