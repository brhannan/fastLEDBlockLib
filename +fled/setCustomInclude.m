function setCustomInclude(mdl,incldir)
%SETCUSTOMINCLUDE Set a model's CustomInclude config param.
%   FLED.SETCUSTOMINCLUDE(MDL,INCLDIR) sets the CustomInclude parameter for
%   the model MDL to the value INCLDIR. The current value of
%   CustomInclude will be overwritten.
%
%   INCLDIR must be a character array. When specifying more than one
%   folder, use spaces to separate entries.
%   
%   % EXAMPLE:
%       fled.setCustomInclude(bdroot,'path/to/my/includes/folder')

validateattributes(mdl,{'char'},{})
validateattributes(incldir,{'char'},{})
set_param(mdl,'CustomInclude',incldir)

end