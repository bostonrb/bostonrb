class Summifire

  attr_accessor :summary, :content
  def initialize(summary, content)
    @summary = summary
    @content = content
  end

  def to_s(options = {})
    @summary.present? ? @summary : @content
  end

end
