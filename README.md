# What is fuzzy-string-match

* fuzzy-string-match is a fuzzy string matching library for ruby.
* It is fast. ( written in C with RubyInline )
* It suports only Jaro-Winkler distance algorithm.
* This program was ported by hand from lucene-3.0.2. (lucene is Java product)
* If you want to add another string distance algorithm, please port by yourself and contact me <kiyoka@sumibi.org>.

## Installing 
  1. gem install fuzzy-string-match

## Features
* Caluclate Jaro-Winkler distance of two strings.
  * Pure ruby version can handle both ascii and UTF8 strings. (and slow)
  * Native version can only ascii strings. (and fast)

## Sample code 
  * Native version

<code>
    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.new.create( :native )
    p jarow.getDistance(  "jones",      "johnson" )
</code>

  * Pure ruby version

<code>
    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.new.create( :pure )
    p jarow.getDistance( "ああ",        "あい"        )
</code>

## Sample on irb

<code>
    irb(main):001:0> require 'fuzzystringmatch'
    require 'fuzzystringmatch'
    => true

    irb(main):002:0> jarow = FuzzyStringMatch::JaroWinkler.new.create( :native )
    jarow = FuzzyStringMatch::JaroWinkler.new.create( :native )
    => #<FuzzyStringMatch::JaroWinklerNative:0x000001011b0010>

    irb(main):003:0> jarow.getDistance( "al",        "al"        )
    jarow.getDistance( "al",        "al"        )
    => 1.0

    irb(main):004:0> jarow.getDistance( "dixon",     "dicksonx"  )
    jarow.getDistance( "dixon",     "dicksonx"  )
    => 0.8133333333333332
</code>

## Requires
 - RubyInline
 - Ruby 1.9.1 or higher

## Author
 - Copyright (C) Kiyoka Nishiyama <kiyoka@sumibi.org>
 - I ported from java source code of lucene-3.0.2.

## See also
 - http://en.wikipedia.org/wiki/Jaro–Winkler_distance
 - http://lucene.apache.org/
 - http://github.com/naoya/perl-text-jarowinkler

## License
 - Apache 2.0 LICENSE
