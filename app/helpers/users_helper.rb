module UsersHelper
  def collage_of(users)
    users.collect { |user| 
      opts = {}
      opts[:title] = user.to_s if user.to_s
      if user.has_link?
        link_to image_tag(user.gravatar_url, opts), user.main_url, :target => :_blank
      else
        image_tag user.gravatar_url, opts
      end
    }
  end

  def collage_div_attributes(index)
    options = { :id => "collage_group_#{index}" }

    returning options do
      options[:class] = 'hidden' if index != 0
    end
  end

  def setup_user(user)
    returning user do
      user.build_feed unless user.feed
    end
  end
end
