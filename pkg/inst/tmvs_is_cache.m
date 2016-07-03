function p = tmvs_is_cache (cname)

s = struct ();
try
  s = load (cname, 'tmvs_version');
end

p = isfield (s, 'tmvs_version');

end
