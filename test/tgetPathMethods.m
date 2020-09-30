classdef tgetPathMethods < matlab.unittest.TestCase

    methods (Test)

        function testGetArduinoIDERoot(testCase)
            p = fledblk.getArduinoIDERoot();
            fldrExists = exist(p,'dir') == 7;
            testCase.verifyTrue(fldrExists, ...
                'Check for valid Arduino IDE root directory path.')
        end % testGetArduinoIDERoot

        function testGetArduinoAVRSPIFldr(testCase)
            p = fledblk.getArduinoAVRSPIFolder();
            fldrExists = exist(p,'dir') == 7;
            testCase.verifyTrue(fldrExists, ...
                'Check for valid /SPI/src directory path.');
        end % testGetArduinoAVRSPIFldr

    end

end % tgetPathMethods
