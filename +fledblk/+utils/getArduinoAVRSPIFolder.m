function p = getArduinoAVRSPIFolder()
%GETARDUINOAVRSPIFOLDER Get full path to .../avr/libraries/SPI/src.
%   P = FLEDBLK.UTILS.GETARDUINOAVRSPIFOLDER returns the path to the
%   .../avr/libraries/SPI/src directory in the Simulink/Arduino HWSP.

arduinoRoot = fledblk.utils.getArduinoIDERoot();
p = fullfile(arduinoRoot,'hardware','arduino','avr','libraries','SPI','src');

end % getArduinoAVRSPIFolder
