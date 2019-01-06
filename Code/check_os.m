%CHECK_OS: Returns the type of slash used by the operating system usde to move trhpugh directories
%Syntax: slash = check_os()

function slash = check_os()

	% -- GET SLASH TYPE -- %
	if(ispc)
		slash = '\';
	else
		slash = '/';
	end
end