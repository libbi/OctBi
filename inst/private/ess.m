% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} {@var{ss} = } ess (@var{lws})
%
% Compute effective sample size (ESS) for given log-weights.
%
% @itemize
% @item @var{lws} Log-weights.
% @end itemize
% @end deftypefn
%
function ss = ess (lws)
    % check arguments
    if nargin != 1
        print_usage ();
    end
    if !isvector (lws)
        error ('lws must be a vector');
    end
  
    mx = max(lws');
    ws = exp (lws - max (lws));
    num = sum (ws, 2).^2;
    den = sum (ws.^2, 2);
    ss = num./den;
end