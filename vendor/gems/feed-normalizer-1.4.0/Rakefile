require 'hoe'

Hoe.new("feed-normalizer", "1.4.0") do |s|
  s.author = "Andrew A. Smith"
  s.email = "andy@tinnedfruit.org"
  s.url = "http://feed-normalizer.rubyforge.org/"
  s.summary = "Extensible Ruby wrapper for Atom and RSS parsers"
  s.description = s.paragraphs_of('Readme.txt', 1..2).join("\n\n")
  s.changes = s.paragraphs_of('History.txt', 0..1).join("\n\n")
  s.extra_deps << ["simple-rss", ">= 1.1"]
  s.extra_deps << ["hpricot", ">= 0.6"]
  s.need_zip = true
  s.need_tar = false
end


begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new("rcov") do |t|
    t.test_files = Dir['test/test_all.rb']
  end
rescue LoadError
  nil
end

