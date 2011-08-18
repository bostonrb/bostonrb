{
 :short_date  => "%x",            # 04/13/10
 :long_date   => "%a, %b %d, %Y", # Tue, Apr 13, 2010
 :month_and_year => "%B %Y",      # April 2011
 :date => '%B %e, %Y'             # April 22, 2011
}.each do |format_name, format_string|
  Time::DATE_FORMATS[format_name] = format_string
end
