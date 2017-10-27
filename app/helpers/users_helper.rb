module UsersHelper
  def show_avatar_for user
    image_tag(user.picture.url, class: "img-circle img-responsive")
  end

  def displayed_user_column_names
    User.column_names - %w(id created_at updated_at password_digest remember_digest admin picture) + %w(action admin?)
  end
end
