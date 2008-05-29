# == Schema Information
# Schema version: 8
#
# Table name: jobs
#
#  id           :integer         not null, primary key
#  gig          :boolean         
#  location     :string(255)     
#  organization :string(255)     
#  title        :string(255)     
#  description  :text            
#  email        :string(255)     
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Job < ActiveRecord::Base
  
  validates_presence_of :location, :organization, :title, :description
  
  has_finder :gigs,       :conditions => ['gig = ?', true],
                          :order      => 'updated_at desc'
  has_finder :full_time,  :conditions => ['gig = ?', false],
                          :order      => 'updated_at desc'
                          
  has_finder :all,        :order      => 'updated_at desc'
                          
  def job_type
    gig ? 'gig' : 'full-time'
  end
end
