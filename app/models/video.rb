# == Schema Information
# Schema version: 13
#
# Table name: videos
#
#  id         :integer(11)     not null, primary key
#  title      :string(255)     
#  url        :string(255)     
#  embed      :text            
#  created_at :datetime        
#  updated_at :datetime        
#  presenter  :string(255)     
#  source     :string(255)     
#  deleted_at :datetime        
#

class Video < ActiveRecord::Base
  
  before_save :populate_embed
  
  has_finder :all, :order => 'updated_at desc'
  
  acts_as_paranoid

  def populate_embed
    doc = Hpricot open(self.url)
    div = (doc/'#embed-video').first
    self.embed = CGI::unescapeHTML((div/:textarea).first.inner_html)
  rescue Exception
    errors.add_to_base 'A video could not be found at the url provided'
  end
  
end
