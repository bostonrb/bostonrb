module UsersHelper
  def collage_of(users)
    users.collect { |user| image_tag(user.gravatar_url) }
  end
end
