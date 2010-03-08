require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'jeweler'
Jeweler::Tasks.new do |s|
  s.name = "has_markup"
  s.summary = "Manage markup close to home... right in the model! Caching, validation, etc"
  s.email = "josh@technicalpickles.com"
  s.authors = ["Josh Nichols"]
  s.homepage = "http://github.com/technicalpickles/has_markup"
  s.description = "Manage markup close to home... right in the model! Caching, validation, etc"
  s.version = "0.1.5"
  s.files.exclude('vendor/**/*')
end
Jeweler::GemcutterTasks.new

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc 'Generate documentation for the safety_valve plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'HasMarkup'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Run the test suite"
task :default => :test
