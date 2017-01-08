
function d = bi2de (b, p, f)

  switch (nargin)
    case 1,
      p = 2;
      f = 'right-msb';
     case 2,
      if (ischar(p))
        f = p;
        p = 2;
      else
        f = 'right-msb';
      end
     case 3,
      if (ischar(p))
        tmp = f;
        f = p;
        p = tmp;
      end
   otherwise
      error ('usage: d = bi2de (b, [p])');
  end

  if ( any (b (:) < 0) || any (b (:) > p - 1) )
    error ('bi2de: d must only contain value in [0, p-1]');
  end

  if (strcmp(f,'left-msb'))
    b = b(:,size(b,2):-1:1);
  elseif (strcmp(f,'right-msb')==0)
    error('bi2de: unrecognized flag');
  end

  if (isempty(b))
    d = [];
  else
	  s = size(b);
    d = b * ( p .^ [ 0 : (s(1,2)-1) ]' );
  end


