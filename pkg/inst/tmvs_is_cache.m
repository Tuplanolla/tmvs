function p = tmvs_is_cache (cname)

s = struct ();
try
  s = load (cname, 'tmvs_v');
end

p = isfield (s, 'tmvs_v');

end
