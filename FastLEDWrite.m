classdef FastLEDWrite < matlab.System & coder.ExternalDependency ...
    & matlab.system.mixin.Propagates & matlab.system.mixin.CustomIcon
    %FastLEDWrite Write to WS2812B LED strip using FastLED and Arduino Uno.
    %   FLW = FastLEDWrite returns FastLEDWrite object FLW which can be
    %   used to control a WS2812B LED strip through an Arduino Uno.
    
    %#codegen
    %#ok<*EMCA>
    
    properties (Nontunable)
        %Pin Data pin that the LED strip is connected to.
        %   Specify the number of the data pin that the LED strip is
        %   connected to.
        Pin = 5
    end
    
    properties (Constant, Hidden)
        %AvailablePins Allowed values for Pin on Arduino Uno.
        AvailablePins = 2:13;
    end
    
    methods
        
        function obj = FastLEDWrite(varargin)
            % constructor
            coder.allowpcode('plain');
            setProperties(obj,nargin,varargin{:});
        end
        
        function set.Pin(obj,value)
            coder.extrinsic('sprintf') % Do not generate code for sprintf
            validateattributes(value,{'numeric'}, ...
                {'real','positive','integer','scalar'},'','Pin');
            assert(any(value == obj.AvailablePins), ...
                'Invalid value for Pin. Pin must be one of the following: %s', ...
                sprintf('%d ',obj.AvailablePins));
            isPinValid = any(value==obj.AvailablePins);
            if ~isPinValid
                error('FastLEDWrite:set:Pin:invalidPinValue', ...
                    ['Pin is invalid. Pin must be one of the ' ...
                    'following: %s.'],num2str(obj.AvailablePins));
            end
            obj.Pin = value;
        end
        
    end % methods
    
    methods (Access=protected)
        
        function setupImpl(obj)
            if coder.target('Rtw')
                coder.cinclude('myFastLED.h');
                coder.ceval('mysetup',obj.Pin);
            end
        end
        
        function stepImpl(~,u)
            if coder.target('Rtw')
                coder.ceval('mywrite',u);
            end
        end
        
        function releaseImpl(obj) %#ok<MANU>
        end
        
    end % protected methods
    
    methods (Access=protected)
        
        function num = getNumInputsImpl(~)
            num = 1;
        end
        
        function num = getNumOutputsImpl(~)
            num = 0;
        end
        
        function flag = isInputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isInputFixedSizeImpl(~,~)
            varargout{1} = true;
        end
        
        function flag = isInputComplexityLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isInputComplexImpl(~)
            varargout{1} = false;
        end
        
        function validateInputsImpl(~,u)
            if isempty(coder.target)
                % execute this in simulation only
                validateattributes(u,{'logical','double'}, ...
                    {'scalar','binary'},'','u');
            end
        end
        
        function icon = getIconImpl(~)
            icon = 'FastLED Write';
        end
        
    end % protected methods
    
    methods (Static, Access=protected)
        
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
        
    end % static protected methods
    
    methods (Static)
        
        function name = getDescriptiveName()
            name = 'FastLED Write';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                rootDir = fled.getFastLEDDriverFolder();
                
                fleddir = fled.getFastLEDSourceFolder(); % fullfile(rootDir,'FastLED');
                srcDir = fullfile(rootDir,'src');
                
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludePaths(fleddir);
                
                buildInfo.addIncludeFiles('myFastLED.h');
                buildInfo.addSourceFiles('myFastLED.cpp',srcDir);
                
                buildInfo.addIncludeFiles('FastLED.h');
                buildInfo.addSourceFiles('FastLED.cpp',fleddir);
            end
        end
        
    end % static methods
    
end % FastLEDWrite
