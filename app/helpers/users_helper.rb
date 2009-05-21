module UsersHelper
  def collage_of(users)
    users.collect { |user| image_tag(user.gravatar_url) }
  end

  def collage_div_attributes(index)
    options = { :id => "collage_group_#{index}" }

    returning options do
      options[:class] = 'hidden' if index != 0
    end
  end
end
