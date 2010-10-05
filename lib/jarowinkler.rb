module JaroWinkler
  
  class JaroWinklerDistance
    def matches( s1, s2 )
      a1 = s1.split( // )
      a2 = s2.split( // )
      
      if s1.size > s2.size
        (max,min) = a1,a2
      else
        (max,min) = a2,a1
      end

      print "max " ; p max
      print "min " ; p min
      range = [ (max.size / 2 - 1), 0 ].max

      print "range " ; p range

      indexes = Array.new( min.size, -1 )
      flags   = Array.new( max.size, false )

      print "indexes " ; p indexes
      print "flags "   ; p flags

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

      print "matches " ; p matches

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

      print "transpositions " ; p transpositions
      print "prefix         " ; p prefix
      if 0 == matches
        0.0
      else
        m = matches.to_f
        t = (transpositions/ 2)
        print "t " ; p t
        j = ((m / s1.size) + (m / s2.size) + ((m - t) / m)) / 3.0;
        print "j " ; p j
        jw = j < 0.7 ? j : j + [0.1, 1.0 / max.size].min * prefix * (1 - j)
        print "jw " ; p jw
        jw
      end
    end
  end

end
