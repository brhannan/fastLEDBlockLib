function p = getArduinoIDERoot()
%GETARDUINOIDEROOT Get full path to the Arduino HWSP root directory.
%   P = FLEDBLK.UTILS.GETARDUINOIDEROOT returns the path to the Simulink/Arduino
%   hardware support package folder.

spkgroot = matlabshared.supportpkg.getSupportPackageRoot();
p = fullfile(spkgroot,'3P.instrset','arduinoide.instrset');

end % getArduinoIDERoot
