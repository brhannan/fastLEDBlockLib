function replaceBlock(oldBlock,newBlock,varargin)
%REPLACEBLOCK Replace a block.
%   FLEDBLK.BLOCKS.REPLACEBLK(OLDBLK,NEWBLK) replaces the block with path 
%   OLDBLK with the block with path NEWBLK. OLDBLK and NEWBLK are character
%   arrays that contain paths to library blocks.
%   FLEDBLK.BLOCKS.REPLACEBLK(OLDBLK,NEWBLK,'NewBlockDims',DIMS) sets the
%   width and height of the new block to the value specified in DIMS. Dims
%   is a numeric vector [width, height].
%
%   % EXAMPLE:
%       % let there be an inport called MyInport at the top level of a mask
%       % (gcb)
%       % get path to the inport
%       oldInportBlock = [gcb,'/MyInport'];
%       % replace it with a Clock
%       newClockBlock = 'simulink/Sources/Clock';
%       fledblk.blocks.replaceBlock(oldInportBlock,newClockBlock)

validateattributes(oldBlock,{'char'},{},'replaceBlock','oldBlock')
validateattributes(newBlock,{'char'},{},'replaceBlock','oldBlock')

narginchk(2,4)
opts = parseAndValidateInputs(oldBlock,newBlock,varargin{:});

pos = get_param(oldBlock,'Position');

orient = get_param(oldBlock,'Orientation');
delete_block(oldBlock);
add_block(newBlock,oldBlock,'Position',pos,'Orientation',orient);

if opts.BlkDimsProvided
    % get previous block's dimensions
    [wNow,hNow] = getBlockDims(pos);
    % get delta width, height values
    dw = opts.NewBlockDims(1) - wNow;
    dh = opts.NewBlockDims(2) - hNow;
    % adjust dimensions of new block so that its size matches the lib blk
    % oldBlock is now the current (new) block
    set_param(oldBlock,'Position',[pos(1),pos(2),pos(3)+dw,pos(4)+dh]);
end

end % replaceBlock


%--------------------------------------------------------------------------
function opts = parseAndValidateInputs(oldBlock,newBlock,varargin)

p = inputParser();
p.addRequired('oldBlock',@ischar);
p.addRequired('newBlock',@ischar);
p.addOptional('NewBlockDims',[-1,-1],@(v)isnumeric(v)&&numel(v)==2);
p.parse(oldBlock,newBlock,varargin{:});

opts = p.Results;

opts.BlkDimsProvided = ~any(opts.NewBlockDims==-1);

end % parseAndValidateInputs


%--------------------------------------------------------------------------
function [w,h] = getBlockDims(blkPos)
% get block width and height in pixels from block Position value

validateattributes(blkPos,{'numeric'},{'numel',4},'getBlockWidth','dims')

w = blkPos(3) - blkPos(1);
h = blkPos(4) - blkPos(2);

end % getBlockDims
