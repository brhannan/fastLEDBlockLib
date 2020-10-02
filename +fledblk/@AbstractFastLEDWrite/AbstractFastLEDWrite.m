classdef AbstractFastLEDWrite < matlab.System  ...
    & matlab.system.mixin.Propagates & matlab.system.mixin.CustomIcon
    %fledblk.AbstractFastLEDWrite Abstract FastLEDWrite class.

    %   It is assumed that the board type is AVR (see method
    %   updateBuildInfo()).

    %#codegen
    %#ok<*EMCA>

    properties (Nontunable)
        %Pin Data pin index
        %   Specify the number of the data pin that the LED strip is
        %   connected to.
        Pin = uint8(6)
        %NumLEDs Number of LEDs
        %   Specify the number of LEDs on the LED strip. The max allowed
        %   value is 255.
        NumLEDs = uint8(3)
    end

    properties (Constant, Hidden)
        %AvailablePins Allowed values for Pin on Arduino Uno.
        AvailablePins = 2:13
    end

    methods

        function obj = FastLEDWrite(varargin)
            % constructor
            setProperties(obj,nargin,varargin{:});
        end

        function set.Pin(obj,value)
            validateattributes(value,{'uint8'}, ...
                {'real','integer','scalar'},'','Pin');
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
            validateattributes(value,{'uint8'}, ...
                {'real','integer','scalar','<=',255},'', ...
                'NumLEDs');
            obj.NumLEDs = value;
        end % set.NumLEDs

    end % methods

    methods (Access=protected)

        function setupImpl(obj)
            if coder.target('Rtw')
                coder.cinclude('fastLEDWrite.h');
                coder.ceval('fastLEDInit',obj.NumLEDs,obj.Pin);
            end
        end % setupImpl

        function stepImpl(obj,u)
            if isempty(coder.target())
                % simulation setup
                % do nothing
            else
                % codegen setup
                coder.cinclude('fastLEDWrite.h');
                clr = uint8(u);
                % void fastLEDCommand(uint8_T *colors, int nleds);
                coder.ceval('fastLEDCommand',coder.ref(clr),obj.NumLEDs);
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
                    {'vector','numel',expInputLen,'>=',0,'<=',255}, ...
                    '','u');
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

    end % static methods

end % FastLEDWrite
