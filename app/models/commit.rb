# == Schema Information
# Schema version: 8
#
# Table name: commits
#
#  id           :integer         not null, primary key
#  title        :string(255)     
#  url          :string(255)     
#  published_at :datetime        
#  project_id   :integer         
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Commit < ActiveRecord::Base

  belongs_to :project

end
