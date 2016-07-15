% -*- texinfo -*-
% @settitle Temperature and Moisture Visualization System
%
% @copying
% This is a short example of a complete Texinfo file, version 1.0.
%
% Copyright @copyright{} 2016 SK.
% @end copying
%
% @titlepage
% @title Sample Title
%
% @c The following two commands start the copyright page.
% @page
% @vskip 0pt plus 1filll
% @insertcopying
% @end titlepage
%
% @c Output the table of contents at the beginning.
% @contents
%
% @ifnottex
% @node Top
% @top Short Sample
%
% @example
% @code{,-----------------.
% |                 |\
% |                 | |
% `-----.     ,-----<.|  ,-----,----.    ,----.,-------.
%  \    |     |       \ /      \     \  /     /         \
%   `---|     |        '        |     \/     |    ------'\
%       |     |    .       ,    |\          / \        \  \
%       |     |    |\     /|    | \        /,-------    |-'
%       |     |    | `---' |    | |\      / \          / \
%       `-----^----' |\   \`----' | `----'   `--------'   |
%        \     \    \| `---'\    \|  \    \ / \        \ /
%         `-----`----'       `----'   `----'   `--------'}
% @end example
%
% This is a short sample Texinfo file.
% @end ifnottex
%
% @menu
% * First Chapter::    The first chapter is the
%                        only chapter in this sample.
% * Index::            Complete index.
% @end menu
%
% @node First Chapter
% @chapter First Chapter
%
% @cindex chapter, first
%
% This is the first chapter.
% @cindex index entry, another
%
% Here is a numbered list.
%
% @enumerate
% @item
% This is the first item.
%
% @item
% This is the second item.
% @end enumerate
%
% @node Index
% @unnumbered Index
%
% @printindex cp
%
% Temperature and Moisture Visualization System, or TMVS among friends,
% is a simple data exploration and analysis tool.
% Its purpose is to help work with a sizable chunk of data
% gathered from a test lab and some weather stations.
% It was originally built by Sampsa "Tuplanolla" Kiiskinen
% between 2016-06-01 and 2016-08-01 and
% supported by the funding of the JAMK University of Applied Sciences.
%
% This text explains the structure and usage of TMVS
% in addition to the @code{tmvs} helper procedure.
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the other procedures marked 'see also'.
% You can come back here and read the details
% in case you encounter something puzzling or simply become curious.
%
% @section Short Primer
%
% The documentation for TMVS is built around Texinfo
% use @code{help} frequently,
% for nice integration try
% @code{suppress_verbose_help_message (true)}
% @code{graphics_toolkit ('gnuplot')}
% @code{setenv ('GNUTERM', 'wxt noraise')}
% hit Control C to abort,
% put configs in @qcode{'~/.octaverc'},
%
% Format longer and engineering.
%
% @example
% @code{format long eng}
% @end example
%
% @section The Big Picture
%
% Assuming installation.
%
% @example
% @code{pkg install tmvs-1.0.0.tar.gz
% pkg describe -verbose tmvs}
% @end example
%
% Then.
%
% @example
% @code{pkg load tmvs
% help tmvs}
% @end example
%
% Mainly fetch.
%
% @section Data Structures
%
% Even though the system itself is quite pedestrian,
% the author has tried to impose some categorical structure on it.
%
% Look at this space.
%
% @section Notational Conventions
%
% Throughout the project
%
% @itemize @bullet
% @item the structure @var{aggr} is an aggregate
% with the fields @qcode{'id'}, @qcode{'meta'} and @qcode{'pairs'},
% @item the structure @var{interp} is an interpolator
% with the fields @qcode{'id'}, @qcode{'meta'},
% @qcode{'function'} and @qcode{'limits'},
% @item the structure @var{id} is an identifier
% with various fields like @qcode{'source'} or @qcode{'quantity'},
% @item the structure @var{meta} is a metadata container
% with various fields like @qcode{'position'} or @qcode{'material'},
% @item the string @var{fname} is a path to a regular file,
% @item the string @var{cname} is a path to a cache file,
% @item the string @var{dname} is a path to a directory,
% @item the string @var{pat} is a regular expression or a glob pattern,
% @item the string @var{ver} is a version number,
% @item the integer @var{fid} is a file or stream identifier,
% @item the integer @var{n} is a natural number,
% @item the integer @var{p} is a truth value,
% @item the variable @var{t} is a time parameter,
% @item the variable @var{mu} is a mean value,
% @item the variable @var{sigma} is a standard deviation value,
% @item the variable @var{delta} is a standard error value,
% @item the variable @var{str} is a string,
% @item the variable @var{c} is a cell array,
% @item the variable @var{s} is a structure or structure array,
% @item the variables @var{v}, @var{u} and @var{w} are vectors,
% @item the variables @var{f}, @var{g} and @var{h} are functions or procedures,
% @item the variables @var{i}, @var{j} and @var{k}
% are index scalars or vectors and
% @item the variables @var{x}, @var{y} and @var{z} are generic.
% @end itemize

% tmvs_range = @(aggr, a) tmvs_zoom (@(z) z(tmvs_withinc (z(:, 2), a), :), aggr, 'pairs');
% tmvs_range = @(aggr, a) tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(s.pairs(:, 2) >= a(1) && s.pairs(:, 2) <= a(2))), aggr);
% Remove wrong humidity, pressure, ...
% maggr = tmvs_range (aggr, [0, 99]);
% maggr = tmvs_range (aggr, [20e+3, 200e+3]);
% Remove other outliers.
% maggr = tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(tmvs_chauvenet (s.pairs(:, 2)), :)), aggr);
% Etc.
% aggr = tmvs_recall ('../data/2012/118-0.csv.tmp');
% maggr = tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(tmvs_chauvenet (s.pairs(:, 2)), :)), aggr);
% faggr = tmvs_filteru (@(s) s.id.quantity == 1 && s.id.site == 17 && s.id.surface == 1 && s.id.section == 1, maggr);
% eaggr = tmvs_evaluate (tmvs_interpolate (faggr), 734.7e+3);
% z = sortrows ([(arrayfun (@(s) s.meta.position, eaggr')), (arrayfun (@(s) s.pairs(2), eaggr'))]);
% plot (num2cell (z, 1){:});
% Project field out.
% cat (1, aggr.pairs);
% z = sortrows ([vertcat (vertcat (eaggr.meta).position), vertcat (eaggr.pairs)(:, 2)]);

%!test
%! test tmvs_version

%!test
%! test tmvs_source
%! test tmvs_quantity
%! test tmvs_site
%! test tmvs_surface
%! test tmvs_room
%! test tmvs_section
%! test tmvs_material
%! test tmvs_region
%! test tmvs_graph

%!test
%! test tmvs_brsearch
%! test tmvs_chauvenet
%! test tmvs_filters
%! test tmvs_filteru
%! test tmvs_foldl
%! test tmvs_foldr
%! test tmvs_mapl
%! test tmvs_mapr
%! test tmvs_progress
%! test tmvs_withinc
%! test tmvs_withino
%! test tmvs_zoom
