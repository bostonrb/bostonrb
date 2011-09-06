{
 :short_date     => "04/13/10",          # %x
 :long_date      => "Tue, Apr 13, 2010", # %a, %b %d, %Y
 :month_and_year => "April 2011",        #  %B %Y
 :date           => "April 22, 2011"     #  %B %e, %Y
}.each do |format_name, format_string|
  Time::DATE_FORMATS[format_name] = Stamp.strftime_format(format_string)
end
