#-*- mode: ruby; -*-
#
# Release Engineering
#   1. edit the VERSION.yml file
#   2. rake test
#   3. rake gemspec  &&   rake build
#      to generate fuzzy-string-match-x.x.x.gem
#   4. install fuzzy-string-match-x.x.x.gem to clean environment and test
#   5. rake release
#   6. gem push pkg/fuzzy-string-match-x.x.x.gem   ( need gem version 1.3.6 or higer. Please "gem update --system" to update )
#
# for Development
#   rake test_dev
#   rake benchmark

require 'rake'
begin
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "fuzzy-string-match_pure"
    gemspec.summary = "fuzzy string matching library (Pure ruby version)"
    gemspec.description = "calculate Jaro Winkler distance."
    gemspec.email = "kiyoka@sumibi.org"
    gemspec.homepage = "http://github.com/kiyoka/fuzzy-string-match"
    gemspec.authors = ["Kiyoka Nishiyama"]
    gemspec.files = FileList['.gemtest',
                             'Rakefile',
                             'VERSION.yml',
                             'lib/fuzzystringmatch/pure/jarowinkler.rb',
                             'lib/fuzzystringmatch/pure.rb',
                             'lib/fuzzystringmatch.rb',
                             'lib/*.rb',
                             'test/basic_pure_spec.rb',
                             'test/mutibyte_spec.rb',
                             'LICENSE.txt',
                             'README.md'].to_a
    gemspec.add_dependency( "rspec" )
    gemspec.required_ruby_version = '>= 1.9.1'
  end

  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "fuzzy-string-match"
    gemspec.summary = "fuzzy string matching library"
    gemspec.description = "calculate Jaro Winkler distance."
    gemspec.email = "kiyoka@sumibi.org"
    gemspec.homepage = "http://github.com/kiyoka/fuzzy-string-match"
    gemspec.authors = ["Kiyoka Nishiyama"]
    gemspec.files = FileList['.gemtest',
                             'Rakefile',
                             'VERSION.yml',
                             'lib/fuzzystringmatch/inline/jarowinkler.rb',
                             'lib/fuzzystringmatch/inline.rb',
                             'lib/fuzzystringmatch/pure/jarowinkler.rb',
                             'lib/fuzzystringmatch/pure.rb',
                             'lib/fuzzystringmatch.rb',
                             'test/basic_native_spec.rb',
                             'test/basic_pure_spec.rb',
                             'test/mutibyte_spec.rb',
                             'LICENSE.txt',
                             'README.md'].to_a
    gemspec.add_dependency( "rspec" )
    gemspec.add_dependency( 'RubyInline', '>= 3.8.6')
    gemspec.required_ruby_version = '>= 1.9.1'
  end

rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

task :default => [:test] do
end

task :test do
  sh "ruby -I ./lib `which rspec` -b ./test/basic_native_spec.rb"   if File.exist?( "./test/basic_native_spec.rb" )
  sh "ruby -I ./lib `which rspec` -b ./test/basic_pure_spec.rb"
  sh "ruby -I ./lib `which rspec` -b ./test/mutibyte_spec.rb"
end

task :test_dev do
  sh "ruby -I ./lib `which rspec` -b ./test/verify_with_amatch_spec.rb"
end

task :bench do
  sh "ruby ./benchmark/vs_amatch.rb"
end

