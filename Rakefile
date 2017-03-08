#-*- mode: ruby; -*-
#
# Release Engineering
#   1. edit the "s.version = " line of fuzzy-string-match.gemspec
#   2. rake  &&  rake build
#      to generate pkg/fuzzy-string-match-x.x.x.gem
#   3. install fuzzy-string-match-x.x.x.gem to clean environment and test
#   4. rake release
#
# for Development
#   rake test_dev
#   rake benchmark

require 'rake'
require 'bundler/gem_tasks'

task :default => [:test] do
end

task :test => [:fallback_test] do
  sh "ruby -I ./lib `which rspec` -b ./test/basic_native_spec.rb"   if File.exist?( "./test/basic_native_spec.rb" )
  sh "ruby -I ./lib `which rspec` -b ./test/basic_pure_spec.rb"
  sh "ruby -I ./lib `which rspec` -b ./test/mutibyte_spec.rb"
end

task :fallback_test => [:clean_dot_rubyinline] do
  sh "/bin/mkdir -p /tmp/fake_gcc/"
  sh "/bin/cp ./fake_gcc /tmp/fake_gcc/gcc"
  sh "export PATH=\"/tmp/fake_gcc:${PATH}\" ; rspec -I ./lib ./test/fallback_pure_spec.rb"
end

task :test_dev do
  sh "ruby -I ./lib `which rspec` -b ./test/verify_with_amatch_spec.rb"
end

task :bench do
  sh "ruby ./benchmark/vs_amatch.rb"
end

task :clean_dot_rubyinline do
  sh "/bin/rm -rf ~/.ruby_inline"
end
