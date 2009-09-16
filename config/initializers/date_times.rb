{ :short_date => "%x",                                   # 06/18/09
  :long_date  => "%a, %b %d, %Y",                        # Thu, Jun 18, 2009
  :fancy_date => "%B %d, %Y",                            # June 18, 2009
  :fancy_date_with_time => "%B %d, %Y %I:%M %p",         # June 18, 2009 12:58 AM
  :fancy_date_with_time_with_day => "%B %d, %Y %I:%M %p",# Thursday, June 18, 2009 12:58 AM
  :time => '%I:%M %p',                                   # 12:58 AM 
  :european   => "%m.%d.%y"                              # 06.18.09
}.each do |k, v|
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(k => v)
end
