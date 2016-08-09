% -*- texinfo -*-
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
% @ifhtml
% @node Top
% @top
%
% @menu
% * Introduction:: What is TMVS and why does it exist?
% * Installation:: How to install and configure TMVS, Octave and Gnuplot?
% * Source Data:: What does TMVS work with?
% * The Big Picture:: How is TMVS structured and how does it work?
% * Complete Examples:: How to make use of TMVS?
% * Implementation Details:: Why is TMVS the way it is and
% how can it be developed TMVS further?
% @ifset helppages
% * Help Pages:: What do the help pages contain?
% @end ifset
% @end menu
% @end ifhtml
%
% @node Introduction
% @chapter Introduction
%
% This text explains the structure and usage of TMVS.
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the help pages for the relevant procedures.
% You can come back here and read the details
% in case you encounter something puzzling.
%
% @section Short Description
%
% Temperature and Moisture Visualization System,
% or TMVS among friends, because the name is not important,
% is a simple data exploration and analysis tool.
% Its purpose is to help work with a sizable chunk of data
% gathered from a test lab and some weather stations.
% The measurements themselves cover
% temperature and humidity inside building materials and
% pressure, precipitation and more outside.
%
% TMVS was originally built by Sampsa "Tuplanolla" Kiiskinen
% between 2016-06-01 and 2016-08-09.
% It was the result of a project course at the University of Jyv@"askyl@"a and
% was supported by the funding of JAMK University of Applied Sciences.
% Further development and maintenance was passed on to interested parties.
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
% provide the full path to the file (see @code{help pkg} for details) or
% navigate to the appropriate directory first
% (see @code{help pwd} and @code{help cd}).
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
% any of the procedures listed by @code{pkg},
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
% put into the @file{.octaverc} file inside your home directory,
% which is automatically sourced at the beginning of each session.
%
% @subsection Help Pages
%
% This manual notwithstanding,
% TMVS is solely documented by the help pages of its procedures.
% That is why it is essential to make good use of the @code{help} command.
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
% It is worth experimenting with other options too.
% For example the author favors
% the wxWidgets terminal with automatic focus turned off and
% occasionally uses the noninteractive text-only terminal too.
%
% @example
% @code{setenv ('GNUTERM', 'wxt noraise')}
% @example
%
% @end example
% @code{setenv ('GNUTERM', 'dumb')}
% @end example
%
% @subsection Number Format
%
% Some physical quantities used by TMVS
% have more precision than what Octave typically shows.
% For example two times in 2012 that are five minutes apart are represented
% by @code{734869.003472} and @code{734869.006944} respectively.
% To make such differences visible without additional manual processing,
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
% The location naturally varies depending on the installation.
%
% @example
% @code{which ('excerpt')}
% @print{} 'excerpt' is the file /usr/share/octave/packages/tmvs-1.0.0/excerpt
% @end example
%
% It is based on a real data set that has been sparsened and shuffled,
% enough to make it useless for data analysis,
% but not too much to keep it sufficient for testing.
% These steps have been taken for two reasons:
% to keep the data set small and to not step on the toes of the rights owners.
%
% Note that by default TMVS stores cache files
% in the same directory as the data files,
% so it might be a good idea to copy the sample data set into another location
% before working with it.
% In the examples to follow the sample data set is assumed to be
% in the current working directory.
%
% @node Source Data
% @chapter Source Data
%
% First and foremost it is important to note that,
% like any sensible data management system,
% TMVS never modifies or deletes source data.
% It may scatter cache files into the directory of the source files,
% but does so very carefully, to prevent accidental data corruption or loss.
% While all custom file management procedures have such safeguards,
% Octave commands like @code{unlink} can still be destructive.
%
% @section Common Structure
%
% The source data comes from three different sources and
% is stored in comma-separated value files.
% The files are extracted from Excel files and
% scattered in an indeterminate directory structure
% without a consistent naming scheme.
%
% Since there are a dozen subtly different yet incompatible value file formats,
% it is important to be more specific.
% The field separator is actually @qcode{'|'} instead of @qcode{','} and
% quotation is only possible with @qcode{'"'}.
% The following regular ANTLR 4 grammar
% describes the structure of the files precisely.
%
% @example
% @verbatiminclude CSV.g4
% @end example
%
% This grammar is the only thing the data sources have in common,
% so let us go through each of them in turn and highlight the differences.
%
% @section Test Labs
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
% KoeRakQS118 - T118 A1 180mm 160 PUR|2011/08/27 11:21:15|20.4|20.4|}
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
% @section Weather Stations
%
% As data sources weather stations are less frequent than test labs.
% A typical weather station data set for one year has 2 data files,
% each of them containing approximately 150 k data points and
% requiring about 1.8 MB of memory when loaded.
%
% The data file format is the same as for test labs and
% the header line is, in fact, exactly the same.
% The following example records demonstrate the similarity.
%
% @example
% @code{Autiolahden s??asema - Ilmankosteus|2011/06/29 00:05:24|77|77|
% Jyv?kyl? s? - Ilmanpaine - mbar|2011/06/29 00:35:24|1018|1018.0mbar|}
% @end example
%
% The names are sometimes corrupted by failed character set conversions,
% because apparently using UTF-8 everywhere is still too difficult.
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
% @section Names
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
% in a sane data set those two occurrences should be equal,
% @item the @code{position} is sometimes a few orders of magnitude too large,
% although too few for a computer to be able to tell,
% @item the @code{ordinal} is a random index and
% not necessarily correlated with the @code{position} and
% @item @code{meta} and @code{special} are silly.
% @end itemize
%
% It is possible that @code{special} is just a lazy name
% for an extra temperature sensor as its measurements indicate.
% @emph{This is a mystery.}
%
% @section Weather Observatories
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
% @code{Bar} in millibars (hectopascals) and
% @item the precipitation @math{h} in either field
% @code{SADE Tuulikorjattu} or @code{SADE RAAKADATA} in millimetres.
% @end itemize
%
% @section Other Quirks
%
% The fun does not end with the mysterious bookkeeping in the source files as
% occasionally some sensors record nonsensical data.
% Observe that
%
% @itemize
% @item relative humidity sensors may get stuck at 100 % for a while
% if the temperature quickly drops when the humidity is high,
% because that allows water to condense on the sensor,
% @item pressure sensors may report near-vacuum pressures at random,
% probably due to fluctuations in their power supplies and
% @item sensors that should be right next to each other
% may report systematically and significantly differing values,
% which suggests a calibration problem.
% @end itemize
%
% Alas the sensors are of unknown origin,
% so investigating these discrepancies is difficult.
% @emph{This is a mystery.}
%
% @node The Big Picture
% @chapter The Big Picture
%
% This chapter explains the structure and usage of TMVS
% with broad strokes and by treating it as a black box.
% Details are glossed over and no attention is paid to the inner workings.
% If something is confusing,
% just keep reading or refer to the appropriate help pages.
%
% @section Data Structures
%
% TMVS essentially converts data files into structure arrays,
% which are called aggregates.
% The aggregates are then merged by need to produce larger aggregates.
%
% Each structure in an aggregate has
%
% @itemize
% @item the field @qcode{'id'},
% which uniquely identifies that particular element,
% @item the field @qcode{'meta'},
% which may contain metadata relating to the identifier and
% @item the field @qcode{'pairs'},
% which contains an array of the data points for the identifier.
% @end itemize
%
% Further, each row of the data point array has time in days
% (because that is also what Octave uses internally) on the first column, and
% a physical quantity in basic and unprefixed SI units
% (metres, pascals, what have you) on the second column.
% The rows are sorted chronologically and conflicting rows are not allowed
% (that is, there are never two different values for the same point in time).
%
% The following aggregate containing values from various data sources
% should give you the idea.
%
% @example
% @code{aggr = struct ( ...
%   'id', @{(struct ('source', tmvs_source ('Test Lab'), ...
%                   'quantity', tmvs_quantity ('Temperature'), ...
%                   'site', tmvs_site ('Q'), ...
%                   'surface', tmvs_surface ('Wall'), ...
%                   'room', tmvs_room ('118'), ...
%                   'section', tmvs_section ('Bottom Corner'), ...
%                   'ordinal', 3)), ...
%          (struct ('source', tmvs_source ('Weather Station'), ...
%                   'quantity', tmvs_quantity ('Precipitation'), ...
%                   'region', tmvs_region ('Autiolahti'))), ...
%          (struct ('source', tmvs_source ('Weather Observatory'), ...
%                   'quantity', tmvs_quantity ('Wind Speed'), ...
%                   'region', tmvs_region ('Jyvaskyla')))@}, ...
%   'meta', @{(struct ('position', 295e-3, ...
%                     'material', tmvs_material ('Polyurethane'))), ...
%            (struct ()), (struct ())@}, ...
%   'pairs', @{[734691.059525, 20.1; ...
%              734806.153646, 3.6; ...
%              735007.154769, 16.7], ...
%             [734723.045440, 3.1e-03; ...
%              734775.657118, 7.7e-03], ...
%             [734719.000000, 0.9]@});}
% @end example
%
% Uncertainties are not stored within the data.
% If needed, they can be computed separately
% from the identifier and the measured value.
%
% @example
% @code{tmvs_uncertainty (aggr(1).id, aggr(1).pairs(:, 2))}
% @result{} [1; 1; 1]
% @end example
%
% To perform computations, the aggregate can be converted into an interpolator.
%
% @example
% @code{interp = tmvs_interpolate (aggr);}
% @end example
%
% In an interpolator the @qcode{'pairs'} field
% is simply replaced by a @qcode{'function'} function field,
% along with its @qcode{'domain'} and @qcode{'codomain'}.
% Assuming @var{fields} is a cell array
% containing the definitions for @qcode{'id'} and @qcode{'meta'} and
% @var{t} and @var{q} are arrays of times and measured values respectively,
% the following structures illustrate the difference
% between a singleton aggregate and the equivalent interpolator.
%
% @example
% @code{aggr = struct (fields@{:@}, ...
%   'pairs', [t, q]);}
% @end example
%
% @example
% @code{interp = struct (fields@{:@}, ...
%   'function', @@(x) interp1 (t, q, x), ...
%   'domain', [t(1), t(end)], ...
%   'codomain', [q(1), q(end)]);}
% @end example
%
% Within the domain of the function the interpolator works
% as the name suggests: by interpolation.
% Going outside the domain raises an error or,
% if so desired, triggers extrapolation.
%
% @section Data Flow
%
% Data flow in and out of TMVS obeys the following diagram.
% The boxes represent data structures or storage locations and
% the ovals represent operations on them.
% Multiplicities are obviously not marked and
% some unimportant operations have been omitted altogether.
%
% @image{data-flow, 6in}
%
% The main takeaway is that the easiest way to produce an aggregate is
% to fetch it from the data file via the cache mechanism.
% Anything beyond that is up to your imagination.
%
% This reproduces the first example from the previous section.
%
% @example
% @code{tlaggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% wsaggr = tmvs_fetch ( ...
%   'excerpt/2012/autiolahti-0.csv', tmvs_source ('Weather Station'));
% woaggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));
% aggr = tmvs_merge ( ...
%   tlaggr(9), wsaggr(4), overfield (@@(z) z(1, :), woaggr(3), 'pairs'));}
% @end example
%
% @section Caching
%
% It would be quite dandy if computers had unlimited resources and
% every computation finished immediately.
% Unfortunately this is not the case.
% Importing a typical value file with 120 k records
% takes about 5 minutes on commodity hardware.
% Doing this for every data file collected from the last 5 years
% would bump the required time investment up to 7 hours.
% Since the data files are essentially static,
% caching can be used to solve this performance problem
% without causing a massive increase
% in development effort or hardware requirements.
%
% With caching each file only needs to be parsed once,
% after which a copy of the result is stored in a better format.
% The copy is then kept and used as if it was the original data file.
% This fetching process is around 20 times faster
% than importing data files directly and
% happens completely transparently to the user.
%
% The following microbenchmark should drive the point home.
%
% @example
% @code{tic
% aggr = tmvs_fetch ('excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% toc}
% @print{} Elapsed time is 0.112992 seconds.
% @code{tic
% aggr = tmvs_fetch ('excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% toc}
% @print{} Elapsed time is 0.012532 seconds.
% @end example
%
% By default the cache mechanism stores things in the free HDF5 format
% (the name is short for Hierarchical Data Format,
% which was originally developed
% by the National Center for Supercomputing Applications),
% because this makes cache versioning really fast.
% However you can instruct the storage procedure to use another format
% if you want to optimize for disk space or compatibility instead.
%
% @example
% @code{fname = 'excerpt/2012/118-0.csv';
% aggr = tmvs_fetch (fname, tmvs_source ('Test Lab'));
% tmvs_store (tmvs_cachename (fname), aggr, '-mat', '-zip');}
% @end example
%
% @section Enumerations
%
% It is essential to represent things like data sources and physical quantities
% in a form that is both storable and readable.
% Most programming languages offer enumerations or other equivalent mechanisms
% for defining such forms.
% Octave does not.
%
% To work around this minor shortcoming, enumerating functions exist
% for converting between storable and readable forms.
% The following examples demonstrate this in isolation.
%
% @example
% @code{tmvs_quantity ('Relative Humidity')}
% @result{} 2
% @code{tmvs_quantity (2)}
% @result{} 'Relative Humidity'
% @end example
%
% @section Functional Programming
%
% TMVS comes with a small collection of higher-order functions
% for doing functional programming.
% They are not mandatory for any use case
% (the same operations can always be done
% with conditional jumps and mutable state),
% but they significantly shorten the code in many places.
%
% As an example, consider finding the minimum
% of all the wall temperatures during the spring of 2012.
%
% @example
% @code{aggr = tmvs_fetchall ( ...
%   'excerpt/2012/[0-9]*.csv', tmvs_source ('Test Lab')); % Everything.
% f = @@(s) s.id.quantity == tmvs_quantity ('Temperature');
% faggr = filteru (f, aggr); % Temperatures only.
% r = [(datenum (2012, 3, 1)), (datenum (2012, 6, 1))];
% g = @@(z) z(withinc (z(1), r), :);
% gaggr = overfield (g, faggr, 'pairs'); % Spring only.
% foldl (@@(q, s) min ([q, s.pairs(:, 2)]), gaggr, inf)}
% @result{} 8
% @end example
%
% The imperative equivalent is somewhat more verbose.
% The proof of this is left to the reader.
%
% @node Complete Examples
% @chapter Complete Examples
%
% This chapter presents some common uses of TMVS as literate programs.
% Explanations are presented in the comments
% to allow copying and running the programs as-is.
%
% @section Visualizing Interesting Things
%
% The following program draws three different visualizations.
%
% @example
% @code{% Load all the data points for room 118.
% % This part relies on the source files
% % following a certain directory structure and naming convention.
% aggr = tmvs_fetchall ('excerpt/*/118-0.csv', tmvs_source ('Test Lab'));
%
% % Remove all the data points that exceed the permissible limits.
% % The limits are very lenient,
% % so some dubious data points may still be left.
% saggr = tmvs_sanitize (aggr);
%
% % Only keep the data points from those sensors
% % that meet the required criteria.
% % The resulting aggregate corresponds to the complete history
% % of a line passing through a certain wall.
% f = @@(s) ...
%   s.id.quantity == tmvs_quantity ('Temperature') && ...
%   s.id.site == tmvs_site ('Q') && ...
%   s.id.surface == tmvs_surface ('Wall') && ...
%   s.id.section == tmvs_section ('Bottom Corner');
% faggr = filteru (f, saggr);
%
% % Pick one sensor from the line in particular.
% % This produces an aggregate with only one identifier left.
% ffaggr = filteru (@@(s) s.id.ordinal == 3, faggr);
%
% % Visualize the complete time evolution
% % of the temperature measured by the chosen sensor.
% % The result is drawn into figure 1.
% tmvs_drawp (ffaggr, 1);
%
% % Visualize the temperature as a sparse three-dimensional surface.
% % The surface appears in figure 2.
% tmvs_draws (faggr, 2);
%
% % Visualize the temperature interactively.
% % The interactive point cloud is placed into figure 3 and
% % the chosen projection is subsequently shown in figure 4.
% tmvs_drawi (faggr, [3, 4]);}
% @end example
%
% Note that @code{tmvs_drawi} requires
% the Gnuplot graphics toolkit that was mentioned previously,
% because otherwise @code{ginput} does not work.
% The interactive behavior also varies a little depending on the terminal used.
% The X11 terminal, for example,
% is activated with @emph{Right Mouse Button} and cancelled with @emph{Return}.
%
% @section Inspecting and Exporting Data
%
% The following program
% exports data points into several comma-separated value files and
% prints a figure into a LaTeX file,
% all within the temporary file directory @file{/tmp}.
%
% @example
% @code{% Fetch all the data points from a single source file.
% aggr = tmvs_fetch ('excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
%
% % Only keep the data points from temperature sensors.
% f = @@(s) s.id.quantity == tmvs_quantity ('Temperature');
% faggr = filteru (f, aggr);
%
% % Choose one of the identifiers.
% % The index 3 is completely arbitrary.
% id = faggr(3).id;
%
% % Pretty print the chosen identifier.
% tmvs_dispid (id);
%
% % Find the index of the chosen identifier.
% % The result is naturally 3.
% i = tmvs_findid (faggr, id);
%
% % Get the metadata related to the chosen identifier and pretty print it.
% tmvs_dispmeta (faggr(i).meta);
%
% % Save the chosen measurements into a temporary file.
% % The file is formatted like a comma-separated value file
% % with the delimiter @qcode{'|'}, just like source files.
% tmvs_export ('/tmp/tmvs.csv', faggr, id);
%
% % Resample the data points smoothly and uniformly.
% interp = tmvs_interpolate (faggr, 'spline');
% daggr = tmvs_discretize (interp, 256);
%
% % Create a temporary directory and
% % save all the resampled data points into their own files.
% % By default the file names are derived
% % from the indices of the aggregate.
% mkdir ('/tmp/tmvs');
% tmvs_exportall ('/tmp/tmvs', daggr);
%
% % Manually extract the resampled data points
% % matching the chosen identifier.
% z = daggr(i).pairs;
%
% % Visualize the manually extracted data points in figure 1.
% figure (1);
% clf ();
% plot (num2cell (z, 1)@{:@});
% datefmt = 'yyyy-mm-dd';
% datetick ('x', datefmt);
% xlabel (sprintf ('Date [%s]', datefmt));
% ylabel ('Temperature');
%
% % Save the figure into a temporary file
% % for easy embedding into a LaTeX document.
% print ('/tmp/tmvs.tex', '-depslatex', '-S400,300');}
% @end example
%
% The exported figure can be inserted into a LaTeX document
% with the following pieces of code.
%
% @example
% @verbatim
% \usepackage{tikz}
% @end verbatim
% @end example
%
% @example
% @verbatim
% \begin{figure}
%   \centering
%   \begin{tikzpicture}
%     \input{/tmp/tmvs.tex}
%   \end{tikzpicture}
%   \caption{Example from the manual of TMVS.}
% \end{figure}
% @end verbatim
% @end example
%
% @section Working with Caches
%
% The following program shuffles some cache files.
%
% @example
% @code{% Fetch all the data points from a single source file.
% tlaggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
%
% % Fetch more points from a different kind of a source file.
% woaggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));
%
% % Combine the fetched aggregates.
% aggr = tmvs_merge (tlaggr, woaggr);
%
% % Save the combined aggregate into a temporary cache file.
% tmvs_store ('/tmp/tmvs.tmp', aggr);
%
% % Clear the aggregate from memory and
% % reload it from the previously stored cache file.
% % This does not accomplish anything useful
% % besides showing off the cache mechanism.
% clear ('aggr');
% aggr = tmvs_recall ('/tmp/tmvs.tmp');
%
% % Remove the temporary cache file safely.
% tmvs_purge ('/tmp/tmvs.tmp');
%
% % Recursively remove all the other cache files too.
% tmvs_purgeall ('*.tmp', 'excerpt');}
% @end example
%
% @section Simulating Temperature Transfer
%
% The following program simulates temperature transfer as a one-dimensional
% diffusion process with initial and boundary conditions
% pulled from actual source files.
%
% @example
% % Fetch the source data to set up the initial and boundary conditions.
% % We are interested in modeling the temperature,
% % because it is easier to use as an example;
% % modeling the humidity would require working with
% % partial pressures and complicated phenomena
% % like capillary action in porous media.
% aggr = tmvs_fetch ('excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% f = @@(s) ...
%   s.id.quantity == tmvs_quantity ('Temperature') && ...
%   s.id.site == tmvs_site ('Q') && ...
%   s.id.surface == tmvs_surface ('Wall') && ...
%   s.id.section == tmvs_section ('Bottom Corner');
% faggr = filteru (f, aggr);
% interp = tmvs_interpolate (faggr, nan);
%
% % Choose the time interval and the extents of the wall.
% rt = [(datenum (2012, 1, 1)), (datenum (2013, 1, 1))];
% rx = [0, 330e-3];
%
% % Extract the positions from the metadata and
% % find the corresponding temperatures via interpolation.
% xs = arrayfun (@@(s) s.meta.position, interp);
% qt = @@(t) vertcat (tmvs_evaluate (interp, t).pairs)(:, 2)';
%
% % Poorly mimic the US3 wall construction
% % consisting of reinforced concrete and polyurethane.
% CRC = 2.3e+3 * 750; % rho * cp
% CPUR = 30 * 1.5e+3;
% BRC = 1; % k
% BPUR = 25e-3;
% L = cumsum ([70e-3, 10e-3, 160e-3, 10e-3, 80e-3]);
%
% % Define the functions that both
% % determine the properties of the materials and
% % enforce the initial and boundary conditions.
% % The extrapolation used here is harmless,
% % because the functions are constant near the edges.
% C = @@(x) interp1 (L, [CRC, CPUR, CPUR, CRC, CRC], x, 'extrap');
% B = @@(x) interp1 (L, [BRC, BPUR, BPUR, BRC, BRC], x, 'extrap');
% q0 = @@(x) interp1 (xs, qt (rt(1)), x, 'extrap');
% q = @@(t, x) [1, (nan (size (x))(2 : end - 1)), 1] .* ...
%   interp1 (xs, qt (t), x, 'extrap');
%
% % Run the simulation.
% % Even though this is a simple diffusion model,
% % the computation can take a while to complete.
% % It is also worth pointing out that the result is garbage,
% % because the sample data set is too sparse
% % to provide realistic boundary conditions.
% [qn, tn, xn] = diffuse1 (q0, q, C, B, rt, rx, 100, 100, 100, 10);
%
% % Visualize the result with an animation
% % that advances 10 frames per second.
% % Not much seems to happen,
% % because the system is near equilibrium to begin with.
% plots (10, xn, qn);
% @end example
%
% While simulating temperature transfer as a one-dimensional
% diffusion process produces nice results in controlled conditions,
% it is quite a gross oversimplification
% when humidity is involved and condensation may take place.
% In fact, entire scientific journals have been devoted
% to the study of such phenomena.
% See, for instance, the International Journal of Heat and Mass Transfer.
%
% @node Implementation Details
% @chapter Implementation Details
%
% This chapter contains some notes that may be useful
% for further development or deeper understanding of TMVS.
% Deeper understanding of other subjects may also happen as a side effect.
%
% @section Notational Conventions
%
% To make the mental overhead smaller,
% variables with the same meaning always have the same name.
% Thus, throughout the project
%
% @itemize
% @item the structure @var{aggr} is an aggregate
% with the fields @qcode{'id'}, @qcode{'meta'} and @qcode{'pairs'},
% @item the structure @var{interp} is an interpolator
% with the fields @qcode{'id'}, @qcode{'meta'},
% @qcode{'function'} and @qcode{'domain'},
% @item the structure @var{id} is an identifier
% with various fields like @qcode{'source'} or @qcode{'quantity'},
% @item the structure @var{meta} is a metadata container
% with various fields like @qcode{'position'} or @qcode{'material'},
% @item the string @var{fname} is a path to a regular file,
% @item the string @var{cname} is a path to a cache file,
% @item the string @var{dname} is a path to a directory,
% @item the string @var{pat} is a regular expression or a glob pattern,
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
% @item the variable @var{r} is an interval,
% @item the variables @var{dom} and @var{codom} are nonempty intervals,
% @item the variables @var{a} and @var{b} are matrices,
% @item the variables @var{v}, @var{u} and @var{w} are vectors,
% @item the variables @var{f}, @var{g} and @var{h} are functions or procedures,
% @item the variables @var{i}, @var{j} and @var{k}
% are index scalars or vectors and
% @item the variables @var{x}, @var{y}, @var{z} and @var{q} are generic,
% although @var{z} is often a pair and
% @var{q} often emphasizes no coordinate system is involved
% (or that it is free).
% @end itemize
%
% The @code{true} and @code{false} functions are also used
% as if they were literal values to make the code more readable.
%
% @section Extra Dependencies
%
% There are quite a few bells and whistles
% that were used during the development of TMVS,
% but are not necessary for its use.
% The extra dependencies, mostly used in Make targets, are
%
% @itemize
% @item GNU or any other Make (@file{make}),
% @item Bourne shell (@file{sh}),
% @item command line interface for GNU Octave (@file{octave-cli}),
% @item GNU or any other Tar (@file{tar}),
% @item GNU or any other Sed (@file{sed}),
% @item GNU Texinfo (@file{info} and @file{makeinfo}),
% @item GraphViz (@file{dot} and optionally @file{xdot}),
% @item GraphViz to LaTeX compiler (@file{dot2tex}),
% @item ANTLR 4 and OpenJDK or any other Java development kit
% (@file{antlr4}, @file{javac} and @file{java}) and
% @item GHC or any other Haskell compiler (@file{ghc}).
% @end itemize
%
% @section Testing
%
% TMVS comes with a small test suite for those procedures
% that do not require mocking file systems or other side effects.
% To run the tests relating to, say, @code{brsearch},
% use the following command.
%
% @example
% @code{test brsearch}
% @end example
%
% Running tests one by one is tiresome.
% Indeed, if that was required, nobody would run any tests at all.
% That is why all of the testable procedures are referenced inside @code{tmvs},
% making it nearly effortless to run them all at once.
%
% @example
% @code{test tmvs}
% @end example
%
% @section Benchmarks
%
% The sample data set can be used to set up a microbenchmark,
% which shows where the bottlenecks of TMVS are.
% This does not, however, tell much about how things scale,
% because the sample data set is so small.
% For a proper benchmark a (nearly) complete data set must be used.
%
% @subsection Microbenchmark
%
% The following command reads every sample data file and
% merges the results into a single aggregate.
%
% @example
% @code{aggr = tmvs_work ('excerpt');}
% @end example
%
% It can be benchmarked as follows.
%
% @example
% @code{profile on
% aggr = tmvs_work ('excerpt');
% profile off
% profexplore}
% @end example
%
% The call tree comes out roughly as follows.
%
% @smallformat
% @example
% @code{Top
%   1) tmvs_work: 1 calls, 17.366 total, 0.001 self
%     1) tmvs_fetchall: 3 calls, 13.727 total, 0.001 self
%       1) tmvs_merge: 3 calls, 8.481 total, 0.048 self
%         1) tmvs_findid: 547 calls, 8.400 total, 1.378 self
%           1) isequals: 46797 calls, 7.021 total, 4.127 self
%             1) fieldnames: 93594 calls, 2.351 total, 1.469 self
%             2) isfield: 68385 calls, 0.266 total, 0.266 self
%             3) false: 46455 calls, 0.069 total, 0.069 self
%             4) numel: 93594 calls, 0.058 total, 0.058 self
%             5) prefix !: 68385 calls, 0.043 total, 0.043 self
%             6) true: 26173 calls, 0.039 total, 0.039 self
%             7) binary !=: 68385 calls, 0.037 total, 0.037 self
%             8) binary ==: 46797 calls, 0.029 total, 0.029 self
%           2) numel: 547 calls, 0.000 total, 0.000 self
%         2) unique: 205 calls, 0.032 total, 0.021 self
%         3) struct: 208 calls, 0.001 total, 0.001 self
%         4) end: 205 calls, 0.000 total, 0.000 self
%         5) binary +: 205 calls, 0.000 total, 0.000 self
%         6) numel: 52 calls, 0.000 total, 0.000 self
%       2) mapl: 3 calls, 5.243 total, 0.004 self
%       3) glob: 3 calls, 0.001 total, 0.001 self
%     2) tmvs_merge: 1 calls, 3.638 total, 0.026 self
%       1) tmvs_findid: 205 calls, 3.579 total, 0.618 self
%         1) isequals: 20910 calls, 2.961 total, 1.710 self
%           1) fieldnames: 41820 calls, 1.041 total, 0.652 self
%           2) isfield: 24765 calls, 0.096 total, 0.096 self
%           3) false: 20910 calls, 0.031 total, 0.031 self
%           4) numel: 41820 calls, 0.026 total, 0.026 self
%           5) prefix !: 24765 calls, 0.016 total, 0.016 self
%           6) true: 9716 calls, 0.015 total, 0.015 self
%           7) binary !=: 24765 calls, 0.013 total, 0.013 self
%           8) binary ==: 20910 calls, 0.013 total, 0.013 self
%         2) numel: 205 calls, 0.000 total, 0.000 self
%       2) unique: 205 calls, 0.032 total, 0.021 self
%       3) struct: 206 calls, 0.001 total, 0.001 self
%       4) end: 205 calls, 0.000 total, 0.000 self
%       5) binary +: 205 calls, 0.000 total, 0.000 self
%       6) numel: 5 calls, 0.000 total, 0.000 self
%     3) isdir: 1 calls, 0.000 total, 0.000 self
%     4) tmvs_source: 3 calls, 0.000 total, 0.000 self
%     5) sprintf: 3 calls, 0.000 total, 0.000 self
%     6) tmvs_region: 1 calls, 0.000 total, 0.000 self
%     7) prefix !: 1 calls, 0.000 total, 0.000 self
%     1) tmvs_fetchall: 3 calls, 13.727 total, 0.001 self
%     2) tmvs_merge: 1 calls, 3.638 total, 0.026 self
%     3) isdir: 1 calls, 0.000 total, 0.000 self
%     4) tmvs_source: 3 calls, 0.000 total, 0.000 self
%     5) sprintf: 3 calls, 0.000 total, 0.000 self
%     6) tmvs_region: 1 calls, 0.000 total, 0.000 self
%     7) prefix !: 1 calls, 0.000 total, 0.000 self
%   2) profile: 1 calls, 0.000 total, 0.000 self}
% @end example
% @end smallformat
%
% This result is obviously inaccurate,
% because the sample data set is so small,
% but it gives a rough idea of how well the load is balanced.
% From this measurement alone
% the biggest bottleneck appears to be @code{fieldnames}.
%
% @subsection Proper Benchmark
%
% The following call tree was produced with a complete 3 year data set.
%
% @smallformat
% @example
% @code{Top
%   1) tmvs_work: 1 calls, 15307.944 total, 0.002 self
%     1) tmvs_fetchall: 3 calls, 15304.204 total, 0.027 self
%       1) mapl: 3 calls, 15294.016 total, 0.004 self
%         1) anonymous@:17:50: 46 calls, 15294.012 total, 0.007 self
%           1) tmvs_fetch: 46 calls, 15294.005 total, 0.021 self
%             1) tmvs_import: 46 calls, 15293.362 total, 1377.351 self
%               1) datevec: 6060911 calls, 8295.352 total, 1004.986 self
%               2) datenum: 6060865 calls, 2879.025 total, 1301.696 self
%               3) tmvs_parsecsv: 6060911 calls, 1732.615 total, 1300.516 self
%                 1) regexp: 6060911 calls, 265.797 total, 265.797 self
%                 2) isempty: 69939729 calls, 45.300 total, 45.300 self
%                 3) false: 31987536 calls, 41.671 total, 41.671 self
%                 4) true: 31891282 calls, 39.270 total, 39.270 self
%                 5) binary +: 38000321 calls, 21.201 total, 21.201 self
%                 6) cell: 6060911 calls, 9.151 total, 9.151 self
%                 7) floor: 6060911 calls, 3.981 total, 3.981 self
%                 8) numel: 6060911 calls, 3.586 total, 3.586 self
%                 9) binary /: 6060911 calls, 2.142 total, 2.142 self
%                 10) strcat: 1 calls, 0.000 total, 0.000 self
%               4) ismember: 6012782 calls, 718.003 total, 442.932 self
%               5) tmvs_quantity: 6012787 calls, 115.097 total, 93.994 self
%                 1) isindex: 6012782 calls, 7.668 total, 7.668 self
%                 2) nargin: 6012787 calls, 6.231 total, 6.231 self
%                 3) ischar: 6012787 calls, 3.779 total, 3.779 self
%                 4) binary ==: 6012787 calls, 3.425 total, 3.425 self
%                 5) tolower: 5 calls, 0.000 total, 0.000 self
%               6) fgetl: 6060957 calls, 52.137 total, 52.137 self
%               7) binary !=: 6060957 calls, 45.893 total, 45.893 self
%               8) str2double: 6253192 calls, 31.089 total, 31.089 self
%               9) find: 6012782 calls, 13.407 total, 13.407 self
%               10) false: 6060864 calls, 9.624 total, 9.624 self
%               11) isempty: 12073693 calls, 8.108 total, 8.108 self
%               12) end: 6254442 calls, 5.351 total, 5.351 self
%               13) binary +: 6255067 calls, 3.543 total, 3.543 self
%               14) prefix -: 6061095 calls, 3.522 total, 3.522 self
%               15) binary *: 2406178 calls, 1.409 total, 1.409 self
%               16) tmvs_findid: 625 calls, 1.045 total, 0.150 self
%               17) tmvs_parsename: 625 calls, 0.550 total, 0.295 self
%               18) unique: 630 calls, 0.172 total, 0.082 self
%               19) isindex: 625 calls, 0.056 total, 0.056 self
%               20) struct: 677 calls, 0.004 total, 0.004 self
%               21) fclose: 46 calls, 0.002 total, 0.002 self
%               22) NaN: 625 calls, 0.002 total, 0.002 self
%               23) tmvs_source: 46 calls, 0.001 total, 0.001 self
%               24) fopen: 46 calls, 0.001 total, 0.001 self
%               25) prefix !: 718 calls, 0.000 total, 0.000 self
%               26) numel: 671 calls, 0.000 total, 0.000 self
%               27) binary ==: 138 calls, 0.000 total, 0.000 self
%               28) repmat: 2 calls, 0.000 total, 0.000 self
%               29) ferror: 46 calls, 0.000 total, 0.000 self
%               30) cell: 45 calls, 0.000 total, 0.000 self
%               31) true: 46 calls, 0.000 total, 0.000 self
%               32) error: 1 calls, 0.000 total, 0.000 self
%               33) size: 2 calls, 0.000 total, 0.000 self
%             2) tmvs_store: 46 calls, 0.614 total, 0.003 self
%               1) save: 46 calls, 0.609 total, 0.609 self
%               2) exist: 46 calls, 0.002 total, 0.002 self
%               3) tmvs_version: 46 calls, 0.000 total, 0.000 self
%               4) nargin: 46 calls, 0.000 total, 0.000 self
%               5) prefix !: 46 calls, 0.000 total, 0.000 self
%               6) binary <=: 46 calls, 0.000 total, 0.000 self
%             3) warning: 92 calls, 0.004 total, 0.004 self
%             4) tmvs_cachename: 46 calls, 0.002 total, 0.001 self
%             5) stat: 46 calls, 0.001 total, 0.001 self
%             6) sprintf: 46 calls, 0.001 total, 0.001 self
%             7) true: 46 calls, 0.000 total, 0.000 self
%             8) binary ==: 46 calls, 0.000 total, 0.000 self
%             9) false: 46 calls, 0.000 total, 0.000 self
%             10) prefix -: 5 calls, 0.000 total, 0.000 self
%           2) prefix -: 2 calls, 0.000 total, 0.000 self
%         2) numel: 3 calls, 0.000 total, 0.000 self
%         3) isnumeric: 3 calls, 0.000 total, 0.000 self
%         4) isstruct: 3 calls, 0.000 total, 0.000 self
%         5) iscell: 3 calls, 0.000 total, 0.000 self
%       2) tmvs_merge: 3 calls, 10.161 total, 0.166 self
%       3) glob: 3 calls, 0.000 total, 0.000 self
%     2) tmvs_merge: 1 calls, 3.737 total, 0.065 self
%       1) tmvs_findid: 215 calls, 3.595 total, 0.616 self
%         1) isequals: 23005 calls, 2.980 total, 1.719 self
%           1) fieldnames: 46010 calls, 1.048 total, 0.664 self
%           2) isfield: 26829 calls, 0.095 total, 0.095 self
%           3) false: 23005 calls, 0.032 total, 0.032 self
%           4) numel: 46010 calls, 0.028 total, 0.028 self
%           5) prefix !: 26829 calls, 0.017 total, 0.017 self
%           6) true: 10471 calls, 0.015 total, 0.015 self
%           7) binary !=: 26829 calls, 0.014 total, 0.014 self
%           8) binary ==: 23005 calls, 0.013 total, 0.013 self
%         2) numel: 215 calls, 0.000 total, 0.000 self
%       2) unique: 215 calls, 0.076 total, 0.032 self
%       3) struct: 216 calls, 0.001 total, 0.001 self
%       4) end: 215 calls, 0.000 total, 0.000 self
%       5) binary +: 215 calls, 0.000 total, 0.000 self
%       6) numel: 5 calls, 0.000 total, 0.000 self
%     3) tmvs_source: 3 calls, 0.000 total, 0.000 self
%     4) sprintf: 3 calls, 0.000 total, 0.000 self
%     5) isdir: 1 calls, 0.000 total, 0.000 self
%     6) tmvs_region: 1 calls, 0.000 total, 0.000 self
%     7) prefix !: 1 calls, 0.000 total, 0.000 self
%   2) profile: 1 calls, 0.000 total, 0.000 self}
% @end example
% @end smallformat
%
% Most of the time seems to be spent inside the inbuilt parsing functions
% @code{datevec}, @code{datenum} and @code{regexp}.
% The utility functions @code{ismember} and @code{isempty}
% follow closely due to their sheer frequency.
%
% While it would be possible to replace the inbuilt functions
% with faster equivalents, it is not worth the effort.
% Calling @code{jit_enable}, if possible, is a better time investment.
%
% @ifset helppages
%
% @node Help Pages
% @chapter Help Pages
%
% This special chapter contains all the help pages in alphabetical order.
%
% @end ifset

%!test
%! test tmvs_source
%! test tmvs_quantity
%! test tmvs_site
%! test tmvs_surface
%! test tmvs_room
%! test tmvs_section
%! test tmvs_material
%! test tmvs_region

%!test
%! test identity
%! test composel
%! test composer
%! test curry
%! test uncurry
%! test mapl
%! test mapr
%! test overfield
%! test foldl
%! test foldr
%! test filters
%! test filteru

%!test
%! test withinc
%! test withinl
%! test withino
%! test withinr
%! test isequals
%! test sparsify
%! test brsearch
%! test chauvenet
%! test diffuse1

%?test
%? test axislim
%? test globr
%? test plots
%? test progress
