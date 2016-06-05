function arrays = tmvs_recall(file)
arrays = getfield(load(file, 'arrays'), 'arrays');
end

%!test
%! assert(true);
