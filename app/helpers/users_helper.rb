# frozen_string_literal: true

module UsersHelper
  def avatar_for(user, size: 80, link_it: true)
    if user.image.blank?
      avatar_id = Digest::MD5.hexdigest(user.email.downcase)
      avatar_url = "https://secure.gravatar.com/avatar/#{avatar_id}?s=#{size}"
    else
      avatar_url = user.image
    end
    tag = image_tag(avatar_url, alt: user.username, class: 'gravatar', width: size)
    link_it ? link_to(tag, user_path(user.username)) : tag
  end
end
