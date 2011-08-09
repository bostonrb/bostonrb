class Presentation < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :slides_url, :video_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true }
  validates :presented_at, :presence => true
  belongs_to :presenter
  has_many :presenters, :through => :presentation_groups
  has_many :presentation_groups
  before_validation :set_description

  def self.find_all_by_cached_slug_or_id(id)
    where(arel_table[:cached_slug].eq(id).or(arel_table[:id].eq(id)))
  end

  def self.group_by_date(order = :desc)
    order("presented_at #{order}").group_by(&:presented_at)
  end

  def self.past_or_by_month(params = {})
    relation = order('presented_at desc')

    if params[:month]
      month    = Date.parse(params[:month])
      relation = relation.where(arel_table[:presented_at].gteq(month.beginning_of_month))
      relation = relation.where(arel_table[:presented_at].lteq(month.end_of_month))
    else
      relation = relation.where(arel_table[:presented_at].lt(Date.today))
    end

    relation.page(params[:page]).per(params[:per])
  end

  def self.upcoming
    where(arel_table[:presented_at].gteq(Date.today).and(arel_table[:presented_at].lteq(1.month.from_now)))
  end

  def set_description
    if read_attribute(:description).blank?
      write_attribute(:description, 'Description pending...')
    end
  end

  def presenter_name=(name)
    if name.match(/(&|,)/)
      name.split(/,|&/ix).each { |presenter_name| self.single_presenter_name = presenter_name.strip }
    else
      self.single_presenter_name = name
    end
  end
  
  def single_presenter_name=(name)
    new_presenter = Presenter.find_or_initialize_by_name(name)
    self.presenters << new_presenter
    new_presenter.name  
  end

  VideoProviders  = %w{youtube vimeo blip}
  VideoDimensions = { :width => 625, :height => 370 }

  def video_url=(url)
    if url.present?
      self.video_provider = get_video_provider(url)
      self.video_id       = get_video_id(url)
    end
  end

  def video_url
    if video_provider && video_id
      self.send("#{video_provider}_url")
    end
  end

  def embed_video
    self.send("embed_#{video_provider}")
  end

  private

  def get_video_provider(url)
    VideoProviders.detect { |provider| url.match(provider) }
  end

  def get_video_id(url)
    self.send("#{self.video_provider}_match", url)
  end

  # Vimeo methods
  def vimeo_match(url)
    url.match(/http:\/\/(\w+\.)?vimeo.com\/(.+)/)[2]
  end

  def vimeo_url
    %{http://vimeo.com/#{video_id}}
  end

  def embed_vimeo
    %{<iframe src="http://player.vimeo.com/video/#{video_id}" width="#{VideoDimensions[:width]}" height="#{VideoDimensions[:height]}" frameborder="0"></iframe>}
  end

  # Youtube methods
  def youtube_match(url)
    url.match(/http:\/\/www\.youtube\.com\/watch\/?\?v=([^&]+)/)[1]
  end

  def youtube_url
    %{http://www.youtube.com/watch?v=#{video_id}}
  end

  def embed_youtube
    %{<iframe width="#{VideoDimensions[:width]}" height="#{VideoDimensions[:height]}" src="http://www.youtube.com/embed/#{video_id}" frameborder="0" allowfullscreen></iframe>}
  end

  # Blip.tv methods
  def blip_match(url)
    url.match(/http:\/\/blip\.tv\/play\/(.+)/)[1]
  end

  def blip_url
    %{http://blip.tv/play/#{video_id}}
  end

  def embed_blip
    %{<embed src="http://blip.tv/play/#{video_id}" type="application/x-shockwave-flash" width="#{VideoDimensions[:width]}" height="#{VideoDimensions[:height]}" allowscriptaccess="always" allowfullscreen="true"></embed>}
  end
end
