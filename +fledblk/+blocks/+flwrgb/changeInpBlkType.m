function changeInpBlkType(block)
%CHANGEINPBLKTYPE Change block type for FastLEDWriteRGB block.
%   FLEDBLK.BLOCKS.FLWRGB.CHANGEINPBLKTYPE(BLOCK) gets the value of the 
%   addBrighnessInport property for the FastLEDWriteRGB block with path
%   BLOCK. When addBrightnessInport is on a brightness input is added.
%   Otherwise, the Inport is replaced by a Constant block.
%
%   % EXAMPLE:
%       fledblk.blocks.flwrgb.changeInpBlkType(gcb)

validateattributes(block,{'char'},{},'changeInpBlkType','block')

addBrightInpVal = get_param(block,'addBrightnessInport');
brightVals = {'on','off'};
validatestring(addBrightInpVal,brightVals);

createBrightnessInport = strcmpi(addBrightInpVal,'on');

if createBrightnessInport
    newSrcBlk = 'simulink/Sources/In1';
    newBlkType = 'In1';
else
    newSrcBlk = 'simulink/Sources/Constant';
    newBlkType = 'Constant';
end

% set block type
blkPath = [block,'/Brightness'];
% check whether block type change is needed (if user presses OK/Apply
% without changing the add brightness inport checkbox, then no action is
% needed here)
isBlkTypeChangeNeeded = ~strcmp(get_param(blkPath,'BlockType'),newBlkType);
if isBlkTypeChangeNeeded
    dims = getDefaultBlockSize(newBlkType);
    fledblk.blocks.replaceBlock(blkPath,newSrcBlk,'NewBlockDims',dims);
    % set block properties
    if createBrightnessInport
        set_param(blkPath,'OutDataTypeStr','uint8');
        set_param(blkPath,'PortDimensions','1');
    else
        b = get_param(block,'brightness');
        set_param(blkPath,'Value',num2str(b));
        set_param(blkPath,'OutDataTypeStr','uint8');
    end
end

end % changeInpBlkType


%--------------------------------------------------------------------------
function dims = getDefaultBlockSize(blkType)
% get default block size
% block sizes are hard coded here so that get_param() deoes not fail due to
% library not loaded 

validBlkTypes = {'Clock','Constant','In1','Out1'};
blkType = validatestring(blkType,validBlkTypes);

switch blkType
    case 'Clock'
        w = 20;
        h = 20;
    case 'Constant'
        w = 30;
        h = 30;
    case 'In1'
        w = 30;
        h = 14;
    case 'Out1'
        w = 30;
        h = 30;
    otherwise
        error('Invalid block type.');
end

dims = [w,h];

end % getDefaultBlockSize