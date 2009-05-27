class Feed < ActiveRecord::Base
  include Feedra::Feed

  belongs_to :feed_owner, :polymorphic => true
end
