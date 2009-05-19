require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end
 
desc 'Generate RDoc documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE', 'Rakefile').
    include('lib/**/*.rb')
  
  rdoc.main = "README.rdoc"
  rdoc.title = "utility_scopes documentation"
  
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8'
  rdoc.options << '--webcvs=http://github.com/yfactorial/utility_scopes/tree/master/'
end