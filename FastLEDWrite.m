classdef FastLEDWrite < matlab.System & coder.ExternalDependency ...
    & matlab.system.mixin.Propagates & matlab.system.mixin.CustomIcon
    %FastLEDWrite Write to WS2812B LED strip using FastLED and Arduino Uno.
    %   FLW = FastLEDWrite returns FastLEDWrite object FLW which can be
    %   used to control a WS2812B LED strip through an Arduino Uno.
    %
    %   It is assumed that the board type is AVR (see method
    %   updateBuildInfo()).

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
        end % set.Pin

        function set.NumLEDs(obj,value)
            validateattributes(value,{'numeric'}, ...
                {'real','positive','integer','scalar'},'','NumLEDs');
            obj.NumLEDs = value;
        end % set.NumLEDs

    end % methods

    methods (Access=protected)

        function setupImpl(obj)
            if coder.target('Rtw')
                coder.cinclude('myFastLED.h');
                coder.ceval('fastLEDInit',uint8(obj.NumLEDs));
            end
        end % setupImpl

        function stepImpl(obj,u)
            dummyrgb = zeros(3*obj.NumLEDs,1,'uint8');
            if isempty(coder.target())
                % simulation setup
                % do nothing
            else
                % codegen setup
                coder.cinclude('myFastLED.h');
                clr = uint8(u);
                % void fastLEDCommand(uint8_T *colorArray, int *totLEDs);
                coder.ceval('fastLEDCommand',coder.ref(clr), ...
                                                coder.wref(dummyrgb));
            end
        end % stepImpl

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

        function validateInputsImpl(obj,u)
            if isempty(coder.target)
                % validate inputs in simulation mode
                expInputLen = 3 * obj.NumLEDs;
                validateattributes(u,{'numeric'}, ...
                    {'vector','numel',expInputLen},'','u');
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
            %
            % it is assumed that the board type is AVR

            if context.isCodeGenTarget('rtw')
                % get paths to src, include and FastLED directories
                pkgRoot = fled.getFastLEDDriverFolder();
                fastLEDDir = fled.getFastLEDSourceFolder();
                srcDir = fullfile(pkgRoot,'src');
                inclDir = fullfile(pkgRoot,'include');

                % include /include and /FastLED
                buildInfo.addIncludePaths(inclDir);
                buildInfo.addIncludePaths(fastLEDDir);

                % add custom source files myFastLED.cpp, FastLED.cpp
                buildInfo.addSourceFiles('myFastLED.cpp',srcDir);
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);

                % add FastLED source
                buildInfo.addIncludeFiles('FastLED.h');
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);

                % add arduino source
                % the code below is only supported for AVR boards
                ideRoot = codertarget.arduinobase.internal.getArduinoIDERoot('libraries');
                spiSrcPath = fullfile(ideRoot,'hardware','arduino', ...
                                        'avr','libraries','SPI','src');
                buildInfo.addIncludePaths(spiSrcPath);
                buildInfo.addSourceFiles('SPI.cpp',spiSrcPath);
            end

        end % updateBuildInfo

    end % static methods

end % FastLEDWrite
