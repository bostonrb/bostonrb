SHOULDA_NOISE      = %w( shoulda )
FACTORY_GIRL_NOISE = %w( factory_girl )
RUBY_NOISE         = %w( Ruby.framework )
HAML_NOISE         = %w( lib/haml lib/sass )
TEST_NOISE         = %w( test/unit )

NOISE = SHOULDA_NOISE + FACTORY_GIRL_NOISE + RUBY_NOISE + HAML_NOISE + TEST_NOISE

METHOD_SIG = /:in `.*/

Rails.backtrace_cleaner.add_silencer do |line|
  NOISE.any? { |dir| line.include?(dir) }
end

Rails.backtrace_cleaner.add_filter do |line|
  line.sub(METHOD_SIG, '')
end

# When debugging, uncomment the next line.
# Rails.backtrace_cleaner.remove_silencers!

