module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.url
    else
      asset_path('logo.png')
    end
  end

  def main_photo(event)
    if event.pictures.exists? && event.pictures.first.photo.attached?
      event.pictures.first.photo.url
    else
      asset_path('logo.png')
    end
  end

  def current_user_can_edit?(model)
    user_signed_in? && 
    (model.user == current_user || (model.try(:event).present? && model.event.user == current_user))
  end
end
