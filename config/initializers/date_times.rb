# Example time formats
{ :short_date => "%x", 
  :long_date  => "%a, %b %d, %Y",
  :european   => "%m.%d.%y" }.each do |k, v|
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(k => v)
end
