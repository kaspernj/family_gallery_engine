$ ->
  return if $("body.controller_pictures").length == 0

  if $("body.action_show").length > 0
    $(".tagged-users-list .link-to-user").hover ->
      user_link = $(this)
      user_id = user_link.data("user-id")

      tagged_user = $(".tagged-user-" + user_id)
      tagged_user.fadeIn("fast")
    , ->
      user_link = $(this)
      user_id = user_link.data("user-id")

      tagged_user = $(".tagged-user-" + user_id)
      tagged_user.fadeOut("fast")
