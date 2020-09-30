classdef tgetPathMethods < matlab.unittest.TestCase
%TGETPATHMETHODS Check that valid paths are returned by get path methods.

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

        function testGetFastLEDLibFldr(testCase)
            p = fledblk.getFastLEDLibFolder();
            fldrExists = exist(p,'dir') == 7;
            testCase.verifyTrue(fldrExists, ...
                'Check for valid /FastLED directory path.');
        end % testGetFastLEDLibFldr

        end %testGetFastLEDLibFldr

    end

end % tgetPathMethods
