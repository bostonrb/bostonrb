# from http://gist.github.com/187769
module TemporalHelper
  def parse_temporal(temporal)
    case temporal
    when NilClass, ''
      nil
    when Time, Date, DateTime
      temporal
    else
      temporal = temporal.to_s
      Chronic.parse(temporal) || Time.parse(temporal)
    end
  end
end
