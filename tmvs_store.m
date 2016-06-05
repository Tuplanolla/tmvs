function tmvs_store(file, arrays, format = '-mat', zip = true)
if zip
  save(format, '-zip', file, 'arrays');
else
  save(format, file, 'arrays');
end
end

%!test
%! assert(true);
