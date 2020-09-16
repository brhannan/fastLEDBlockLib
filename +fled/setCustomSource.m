function setCustomSource(mdl,srcfile)
%SETCUSTOMSOURCE Set a model's CustomSource config param.
%   FLED.SETCUSTOMSOURCE(MDL,SRCFILE) sets the CustomSource parameter for
%   the model MDL to the value SRCFILE. The current value of
%   CustomSource will be overwritten.
%
%   SRCFILE must be a character array. When specifying more than one file,
%   use spaces to separate entries.
%   
%   % EXAMPLE:
%       fled.setCustomSource(bdroot,'mySrcFile.cpp')

validateattributes(mdl,{'char'},{})
validateattributes(srcfile,{'char'},{})
set_param(mdl,'CustomSource',srcfile)

end