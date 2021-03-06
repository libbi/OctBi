% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 3064 $
% $Date: 2012-09-09 15:01:02 +0800 (Sun, 09 Sep 2012) $

% -*- texinfo -*-
% @deftypefn {Function File} {} bi_plot_quantiles (@var{file}, @var{name}, @var{coord}, @var{ps}, @var{ts}, @var{col}, @var{sty})
%
% Plot LibBi output. For dynamic variables this plots the time marginals with
% a bold line giving the medians, and shaded region giving the 95% credibility
% intervals.
%
% @itemize
% @item @var{file} LibBi output file name.
%
% @item @var{name} Variable name.
%
% @item @var{coord} (optional) Dimension indices.
%
% @item @var{ps} (optional) Sample indices.
%
% @item @var{ts} (optional) Time indices.
%
% @item @var{col} (optional) Colour index.
%
% @item @var{sty} (optional) Style index.
% @end itemize
% @end deftypefn
%
function bi_plot_quantiles (file, name, coord, ps, ts, col, sty)
% check arguments
    if nargin < 2 || nargin > 7
        print_usage ();
    end
    if ~ischar (file)
        error ('file must be a string');
    end
    if ~ischar (name)
        error ('name must be a string');
    end
    if nargin < 3
        coord = [];
    elseif ~isempty (coord) && ~isvector (coord)
        error ('coord must be a vector');
    end
    if nargin < 4
        ps = [];
    elseif ~isempty (ps) && ~isvector (ps)
        error ('ps must be a vector');
    end
    if nargin < 5
        ts = [];
    elseif ~isempty (ts) && ~isvector (ts)
        error ('ts must be a vector');
    end
    if nargin < 6
        col = [];
    end
    if nargin < 7
        sty = [];
    end

    % data
    times = bi_read_times (file, name, coord, ts);
    qs = [0.025 0.25 0.5 0.75 0.975]';
    Q = bi_read_quantiles (file, name, coord, ps, ts, qs);

    % plot
    style = get_style (col, sty, file, name);
    ish = ishold;
    if ~ish
        cla % patch doesn't clear otherwise
    end
    nquantiles = size(Q,2);
    for i = 1:floor(nquantiles/2)
      area_between (times, Q(:,i), Q(:,nquantiles - i + 1), style.color, 1.0, 0.3);
      hold on
    end
    opts = struct2options(style);
    if nquantiles/2 > floor(nquantiles/2)
      plot (times, Q(:,floor(nquantiles/2) + 1), opts{:});
    end
    if ish
        hold on
    else
        hold off
    end
end
