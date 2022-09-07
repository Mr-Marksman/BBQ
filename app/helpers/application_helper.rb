module ApplicationHelper
  def user_avatar(user)
    asset_path('logo.png')
  end

  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end
