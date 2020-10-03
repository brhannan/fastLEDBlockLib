classdef tFastLEDWriteBlock < matlab.unittest.TestCase
%tFastLEDWriteBlock Smoke test for a simple FastLED models.

    properties
        RGBMdl = 'testFastLEDWriteBlockRGB'
        HSVMdl = 'testFastLEDWriteBlockHSV'
    end

    methods (Test)

        function smokergb(testCase)
            load_system(testCase.RGBMdl);
            sim(testCase.RGBMdl);
            bdclose(testCase.RGBMdl);
        end
        
        function smokehsv(testCase)
            load_system(testCase.RGBMdl);
            sim(testCase.RGBMdl);
            bdclose(testCase.RGBMdl);
        end

    end

end
