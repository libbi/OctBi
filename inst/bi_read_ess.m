% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3446 $
% $Date: 2013-02-06 02:44:37 +0800 (Wed, 06 Feb 2013) $

% -*- texinfo -*-
% @deftypefn {Function File} {y = } bi_read_ess (@var{nc}, @var{ps}, @var{ts})
%
% Read and compute effective sample size (ESS) from a LibBi output file.
%
% @itemize
% @item @var{file} LibBi output file name.
%
% @item @var{ps} (optional) Sample indices.
%
% @item @var{ts} (optional) Time indices.
% @end itemize
% @end deftypefn
%
function y = bi_read_ess (nc, ps, ts)
    % check arguments
    if nargin < 1 || nargin > 3
        print_usage ();
    end
    if nargin < 2
        ps = [];
    end
    if nargin < 3
        ts = [];
    end

    % default sizes
    if nc_has_dim (nc, 'nr')
        T = nc_dim_size (nc, 'nr');
    else
        T = 1;
    end
    if isempty (ts)
        ts = [1:T];
    end
    
    lws = bi_read_var (nc, 'logweight', [], ps, ts);
    y = ess (lws);
end
