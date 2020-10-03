classdef FastLEDWriteHSV < fledblk.AbstractFastLEDWrite & coder.ExternalDependency
    %fledblk.FastLEDWriteHSV Write to WS2812B LED strip using FastLED and
    %   Arduino Uno (HSV control mode).
    %
    %   FLW = fledblk.FastLEDWriteHSV() returns FastLEDWrite object FLW
    %   which can be used to control a WS2812B LED strip with an Arduino
    %   Uno.
    %
    %   FLW = fledblk.FastLEDWriteHSV('Pin',M) sets the Pin property
    %   to value M. M is an integer that specifies the index of the data
    %   pin on the Arduino that the LED strip is connected to.
    %
    %   FLW = fledblk.FastLEDWriteHSV(...,'NumLEDs',N) specifies the
    %   number of active LEDs on the LED strip to the integer value N.
    %
    %   FLW.step(U) illuminates LEDs on the LED strip according to the
    %   values in array U. U, an array of length 3*N, contains HSV values.
    %   U has the form [H1, S1, V1, H2, S2, V2, ..., HN, SN,VN].

    % It is assumed that the board type is AVR (see method
    % updateBuildInfo()).

    %#codegen
    %#ok<*EMCA>

    methods (Access = protected)
        function stepImpl(obj,u,~)
            if isempty(coder.target())
                % simulation setup
                % do nothing
            else
                % codegen setup
                coder.cinclude('fastLEDWrite.h');
                clr = uint8(u);
                coder.ceval('fastLEDCommandHSV',coder.ref(clr),obj.NumLEDs);
            end
        end % stepImpl
    end

    methods (Static)

        function updateBuildInfo(buildInfo,context)
            % when code is generated, we assume that the FastLEDWrite root
            % directory contains three subdirectories: include, src and
            % FastLED, which contains all FastLED library code
            %
            % it is assumed that the board type is AVR

            if context.isCodeGenTarget('rtw')
                % get paths to src, include and FastLED directories
                pkgRoot = fledblk.utils.getFastLEDDriverFolder();
                fastLEDDir = fledblk.utils.getFastLEDLibFolder();
                srcDir = fullfile(pkgRoot,'src');
                inclDir = fullfile(pkgRoot,'include');
                % add custom source files
                buildInfo.addIncludePaths(inclDir);
                buildInfo.addSourceFiles('fastLEDWriteHSV.cpp',srcDir);
                % add FastLED library source
                buildInfo.addIncludePaths(fastLEDDir);
                buildInfo.addIncludeFiles('FastLED.h');
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);
                buildInfo.addSourceFiles('hsv2rgb.cpp',fastLEDDir);
                % add arduino SPI source (requires AVR board)
                spiSrcPath = fledblk.utils.getArduinoAVRSPIFolder();
                buildInfo.addIncludePaths(spiSrcPath);
                buildInfo.addSourceFiles('SPI.cpp',spiSrcPath);
            end

        end % updateBuildInfo

    end % static methods

end % FastLEDWrite
