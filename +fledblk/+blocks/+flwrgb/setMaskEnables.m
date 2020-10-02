function setMaskEnables(block)
%SETMASKENABLES Set mask enables for FastLEDWriteRGB block.

validateattributes(block,{'char'},{},'changeInpBlkType','block')

addBrightInpVal = get_param(block,'addBrightnessInport');
brightVals = {'on','off'};
validatestring(addBrightInpVal,brightVals);
createBrightnessInport = strcmpi(addBrightInpVal,'on');

masken = get_param(block,'MaskEnables');

if numel(masken) ~= 4
    error('fledblk:blocks:flwgrb:setMaskEnables:unexpectedMaskEnlen', ...
        'Expected mask enables for %s to have length 4.',block);
end

% element 3 is brightness
if createBrightnessInport
    masken{3} = 'off';
else
    masken{3} = 'on';
end

set_param(block,'MaskEnables',masken);


end % setMaskEnables