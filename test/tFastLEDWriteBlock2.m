classdef tFastLEDWriteBlock2 < matlab.unittest.TestCase
    
    properties
        Mdl = 'testFastLEDWriteBlock2'
    end
    
    methods (Test)
        
        function smoke(testCase)
            load_system(testCase.Mdl);
            sim(testCase.Mdl);
            bdclose(testCase.Mdl);
        end
        
    end
    
end