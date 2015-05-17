require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run tests'
task default: :test

desc 'Generate documentation'
RDoc::Task.new :doc do |rdoc|
  rdoc.rdoc_files = ['lib']
  rdoc.rdoc_dir = 'doc'
end
