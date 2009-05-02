class Video < ActiveRecord::Base

  before_save :populate_embed

  named_scope :all, :order => 'updated_at desc'

  def populate_embed
    doc = Hpricot open(self.url)
    div = (doc/'#embed-video').first
    self.embed = CGI::unescapeHTML((div/:textarea).first.inner_html)
  rescue Exception
    errors.add_to_base 'A video could not be found at the url provided'
  end

end
