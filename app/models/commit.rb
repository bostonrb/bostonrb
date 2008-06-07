# == Schema Information
# Schema version: 13
#
# Table name: commits
#
#  id           :integer(11)     not null, primary key
#  title        :string(255)     
#  url          :string(255)     
#  published_at :datetime        
#  project_id   :integer(11)     
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Commit < ActiveRecord::Base

  belongs_to :project

end
