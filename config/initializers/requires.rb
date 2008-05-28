require 'rubygems'
require 'has_finder'
require 'hpricot'

# Automatically load all files under lib/extensions
Dir[File.join(RAILS_ROOT, 'lib', 'extensions', '*')].each do |file|
  require file
end