% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {@var{cvar} = } get_coord_var (@var{nc}, @var{name})
%
% Get the coordinate variable associated with a given variable.
%
% @itemize
% @item @var{nc} NetCDF file handle.
%
% @item @var{name} Variable name.
% @end itemize
% @end deftypefn
%
function cvar = get_coord_var (nc, name)
    if nargin ~= 2
        print_usage ();
    end

    [s e te m txt mn] = regexp (name, '(?<prefix>.*?)_?obs$');
    if ~isempty (s)
        prefix = mn.prefix;
    else
        prefix = '';
    end
    cvars = {
        (sprintf ('coord_%s', name));
        (sprintf ('coord%s', name));
        (sprintf ('coord_%s', prefix));
        (sprintf ('coord%s', prefix));
        (sprintf ('coord'));
        };

    cvar = [];
    for i = 1:length (cvars)
        nm = cvars{i};
        if nc_has_var (nc, nm)
            cvar = nm;
            break;
        end
    end
end
