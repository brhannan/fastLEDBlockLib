function fldr = getFastLEDSourceFolder()
%GETFASTLEDSOURCEFOLDER Return the path to FastLED library folder.
%   FLDR = FLED.GETFASTLEDSOURCEFOLDER() called with no input arguments
%   returns the path to the /FastLED folder in character array FLDR.
%   FastLED is the folder that contains the source code from the FastLED
%   GitHub repository. That is, the folder tree under /FastLED should look
%   like this:
%
%   /FastLED
%       |- /docs
%       |- /examples
%       |- /extras
%       |- /lib8tion
%       ...
%       |- FastLED.cpp
%       ...
%
%   It is assumed that this folder is contained in the /fastleddriver
%   folder and that its name is "FastLED" (not "FastLED-master"). If your
%   folder has a different name or location, modify this function so that
%   the appropriate path is returned.
%
%   % EXAMPLE:
%       fastLedLibFldr = fled.getFastLEDSourceFolder()

% get the root folder for the FastLED Simulink library project
fledPkgFldr = fled.getFastLEDDriverFolder();

% we expect to find the FastLED library folder in this directory
folderName = 'FastLED';
fldr = fullfile(fledPkgFldr,folderName);

end % getFastLEDDriverFolder
