# execute this program, 
# ruby will raise NoMemoryError exception (on Main Memory 3GByte hardware)
require 'fuzzystringmatch'

jarow = FuzzyStringMatch::JaroWinkler.create( :native )
printf( "pure?() = %s\n", jarow.pure?() )
p jarow.getDistance("foo" * 1000000 * 300, "goo" * 1000000 * 200)
