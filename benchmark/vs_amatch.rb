#!/usr/local/bin/ruby
#
# http://www.ruby-lang.org/ja/man/html/benchmark.html
#
require 'benchmark'
require 'amatch'
require './lib/jarowinkler'

looptimes = 10000

names = [ "Aichi",     "Akita",    "Aomori", "Chiba",    "Ehime",    "Fukui",     "Fukuoka",  "Fukushima", "Gifu",     "Gunma",
          "Hiroshima", "Hokkaido", "Hyogo",  "Ibaraki",  "Ishikawa", "Iwate",     "Kagawa",   "Kagoshima", "Kanagawa", "Kochi",
          "Kumamoto",  "Kyoto",    "Mie",    "Miyagi",   "Miyazaki", "Nagano",    "Nagasaki", "Nara",      "Niigata",  "Oita",
          "Okayama",   "Okinawa",  "Osaka",  "Saga",     "Saitama",  "Shiga",     "Shimane",  "Shizuoka",  "Tochigi",  "Tokushima",
          "Tokyo",     "Tottori",  "Toyama", "Wakayama", "Yamagata", "Yamaguchi", "Yamanashi" ]

keyword = "Tokyo"

puts "[Amatch]"
puts Benchmark::CAPTION
puts Benchmark.measure {
  jarow = Amatch::JaroWinkler.new keyword
  looptimes.times { |n|
    names.map { |x|
      jarow.match( x )
    }
  }
}

puts "[this Module (pure)]"
puts Benchmark::CAPTION
puts Benchmark.measure {
  jarow = JaroWinkler::JaroWinkler.new.create
  looptimes.times { |n|
    names.map { |x|
      jarow.getDistance( keyword, x )
    }
  }
}
puts "[this Module (native)]"
puts Benchmark::CAPTION
puts Benchmark.measure {
  jarow = JaroWinkler::JaroWinkler.new.create( :native )
  looptimes.times { |n|
    names.map { |x|
      jarow.getDistance( keyword, x )
    }
  }
}
