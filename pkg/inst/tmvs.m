% -*- texinfo -*-
%
% @settitle GNU Octave TMVS Package
%
% @titlepage
% @title GNU Octave TMVS Package
% @subtitle User Manual
% @author Sampsa Kiiskinen
% @end titlepage
%
% @ifnotinfo
% @contents
% @end ifnotinfo
%
% @ifnottex
% @node Top
% @top
%
% @menu
% * Introduction:: What is TMVS and why does it exist?
% * Installation:: How to install and configure TMVS, Octave and Gnuplot?
% * The Big Picture:: What is TMVS made of and how does it work?
% * Getting Things Done:: How to make use of TMVS?
% * Implementation Details:: How to develop TMVS further?
% @end menu
% @end ifnottex
%
% @node Introduction
% @chapter Introduction
%
% This text explains the structure and usage of TMVS.
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the other procedures marked 'see also'.
% You can come back here and read the details
% in case you encounter something puzzling.
%
% @section Short Description
%
% Temperature and Moisture Visualization System,
% or TMVS among friends, because the name is not important,
% is a simple data exploration and analysis tool.
% Its purpose is to help work with a sizable chunk of data
% gathered from a test lab and some weather stations, covering measurements of
% temperature, humidity, pressure, precipitation and more.
% It was originally built by Sampsa "Tuplanolla" Kiiskinen
% between 2016-06-01 and 2016-07-31 and
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
% so the first step is to install GNU Octave 3.8 or newer.
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
% Test labs are by far the most important data sources.
% A typical test lab data set for one year has 13 data files,
% each of them containing approximately 130 k data points and
% requiring about 1.9 MB of memory when loaded.
%
% Each data file has a one line header with the following 5 fields.
%
% @example
% @code{Pisteen nimi|Aika|Arvo|Muotoiltu|Huomautus}
% @end example
%
% The following examples of the records demonstrate their variety.
%
% @example
% @code{KoeRakQS118 - RH118 A1 180mm 160 PUR|2011/06/29 00:05:24|46.4|46.4|
% KoeRakQS118 - T118 A1 180mm 160 PUR|2011/08/27 11:21:15|20.4|20.4|
% KoeRakAS146 Meta - AH146 A1 195mm 190EPS|2011/07/10 14:25:24|13|13.0 g/m3|}
% @end example
%
% The first field is called the name of the data point and
% is later converted into a unique identifier,
% which specifies the unit of measurement among other things.
% There are 200 different names in a typical data set.
% The second field is called the date and
% is immediately converted into a time parameter.
% The third field is the value of interest in raw form.
% The rest is discarded as garbage.
%
% The physical quantities that show up in the records are
%
% @itemize
% @item the temperature @math{T} in degrees Celsius,
% @item the relative humidity @math{R} in percents and
% @item the absolute humidity @math{A} in grams per cubic metre.
% @end itemize
%
% Of these the absolute humidity is always marked with @qcode{'Meta'},
% probably hinting that it is a derived quantity.
% @emph{This is a mystery.}
%
% @subsection Weather Station
%
% As data sources weather stations are less frequent than test labs.
% A typical weather station data set for one year has 2 data files,
% each of them containing approximately 150 k data points and
% requiring about 1.8 MB of memory when loaded.
%
% The data file format is the same as for test labs and
% the header line is, in fact, exactly the same.
% The following examples demonstrate the similarity.
%
% @example
% @code{Autiolahden s??asema - Ilmankosteus|2011/06/29 00:05:24|77|77|
% Jyv?kyl? s? - Ilmanpaine - mbar|2011/06/29 00:35:24|1018|1018.0mbar|}
% @end example
%
% The names are sometimes corrupted by failed character set conversions,
% because apparently using UTF-8 everywhere is too complicated for some people.
%
% The available physical quantities are
%
% @itemize
% @item the ambient temperature @math{T} in degrees Celsius,
% @item the ambient relative humidity @math{R} in percents,
% @item the air pressure @math{p} in millibars (hectopascals),
% @item the wind speed @math{v} in metres per second and
% @item the precipitation @math{h} in millimetres.
% @end itemize
%
% @subsection Names
%
% Since every point has a name,
% it is essential for data integrity to be able
% to recognize and parse them with zero tolerance for error.
% The following regular ANTLR 4 grammar captures
% the delicate nature of parsing names.
%
% @example
% @verbatiminclude Name.g4
% @end example
%
% While long, the grammar is mostly straightforward.
% Some notable points are that
%
% @itemize
% @item the @code{room} is sometimes present twice and
% in a sane data set those two occurrences should not conflict,
% @item the @code{position} is sometimes a few orders of magnitude too large,
% although too few for a computer to be able to tell,
% @item the @code{ordinal} is a random index and
% not necessarily correlated with the @code{position} and
% @item @code{meta} and @code{special} are strange.
% @end itemize
%
% It is possible that @code{special} is just a lazy name
% for an extra temperature sensor as its measurements indicate.
% @emph{This is a mystery.}
%
% @subsection Weather Observatory
%
% In addition to weather stations there are larger such stations
% that are henceforth called weather observatories.
% A typical weather observatory data set is condensed into a single data file,
% containing approximately 48 k data points and
% requiring about 72 kB of memory when loaded.
%
% Each data file has a two line header with the following 39 fields.
%
% @example
% @code{Date|Time|Temp Out|Hi Temp|Low Temp|Out Hum|
% Dew Pt.|Wind Speed|Wind Dir|Wind Run|Hi Speed|Hi Dir|
% Wind Chill|Heat Index|THW Index|THSW Index|Bar|SADE Tuulikorjattu|
% SADE RAAKADATA|Rain Rate|Solar Rad.|Solar Energy|Hi Solar Rad.|UV Index|
% UV Dose|Hi UV|Heat D-D|Cool D-D|In Temp|In Hum|
% In Dew|In Heat|In EMC|In Air Density|ET|Wind Samp|
% Wind Tx|ISS Recept|Arc. Int.}
% @end example
%
% Most of the fields are useless as is evident from the complete example below.
%
% @example
% @code{01.06.11|09:00:00|23.1|23.1|21.5|59|
% 14.7|2.7|WNW|9.66|8|SSW|
% 23.1|23.4|23.4|31.4|998.9|0|
% 0|0|449|38.62|496|---|
% ---|---|0|0.199|39.9|15|
% 8.4|38.2|3.37|10999|0.33|1284|
% 1|93.9|60}
% @end example
%
% The physical quantities of interest are
%
% @itemize
% @item the ambient temperature @math{T} in the field
% @code{Temp Out} in degrees Celsius,
% @item the ambient relative humidity @math{R} in the field
% @code{Out Hum} in percents,
% @item the wind speed @math{v} in either field
% @code{Wind Speed} or @code{Wind Run} in metres per second,
% @item the air pressure @math{p} in the field
% @code{Bar} in millibars (hectopascals),
% @item the precipitation @math{h} in either field
% @code{SADE Tuulikorjattu} or @code{SADE RAAKADATA} in millimetres and
% @item the sunniness @math{E} in either field
% @code{Solar Energy} or @code{Solar Rad.} in some unknown units.
% @end itemize
%
% The units for solar energy and radiation are not known,
% but are probably joules and watts per square metre respectively.
% @emph{This is a mystery.}
%
% @section Data Structures
%
% All talk and no code?
% Worry no longer!
%
% @example
% @code{struct ('id', @{(struct ('source', tmvs_source (source), ...
%                         'quantity', tmvs_quantity (quantity), ...
%                         'site', tmvs_site (site), ...
%                         'surface', tmvs_surface (surface), ...
%                         'room', tmvs_room (room), ...
%                         'section', tmvs_section (section), ...
%                         'ordinal', str2double (ordinal))),
%                (struct ('source', tmvs_source (source), ...
%                         'quantity', tmvs_quantity (quantity), ...
%                         'site', tmvs_site (site), ...
%                         'surface', tmvs_surface (surface), ...
%                         'room', tmvs_room (room), ...
%                         'ordinal', str2double (ordinal))),
%                (struct ('source', tmvs_source (source), ...
%                         'quantity', tmvs_quantity (quantity), ...
%                         'region', tmvs_region (region)))@}, ...
%         'meta', @{(struct ('position', str2double (position), ...
%                           'material', tmvs_material (material))), ...
%                  (struct ('position', str2double (position))), ...
%                  (struct ())@}, ...
%         'pairs', @{(nan (0, 2)), (nan (0, 2)), (nan (0, 2))@})}
% @end example
%
% Diff in your mind.
%
% @example
% @code{struct (fields@{:@}, ...
%         'pairs', @{(nan (0, 2)), (nan (0, 2)), (nan (0, 2))@})}
% @code{struct (fields@{:@}, ...
%         'function', @@(xi) interp ([t(1), t(2)], [x(1), x(2)], xi), ...
%         'limits', [t(1), t(2)])}
% @end example
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
