function p = getArduinoIDERoot()
%GETARDUINOIDEROOT Get full path to the Arduino HWSP root directory.
%   P = FLEDBLK.GETARDUINOIDEROOT returns the path to the Simulink/Arduino
%   hardware support package folder.

spkgroot = matlabshared.suppportpkg.getSupportPackageRoot();
p = fullfile(spkgroot,'3P.instrset','arduinoide.instrset');

end % getArduinoIDERoot
