function replaceBlock(oldBlock,newBlock)
%REPLACEBLOCK Replace a block.
%   FLEDBLK.BLOCKS.REPLACEBLK(OLDBLK,NEWBLK) replaces the block with path 
%   OLDBLK with the block with path NEWBLK. OLDBLK and NEWBLK are character
%   arrays that contain paths to library blocks.
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

pos = get_param(oldBlock,'Position');
orient = get_param(oldBlock,'Orientation');
delete_block(oldBlock);
add_block(newBlock,oldBlock,'Position',pos,'Orientation',orient);

end % replaceBlock