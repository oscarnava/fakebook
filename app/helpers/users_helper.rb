# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, size: 80, link_it: true)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    tag = image_tag(gravatar_url, alt: user.username, class: 'gravatar')
    link_it ? link_to(tag, user_path(user.username)) : tag
  end
end
