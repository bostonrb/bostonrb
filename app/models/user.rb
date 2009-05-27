class User < ActiveRecord::Base
  include Clearance::User
  include Pacecar

  is_gravtastic

  has_many :presentations
  has_many :tweets
  has_many :projects
  has_one  :feed, :as => :feed_owner, :dependent => :destroy
  belongs_to :company
