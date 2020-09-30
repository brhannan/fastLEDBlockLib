function p = getArduinoAVRSPIFolder()
%GETARDUINOAVRSPIFOLDER Get full path to .../avr/libraries/SPI/src.
%   P = FLEDBLK.GETARDUINOAVRSPIFOLDER returns the path to the
%   .../avr/libraries/SPI/src directory in the Simulink/Arduino HWSP.

arduinoRoot = fledblk.getArduinoIDERoot();
p = fullfile('hardware','arduino','avr','libraries','SPI','src');

end % getArduinoIDERoot
