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
require 'fuzzystringmatch/pure'
begin
  if RUBY_PLATFORM == "java"
    STDERR.puts "fuzzy-string-match Warning: native version is disabled on java platform. falled back to pure ruby version..."
  else
    require 'fuzzystringmatch/inline'
  end
rescue LoadError
end

module FuzzyStringMatch
  class JaroWinkler
    def self.create( type = :pure )     # factory method
      case type
      when :pure
        FuzzyStringMatch::JaroWinklerPure.new
      when :native
        begin
          FuzzyStringMatch::JaroWinklerInline.new
        rescue NameError
          STDERR.puts "fuzzy-string-match Warning: native version is disabled. falled back to pure ruby version..."
          FuzzyStringMatch::JaroWinklerPure.new
        end
      end
    end
  end
end
