module JaroWinkler
  
  class JaroWinkler
    def create( type = :pure )
      case type
      when :pure
        JaroWinklerPure.new
      when :native
        JaroWinklerNative.new
      end
    end
  end

  class JaroWinklerPure
    THRESHOLD = 0.7

    def getDistance( s1, s2 )
      a1 = s1.split( // )
      a2 = s2.split( // )
      
      if s1.size > s2.size
        (max,min) = a1,a2
      else
        (max,min) = a2,a1
      end

      range = [ (max.size / 2 - 1), 0 ].max
      indexes = Array.new( min.size, -1 )
      flags   = Array.new( max.size, false )

      matches = 0;
      (0 ... min.size).each { |mi|
        c1 = min[mi]
        xi = [mi - range, 0].max
        xn = [mi + range + 1, max.size].min
        
        (xi ... xn).each { |i|
          if (not flags[i]) && ( c1 == max[i] )
            indexes[mi] = i
            flags[i] = true
            matches += 1
            break
          end
        }
      }

      ms1 = Array.new( matches, nil )
      ms2 = Array.new( matches, nil )

      si = 0
      (0 ... min.size).each { |i|
        if (indexes[i] != -1)
          ms1[si] = min[i]
          si += 1
        end
      }

      si = 0
      (0 ... max.size).each { |i|
        if flags[i]
          ms2[si] = max[i]
          si += 1
        end
      }
      
      transpositions = 0
      (0 ... ms1.size).each { |mi|
        if ms1[mi] != ms2[mi]
          transpositions += 1
        end
      }

      prefix = 0
      (0 ... min.size).each { |mi|
        if s1[mi] == s2[mi]
          prefix += 1
        else
          break
        end
      }

      if 0 == matches
        0.0
      else
        m = matches.to_f
        t = (transpositions/ 2)
        j = ((m / s1.size) + (m / s2.size) + ((m - t) / m)) / 3.0;
        return j < THRESHOLD ? j : j + [0.1, 1.0 / max.size].min * prefix * (1 - j)
      end
    end
  end

  require 'inline'
  class JaroWinklerNative
    inline do |builder|
      builder.add_compile_flags '-std=c99'
      builder.c_raw 'int max( int a, int b ) { return ((a)>(b)?(a):(b)); }'
      builder.c_raw 'int min( int a, int b ) { return ((a)<(b)?(a):(b)); }'
      builder.c_raw 'double double_min( double a, double b ) { return ((a)<(b)?(a):(b)); }'
      builder.c '
double getDistance( char *s1, char *s2 )
{
  char *_max;
  char *_min;
  int _max_length = 0;
  int _min_length = 0;
  if ( strlen(s1) > strlen(s2) ) {
    _max = s1; _max_length = strlen(s1);
    _min = s2; _min_length = strlen(s2);
  }
  else {
    _max = s2; _max_length = strlen(s2);
    _min = s1; _min_length = strlen(s1);
  }
  int range = max( _max_length / 2 - 1, 0 );
  
  int indexes[_min_length];
  for( int i = 0 ; i < _min_length ; i++ ) {
    indexes[i] = -1;
  }

  int flags[_max_length];
  for( int i = 0 ; i < _max_length ; i++ ) {
    flags[i] = 0;
  }
  int matches = 0;
  for (int mi = 0; mi < _min_length; mi++) {
    char c1 = _min[mi];
    for (int xi = max(mi - range, 0), xn = min(mi + range + 1, _max_length); xi < xn; xi++ ) {
      if (!flags[xi] && (c1 == _max[xi])) {
	indexes[mi] = xi;
	flags[xi] = 1;
	matches++;
	break;
      }
    }
  }

  char ms1[matches];
  char ms2[matches];
  int ms1_length = matches;
  
  for (int i = 0, si = 0; i < _min_length; i++) {
    if (indexes[i] != -1) {
      ms1[si] = _min[i];
      si++;
    }
  }
  for (int i = 0, si = 0; i < _max_length; i++) {
    if (flags[i]) {
      ms2[si] = _max[i];
      si++;
    }
  }
  int transpositions = 0;
  for (int mi = 0; mi < ms1_length; mi++) {
    if (ms1[mi] != ms2[mi]) {
      transpositions++;
    }
  }
  int prefix = 0;
  for (int mi = 0; mi < _min_length; mi++) {
    if (s1[mi] == s2[mi]) {
      prefix++;
    } else {
      break;
    }
  }

  double m = (double) matches;
  if (matches == 0) {
    return 0.0;
  }
  int t = transpositions / 2;
  double j = ((m / strlen(s1) + m / strlen(s2) + (m - t) / m)) / 3;
  double jw = j < 0.7 ? j : j + double_min(0.1, 1.0 / _max_length) * prefix
    * (1 - j);
  return jw;
}'
    end
  end

end
