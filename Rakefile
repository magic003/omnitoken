require 'rake'
require 'rake/testtask'

task :default => [:test]

desc "Run unit tests"
Rake::TestTask.new("test") do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
