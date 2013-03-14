#
#                            Fuzzy String Match
#
#   Copyright 2010-2011 Kiyoka Nishiyama
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
module FuzzyStringMatch
  require 'inline'
  class JaroWinklerInline
    def pure?
      false
    end

    inline do |builder|
      builder.include '<iostream>'
      builder.add_compile_flags %q(-x c++)
      builder.add_link_flags %q(-lstdc++)
      builder.c_raw 'int max( int a, int b ) { return ((a)>(b)?(a):(b)); }'
      builder.c_raw 'int min( int a, int b ) { return ((a)<(b)?(a):(b)); }'
      builder.c_raw 'double double_min( double a, double b ) { return ((a)<(b)?(a):(b)); }'
      builder.c '
double getDistance( char *s1, char *s2 )
{
  char *_max;
  char *_min;
  long _max_length = 0;
  long _min_length = 0;
  if ( strlen(s1) > strlen(s2) ) {
    _max = s1; _max_length = strlen(s1);
    _min = s2; _min_length = strlen(s2);
  }
  else {
    _max = s2; _max_length = strlen(s2);
    _min = s1; _min_length = strlen(s1);
  }
  int range = max( _max_length / 2 - 1, 0 );

  long indexes[_min_length];
  for( long i = 0 ; i < _min_length ; i++ ) {
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
