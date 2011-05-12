class Presentation < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :slides_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true }
  validates :presented_at, :presence => true
  validates :presenter_name, :presence => true

  def self.group_by_date
    order('presented_at desc').group_by(&:presented_at)
  end

  def embed_video
<<-HTML
<iframe src="http://player.vimeo.com/video/#{vimeo_id}" width="625" height="370" frameborder="0"></iframe>
HTML
  end
end
