module UsersHelper
  def gravatar_for user, options = {size: 80}
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def can_destroy_user? user
    current_user.admin? && !current_user?(user)
  end

  def init_active_relationship
    current_user.active_relationships.build
  end

  def get_active_relationship user
    current_user.active_relationships.find_by followed: user
  end
end
