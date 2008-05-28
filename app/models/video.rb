# == Schema Information
# Schema version: 8
#
# Table name: videos
#
#  id         :integer         not null, primary key
#  title      :string(255)     
#  url        :string(255)     
#  embed      :text            
#  created_at :datetime        
#  updated_at :datetime        
#

class Video < ActiveRecord::Base
  
  before_save :get_embed
  
  def self.all
    find :all, :order => 'updated_at desc'
  end
  
  private
  
    def get_embed
      doc = Hpricot open(self.url)
      div = (doc/'#embed-video').first
      self.embed = CGI::unescapeHTML((div/:textarea).first.inner_html)
    rescue
      errors.add_to_base 'A video could not be found at the url provided'
    end
  
end
