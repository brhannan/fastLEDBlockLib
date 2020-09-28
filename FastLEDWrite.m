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
        %NumLEDs
        %   Specify the number of LEDs.
        NumLEDs = 3
    end

    properties (Constant, Hidden)
        %AvailablePins Allowed values for Pin on Arduino Uno.
        AvailablePins = 2:13;
    end

    methods

        function obj = FastLEDWrite(varargin)
            % constructor
            setProperties(obj,nargin,varargin{:});
        end

        function set.Pin(obj,value)
            validateattributes(value,{'numeric'}, ...
                {'real','positive','integer','scalar'},'','Pin');
            assert(any(value == obj.AvailablePins), ...
                ['Invalid value for Pin. Pin must be one of the '      ...
                'following: %s'], ...
                num2str(obj.AvailablePins));
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
                coder.ceval('fastLEDInit',obj.NumLEDs);
            end
        end

        function stepImpl(obj,u)
            dummyrgb = zeros(3*obj.NumLEDs,1,'uint8');
            if isempty(coder.target())
                % simulation setup
                % do nothing
            else
                % codegen setup
                coder.cinclude('myFastLED.h');
                clr = uint8(u);
                coder.ceval('fastLEDCommand',coder.ref(clr), ...
                                                coder.wref(dummyrgb));
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
                % validate inputs in simulation mode
                validateattributes(u,{'numeric'},{'vector'},'','u');
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

        function updateBuildInfo(buildInfo,context)
            % when code is generated, we assume that the FastLEDWrite root
            % directory contains three subdirectories: include, src and
            % FastLED, which contains all FastLED library code
            if context.isCodeGenTarget('rtw')
                rootDir = fled.getFastLEDDriverFolder();

                % get paths to src, include and FastLED directories
                fastLEDDir = fled.getFastLEDSourceFolder();
                srcDir = fullfile(rootDir,'src');
                inclDir = fullfile(rootDir,'include');

                % include /include and /FastLED
                buildInfo.addIncludePaths(inclDir);
                buildInfo.addIncludePaths(fastLEDDir);

                % add source files myFastLED.cpp, FastLED.cpp
                buildInfo.addSourceFiles('myFastLED.cpp',srcDir);
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);

                buildInfo.addIncludeFiles('FastLED.h');
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);
            end

            % hcs = getActiveConfigSet(gcs);
            % if codertarget.arduinobase.internal.isArduinoDue(hcs);
            %     boardType = 'SAM';
            % elseif codertarget.arduinobase.internal.isArduinoMKR1000(hcs);
            %     boardType = 'SAMD';
            % else
            %     boardType = 'AVR';
            % end

            boardType = 'AVR';

            fileNameToAdd = {'SPI.cpp'};
            switch boardType
                case 'AVR'
                    [ideRootPath,~] = codertarget.arduinobase.internal.getArduinoIDERoot('libraries');
                    addIncludePaths(buildInfo,fullfile(ideRootPath,'hardware','arduino','avr','libraries','SPI','src'));
                    srcFilePath = fullfile(ideRootPath,'hardware','arduino','avr','libraries','SPI','src');
                    addSourceFiles(buildInfo,fileNameToAdd,srcFilePath);
                case 'SAM'
                    [~,libSAMPath] = codertarget.arduinobase.internal.getArduinoIDERoot('libraries');
                    addIncludePaths(buildInfo,fullfile(libSAMPath,'SPI','src'));
                    srcFilePath = fullfile(libSAMPath,'SPI','src');
                    addSourceFiles(buildInfo,fileNameToAdd,srcFilePath);
                case 'SAMD'
                    [~,libSAMPath] = codertarget.arduinobase.internal.getArduinoIDERoot('libraries');
                    addIncludePaths(buildInfo,fullfile(libSAMPath,'SPI'));
                    srcFilePath = fullfile(libSAMPath,'SPI');
                    addSourceFiles(buildInfo,fileNameToAdd,srcFilePath);
                otherwise
                    error('Unrecognized board type: %s.',boardType);
            end
        end

    end % static methods

end % FastLEDWrite
