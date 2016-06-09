function result = tmvs_reduce(func, arrays, init)
names = fieldnames(arrays);

if nargin() == 3
  j = 1;
  result = init;
else
  j = 2;
  result = arrays.(names{1});
end

for i = j : length(names)
  result = func(result, arrays.(names{i}));
end
end
