function fldr = getFastLEDDriverFolder()
%GETFASTLEDDRIVERFOLDER Return the path to fastleddriver folder.
%   FLDR = FLED.GETFASTLEDDRIVERFOLDER() called with no input arguments 
%   returns the path to the /fastleddriver folder in character array FLDR. 
%   /fastleddriver is the root folder for the Fast LED Simulink Library 
%   project.
%
%   % EXAMPLE:
%       fledprjfldr = fled.getFastLEDDriverFolder()

fledPkgFldr = fullfile(fileparts(mfilename('fullpath')));
slashIxs = regexp(fledPkgFldr,filesep);
if isempty(slashIxs)
    error('fled:getFastLEDDriverFolder:invalidPath', ...
        ['Expected the path to getFastLEDDriverFolder.m (%s) to ', ...
        'contain at least one "%s" character.'],fledPkgFldr,filesep);
end
lastSlashIx = slashIxs(end);
if lastSlashIx < 2
    error('fled:getFastLEDDriverFolder:invalidPath', ...
        ['Expected final slash (%s) in the path to ' ...
        'getFastLEDDriverFolder.m (%s) to be at ix>1.'], ...
        filesep,fledPkgFldr);
end
fldr = fledPkgFldr(1:lastSlashIx-1);

end % getFastLEDDriverFolder