function tmvs_visualize_stations(arrays)
tmvs_visualize(arrays, 1, '.ila', 'Temperature [^oC]');
tmvs_visualize(arrays, 2, '.osteus', 'Relative Humidity [\%]');
tmvs_visualize(arrays, 3, '.aine', 'Ambient Pressure [hPa]');
tmvs_visualize(arrays, 4, '.uul', 'Wind Speed [m/s]');
tmvs_visualize(arrays, 5, '.ade', 'Precipitation [mm/d]');
end
