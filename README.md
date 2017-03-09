# What is fuzzy-string-match
  [![Build Status](https://secure.travis-ci.org/kiyoka/fuzzy-string-match.png)](http://travis-ci.org/kiyoka/fuzzy-string-match)

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

    gem install fuzzy-string-match

## Features
* Calculate Jaro-Winkler distance of two strings.
  * Pure ruby version can handle both ASCII and UTF8 strings. (and slow)
  * Native version can only ASCII strings. (but it is fast)

## Sample code 

### Native version

    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    p jarow.getDistance(  "jones",      "johnson" )

### Pure ruby version

    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.create( :pure )
    p jarow.getDistance(  "jones",      "johnson" )
    p jarow.getDistance(  "ああ",        "あい"        )

## Sample on irb

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

## Benchmarks

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

## Requires

### for CRuby
 - RubyInline
 - Ruby 2.0.0 or higher ( includes RubyInstaller.org's CRuby on Windows )

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

## ChangeLog

### 1.0.0 / Mar  10, 2017
* First stable release

### 0.9.9 / Mar   9, 2017
* Supported ruby version is 2.0.0 or higher(for RHEL 7.x)

### 0.9.8 / Mar   9, 2017
* Supported ruby version is 2.1.0 or higher
* Merge pull request #16 from ferdinandrosario/ferdinandrosario-patch-1 (Travis rubies updated)
* Merge pull request #14 from timsatterfield/master (Reduce calls to strlen() in native jaro winkler)

### 0.9.7 / Oct  15, 2014

* Use rspec 3.1 syntax.
* Fixed: issue #12 `Using stack allocated memory`.
* Fixed: remove duplicated dependency of gem package.

### 0.9.6 / Dec  21, 2013

* New feature: fuzzy-string-match falls back into pure ruby mode when c-compile fails.
* fuzzy-string-match_pure is obsolute gem 

### 0.9.5 / Mar  26, 2013

* Fixed: 'jarowinkler.rb:42: warning: implicit conversion shortens 64-bit value into a 32-bit value' on MacOS X 64bit env.

### 0.9.4 / July 10, 2012

* Fixed: undefined method getDistance' error.

### 0.9.3 / Feb 27, 2012

* Changed gem dependency of `rspec'.
   gemspec.dependency( "rspec" )  to  gemspec.development_dependency( "rspec" )

### 0.9.2 / Feb 17, 2012

* Supported JRuby platform
* Divided into two gems.

  1. fuzzy-string-match      ... native (RubyInline) version.
  2. fuzzy-string-match_pure ... pure ruby version

* Divided rspec files into several files.

* Supported testable gem
   Please install rubygems-test and "gem test".

### 0.9.1 / Jul 30, 2011

* Changed gcc compiler's option for RubyInline.

* Stoped to use obsolute method of RSpec.

### 0.9.0 / Oct 12, 2010

* First release.
