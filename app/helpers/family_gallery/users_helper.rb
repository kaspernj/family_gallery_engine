module FamilyGallery::UsersHelper
  def link_to_user(user, args = {})
    return "[#{helper_t('.no_user')}]" unless user

    if args[:title].present?
      title = args[:title]
    else
      title = user.name
    end

    link_to title, user, class: "link-to-user", data: {user_id: user.id}
  end
end
