function tmvs_visualize_rooms(arrays)
tmvs_visualize(arrays, 1, 'T[0-9]+', 'Temperature [^oC]');
tmvs_visualize(arrays, 2, 'RH[0-9]+', 'Relative Humidity [\%]');
tmvs_visualize(arrays, 3, 'AH[0-9]+', 'Absolute Humidity [g/m^3]');
end
