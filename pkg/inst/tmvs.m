% -*- texinfo -*-
% @documentencoding UTF-8
%
% @settitle TMVS
%
% @ifhtml
% @contents
% @end ifhtml
%
% @ifnottex
% @node Top
% @top
%
% @menu
% * Preface:: How to read this manual?
% * Introduction:: What is TMVS and why does it exist?
% * Installation:: How to install and configure TMVS, Octave and Gnuplot?
% * The Big Picture:: What is TMVS made of and how does it work?
% * Getting Things Done:: How to make use of TMVS?
% * Quirks in the Source Data:: What the hell?
% * Implementation Details:: How to develop TMVS further?
% @end menu
% @end ifnottex
%
% @node Preface
% @chapter Preface
%
% This text explains the structure and usage of TMVS.
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the other procedures marked 'see also'.
% You can come back here and read the details
% in case you encounter something puzzling.
%
% @node Introduction
% @chapter Introduction
%
% Temperature and Moisture Visualization System,
% or TMVS among friends, because the name is not important,
% is a simple data exploration and analysis tool.
% Its purpose is to help work with a sizable chunk of data
% gathered from a test lab and some weather stations,
% covering temperature, humidity, pressure, precipitation and more.
% It was originally built by Sampsa "Tuplanolla" Kiiskinen
% between 2016-06-01 and 2016-08-01 and
% supported by the funding of the JAMK University of Applied Sciences.
%
% Even though TMVS itself is quite pedestrian,
% the author has tried to impose some mathematical structure on it.
% For example data structures are built from algebraic sum and product types,
% data flow is designed in terms of category theory and many transformations
% are adapted or at least inspired by functional programming.
% This hopefully makes the system easier to use and understand.
%
% @node Installation
% @chapter Installation
%
% TMVS is an Octave package,
% so the first step is to install Octave 3.8 or newer.
% Installing a graphics toolkit like Gnuplot is also recommended,
% although it is not strictly necessary for data manipulation.
% For example Debian and Ubuntu have Octave and Gnuplot
% in their package repositories,
% making the installation as easy as running the following shell command.
%
% @example
% @code{apt-get install octave gnuplot gnuplot-x11}
% @end example
%
% Once Octave is in working order,
% TMVS can be installed with the @code{pkg} command.
% The following example does just that with the assumption that
% the package file is in the current working directory of Octave.
% If this is not the case, you can either
% provide the full path to the file (use @code{help pkg} for details) or
% navigate to the appropriate directory with @code{cd} first.
% It is generally a good idea to skim the help pages
% of all the commands you are about to run regardless.
%
% @example
% @code{pkg install tmvs-1.0.0.tar.gz}
% @end example
%
% To verify that the installation was successful and
% to inspect what the package contains, @code{pkg} is again useful.
%
% @example
% @code{pkg describe -verbose tmvs}
% @end example
%
% If everything went according to plan,
% the package can be loaded into the current Octave session as follows.
%
% @example
% @code{pkg load tmvs}
% @end example
%
% After loading the package you can use
% any of the procedures matching @file{tmvs_*},
% read their help pages with @code{help} or
% even view this manual through Octave in the following fashion.
%
% @example
% @code{help tmvs}
% @end example
%
% @section Additional Configuration
%
% There are a few things that can be configured for a better user experience.
% The commands for doing so can either
% be manually entered at the beginning of each session or
% put into the @file{.octaverc} file inside your home directory.
%
% @subsection Help Pages
%
% This manual notwithstanding,
% TMVS is solely documented by the help pages of its procedures.
% That is why it is essential to make heavy use of the @code{help} command.
%
% By default @code{help} is unnecessarily verbose and
% prints repetitive and unnecessary messages after each page that is requested.
% Having read the messages once, it is a good idea to them turn off.
%
% @example
% @code{suppress_verbose_help_message (true)}
% @end example
%
% @subsection Graphics Toolkit
%
% There are various graphics toolkits that Octave can use for plots.
% Further, some toolkits like Gnuplot have various terminals
% for viewing the output or interacting with it.
% The interactive features of TMVS are only guaranteed to work
% with Gnuplot as the toolkit and X11 as the terminal.
% They can be chosen with the following commands.
%
% @example
% @code{graphics_toolkit ('gnuplot')
% setenv ('GNUTERM', 'x11')}
% @end example
%
% It is worth experimenting with other options too,
% such as the wxWidgets terminal without automatic focus.
%
% @example
% @code{setenv ('GNUTERM', 'wxt noraise')}
% @end example
%
% @subsection Number Format
%
% Some physical quantities used by TMVS
% have more precision than what Octave typically shows.
% For example two times in 2012 that are five minutes apart are represented
% by @code{734869.003472} and @code{734869.006944} respectively.
% To make such differences visible without manual processing,
% the number format can be changed to, say, the long engineering format.
%
% @example
% @code{format long eng}
% @end example
%
% @section Sample Data
%
% TMVS comes with a sample data set
% that can be located with the following command.
%
% @example
% @code{which ('excerpt')}
% @end example
%
% It is based on a real data set that has been sparsened and shuffled
% enough to make it useless for data analysis,
% but not too much to keep it sufficient for testing.
% These steps have been taken for two reasons:
% to keep the data set small and to not step on the toes of the rights owners.
%
% @node The Big Picture
% @chapter The Big Picture
%
% This chapter explains the structure and usage of TMVS
% by treating it as a black box.
% No attention is paid to the inner workings.
%
% @section Source Data
%
% The source data comes from three different sources and
% is stored in comma-separated value files.
% The files are extracted from Excel files and
% scattered in an indeterminate directory structure
% without a consistent naming scheme.
% Besides the field separator is actually @qcode{'|'} instead of @qcode{','},
% so it would be more accurate to simply call them value files.
%
% Since there are a dozen subtly different yet incompatible value file formats,
% it is important to be more specific.
% The following regular ANTLR 4 grammar describes the structure of the files.
%
% @example
% @verbatiminclude CSV.g4
% @end example
%
% This grammar is the only thing the data sources have in common,
% so let us go through each of them in turn.
%
% @subsection Test Lab
%
% Test lab is by far the most important type of data source.
% A typical test lab data set for one year has 13 data files,
% each of them containing approximately 130 k data points and
% requiring about 1.9 MB of memory.
%
% Each data file has a header declaring the following 5 fields.
%
% @example
% @code{Pisteen nimi|Aika|Arvo|Muotoiltu|Huomautus}
% @end example
%
% Examples follow.
%
% @example
% @code{KoeRakPS120 - RH120 A1 180mm 160 EPS|2011/01/30 00:33:03|50.4|50.4|
% KoeRakFL140 - T140 L01 42800mm|2011/02/22 17:43:03|4|4|
% KoeRakGL140 - lisa140|2011/02/09 11:23:03|23|23|}
% @end example
%
% The physical quantities of interest are
%
% @section Data Structures
%
% Look at this space.
%
% @section Data Flow
%
% Look at this space.
%
% @image{data-flow, 6in}
%
% @node Getting Things Done
% @chapter Getting Things Done
%
% @section Complete Examples
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
%
% @node Quirks in the Source Data
% @chapter Quirks in the Source Data
%
% @node Implementation Details
% @chapter Implementation Details
%
% Ha!

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
