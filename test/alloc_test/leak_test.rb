# execute this program and you must watch ruby process memory usage.

require 'fuzzystringmatch'

jarow = FuzzyStringMatch::JaroWinkler.create( :native )

100000.times do |n|
  p jarow.getDistance("foo" * 1000000, "goo" * n)
end
