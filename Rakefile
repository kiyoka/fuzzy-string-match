#-*- mode: ruby; -*-
#
# Release Engineering
#   1. edit the VERSION.yml file
#   2. rake check
#   3. rake gemspec  &&   rake build
#      to generate fuzzy-string-match-x.x.x.gem
#   4. install fuzzy-string-match-x.x.x.gem to clean environment and test
#   5. rake release
#   6. gem push pkg/fuzzy-string-match-x.x.x.gem   ( need gem version 1.3.6 or higer. Please "gem update --system" to update )

require 'rake'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "fuzzy-string-match"
    gemspec.summary = "fuzzy string matching library"
    gemspec.description = "calculate Jaro Winkler distance."
    gemspec.email = "kiyoka@sumibi.org"
    gemspec.homepage = "http://github.com/kiyoka/fuzzy-string-match"
    gemspec.authors = ["Kiyoka Nishiyama"]
    gemspec.files = FileList['lib/*.rb',
                             'test/*.rb',
                             'benchmark/*.rb',
                             'LICENSE.txt',
                             'README.md'].to_a
    gemspec.add_development_dependency( "rspec" )
    gemspec.add_development_dependency( "amatch" )
    gemspec.add_dependency('RubyInline', '>= 3.8.6')
    gemspec.required_ruby_version = '>= 1.9.1'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

task :check do
  sh "ruby -I ./lib /usr/local/bin/spec -b ./test/fuzzystringmatch_spec.rb"
end

task :bench do
  sh "ruby ./benchmark/vs_amatch.rb"
end

