% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 1687 $
% $Date: 2011-06-28 11:46:45 +0800 (Tue, 28 Jun 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{sz} = } ncsizedims (@var{nc}, @var{name})
%
% Sizes of dimensions for variable in NetCDF file.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Name of the variable.
% @end itemize
% @end deftypefn
%
function sz = ncsizedims (nc, name)
    dims = ncdim (nc{name});
    N = length (dims);
    sz = zeros (N,1);
    
    for i = 1:length (dims)
        sz(i) = dims(i){1}(:);
    end
end
