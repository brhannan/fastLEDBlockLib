function fldr = getFastLEDDriverFolder()
%GETFASTLEDDRIVERFOLDER Return the path to fastleddriver folder.
%   FLDR = FLEDBLK.UTILS.GETFASTLEDDRIVERFOLDER() called with no input arguments
%   returns the path to the /fastleddriver folder in character array FLDR.
%   /fastleddriver is the root folder for the Fast LED Simulink Library
%   project.
%
%   % EXAMPLE:
%       p = fledblk.utils.getFastLEDDriverFolder()

fledPkgFldr = fullfile(fileparts(mfilename('fullpath')));
slashIxs = regexp(fledPkgFldr,filesep);

if numel(slashIxs) < 2
    error('fledblk:utils:getFastLEDDriverFolder:invalidPath', ...
        ['Expected the path to getFastLEDDriverFolder.m (%s) to ', ...
        'contain at least two "%s" characters.'],fledPkgFldr,filesep);
end

% get second-to-last slash because parent level is two directories up
slashIx = slashIxs(end-1);

if lastSlashIx < 2
    error('fledblk:utils:getFastLEDDriverFolder:invalidPath', ...
        ['Expected final slash (%s) in the path to ' ...
        'getFastLEDDriverFolder.m (%s) to be at ix>1.'], ...
        filesep,fledPkgFldr);
end

fldr = fledPkgFldr(1:lastSlashIx-1);

end % getFastLEDDriverFolder
