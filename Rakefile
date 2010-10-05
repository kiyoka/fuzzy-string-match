#-*- mode: ruby; -*-
#
# Release Engineering
#   1. edit the VERSION.yml file
#   2. rake check
#   3. rake gemspec  &&   rake build
#      to generate kiyoka-jarowinkler-x.x.x.gem
#   4. install kiyoka-jarowinkler-x.x.x.gem to clean environment and test
#   5. rake release
#   6. gem push pkg/kiyoka-jarowinkler-x.x.x.gem   ( need gem version 1.3.6 or higer. Please "gem update --system" to update )

require 'rake'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "kiyoka-jarowinkler"
    gemspec.summary = "Jaro Winkler distance algorythm"
    gemspec.description = "Jaro Winkler distance algorythm."
    gemspec.email = "kiyoka@sumibi.org"
    gemspec.homepage = "http://github.com/kiyoka/jarowinkler"
    gemspec.authors = ["Kiyoka Nishiyama"]
    gemspec.files = FileList['lib/*.rb',
                             'test/*.rb'].to_a
    gemspec.add_development_dependency "rspec"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

task :check do
  sh "ruby -I ./lib /usr/local/bin/spec -b ./test/jarowinkler_spec.rb"
end

