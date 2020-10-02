classdef FastLEDWriteRGB < fledblk.AbstractFastLEDWrite & coder.ExternalDependency
    %fledblk.FastLEDWriteRGB Write to WS2812B LED strip using FastLED and
    %   Arduino Uno. Input is a vector of RGB values.
    %
    %   FLW = fledblk.FastLEDWriteRGB returns FastLEDWrite object FLW which
    %   can be used to control a WS2812B LED strip with an Arduino Uno.

    %   It is assumed that the board type is AVR (see method
    %   updateBuildInfo()).

    %#codegen
    %#ok<*EMCA>

    methods (Access = protected)
        function stepImpl(obj,u)
            if isempty(coder.target())
                % simulation setup
                % do nothing
            else
                % codegen setup
                coder.cinclude('fastLEDWrite.h');
                clr = uint8(u);
                coder.ceval('fastLEDCommandRGB',coder.ref(clr),obj.NumLEDs);
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
                buildInfo.addInlcudePaths(inclDir);
                buildInfo.addSourceFiles('fastLEDWriteRGB.cpp',srcDir);
                % add FastLED library source
                buildInfo.addIncludePaths(fastLEDDir);
                buildInfo.addIncludeFiles('FastLED.h');
                buildInfo.addSourceFiles('FastLED.cpp',fastLEDDir);
                % add arduino SPI source (requires AVR board)
                spiSrcPath = fledblk.utils.getArduinoAVRSPIFolder();
                buildInfo.addIncludePaths(spiSrcPath);
                buildInfo.addSourceFiles('SPI.cpp',spiSrcPath);
            end

        end % updateBuildInfo

    end % static methods

end % FastLEDWrite
