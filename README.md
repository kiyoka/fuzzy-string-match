# What is fuzzy-string-match

* fuzzy-string-match is a fuzzy string matching library for ruby.
* It is fast. ( written in C with RubyInline )
* It supports only Jaro-Winkler distance algorithm.
* This program was ported by hand from lucene-3.0.2. (lucene is Java product)
* If you want to add another string distance algorithm, please fork it on github and port by yourself.

## The reason why i developed fuzzy-string-match
* I tried amatch-0.2.5, but it contains some issues.
  1. memory leaks.
  2. I felt difficult to maintain it.
* So, I decide to create another gem by porting lucene-3.0.x.

## Installing
  1. gem install fuzzy-string-match

## Installing (pure ruby version)
  1. gem install fuzzy-string-match_pure

## Features
* Calculate Jaro-Winkler distance of two strings.
  * Pure ruby version can handle both ASCII and UTF8 strings. (and slow)
  * Native version can only ASCII strings. (but it is fast)

## Sample code 
  * Native version

<code>
    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    p jarow.getDistance(  "jones",      "johnson" )
</code>

  * Pure ruby version

<code>
    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.create( :pure )
    p jarow.getDistance(  "jones",      "johnson" )
    p jarow.getDistance(  "ああ",        "あい"        )
</code>

## Sample on irb

<code>
    irb(main):001:0> require 'fuzzystringmatch'
    require 'fuzzystringmatch'
    => true

    irb(main):002:0> jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    => #<FuzzyStringMatch::JaroWinklerNative:0x000001011b0010>

    irb(main):003:0> jarow.getDistance( "al",        "al"        )
    jarow.getDistance( "al",        "al"        )
    => 1.0

    irb(main):004:0> jarow.getDistance( "dixon",     "dicksonx"  )
    jarow.getDistance( "dixon",     "dicksonx"  )
    => 0.8133333333333332
</code>

## Benchmarks

<console>
    $ rake bench
    ruby ./benchmark/vs_amatch.rb
     --- 
     --- Each match functions will be called 1Mega times. --- 
     --- 
    [Amatch]
          user     system      total        real
      1.160000   0.050000   1.210000 (  1.218259)
    [this Module (pure)]
          user     system      total        real
     39.940000   0.160000  40.100000 ( 40.542448)
    [this Module (native)]
          user     system      total        real
      0.480000   0.000000   0.480000 (  0.484187)
</console>

## Requires
### for CRuby
 -- RubyInline
 -- Ruby 1.9.1 or higher
### for JRuby
 - JRuby 1.6.6 or higher

## Author
 - Copyright (C) Kiyoka Nishiyama <kiyoka@sumibi.org>
 - I ported from java source code of lucene-3.0.2.

## See also
 - <http://en.wikipedia.org/wiki/Jaro–Winkler_distance>
 - <http://lucene.apache.org/>
 - <http://github.com/naoya/perl-text-jarowinkler>

## License
 - Apache 2.0 LICENSE
