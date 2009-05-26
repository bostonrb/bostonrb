# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{feedra}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.date = %q{2009-05-26}
  s.email = %q{josh@technicalpickles.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "feedra.gemspec",
     "generators/feedra/feedra_generator.rb",
     "generators/feedra/templates/entry.rb",
     "generators/feedra/templates/feed.rb",
     "generators/feedra/templates/feed_error.rb",
     "generators/feedra/templates/migration.rb",
     "lib/feedra.rb",
     "lib/feedra/entry.rb",
     "lib/feedra/extensions/feedzirra.rb",
     "lib/feedra/feed.rb",
     "spec/feedra_spec.rb",
     "spec/spec_helper.rb",
     "spec/summifire_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/technicalpickles/feedra}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pickles}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple feed aggregation for Rails.}
  s.test_files = [
    "spec/feedra_spec.rb",
     "spec/spec_helper.rb",
     "spec/summifire_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pauldix-feedzirra>, [">= 0"])
    else
      s.add_dependency(%q<pauldix-feedzirra>, [">= 0"])
    end
  else
    s.add_dependency(%q<pauldix-feedzirra>, [">= 0"])
  end
end
