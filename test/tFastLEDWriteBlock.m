classdef tFastLEDWriteBlock < matlab.unittest.TestCase
    
    properties
        Mdl = 'testFastLEDWriteBlock'
    end
    
    methods (Test)
        
        function smoke(testCase)
            load_system(testCase.Mdl);
            sim(testCase.Mdl);
            bdclose(testCase.Mdl);
        end
        
    end
    
end