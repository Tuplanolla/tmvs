function tmvs_progress (i, n = 1, fid = stdout)

if nargin == 0
  fprintf (fid, '\n');
elseif mod (i, n) == 0
  switch mod (i / n, 4)
  case 0
    c = '|';
  case 1
    c = '/';
  case 2
    c = '-';
  case 3
    c = '\';
  otherwise
    c = '+';
  end
  fprintf (fid, '%c (progress indicator)\r', c);
  fflush (fid);
end

end
