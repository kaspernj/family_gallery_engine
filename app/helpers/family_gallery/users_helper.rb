module FamilyGallery::UsersHelper
  def link_to_user(user)
    link_to user.name, user, class: "link-to-user", data: {user_id: user.id}
  end
end
