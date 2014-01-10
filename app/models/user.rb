class User < ActiveRecord::Base
  validates_presence_of :github_uid, :name
  validates_uniqueness_of :github_uid, :display_name
end
