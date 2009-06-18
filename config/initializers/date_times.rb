{ :short_date => "%x",
  :long_date  => "%a, %b %d, %Y",
  :fancy_date => "%B %d, %Y",
  :fancy_date_with_time => "%B %d, %Y %I:%M %p",
  :time => '%I:%M %p',
  :european   => "%m.%d.%y" }.each do |k, v|
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(k => v)
end
