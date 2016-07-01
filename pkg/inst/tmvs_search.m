% TODO Make not ugly (do not break though).

function [i, j] = tmvs_search (cds, h)

i = 1;
j = 0;

iind = 1;
jind = length (cds);

while iind <= jind
  k = floor (iind + (jind - iind) / 2);

  hk = cds(k).hash;

  if hk < h
    iind = k + 1;
  elseif hk > h
    jind = k - 1;
  else
    lef = iind;
    mid = k;
    while mid - lef > 1
      q = floor (lef + (mid - lef) / 2);

      hk = cds(q).hash;

      if hk < h
        lef = q + 1;
      else
        mid = q;
      end
    end
    i = mid;

    mid = k;
    rig = jind;
    while rig - mid > 1
      q = floor (mid + (rig - mid) / 2);

      hk = cds(q).hash;

      if hk > h
        rig = q;
      else
        mid = q;
      end
    end
    j = mid;

    break
  end
end

end
