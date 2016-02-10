$ ->
  return unless $("body.controller_user_taggings").length > 0

  if $("body.controller_user_taggings.action_new, body.controller_user_taggings.action_edit").length > 0
    $(".picture").mousemove (event) ->
      position = $(this)[0].getBoundingClientRect()
      picture = $(this)

      picture.data("pos-left", event.clientX - parseInt(position.left))
      picture.data("pos-top", event.clientY - parseInt(position.top))

    $(".picture").click ->
      picture = $(this)

      width = parseInt(picture.data("width"))
      height = parseInt(picture.data("height"))

      left = parseInt(picture.data("pos-left")) - 50
      top = parseInt(picture.data("pos-top")) - 50

      left_percentage = (left / width) * 100
      top_percentage = (top / height) * 100

      $("#user_tagging_position_left").val(left_percentage)
      $("#user_tagging_position_top").val(top_percentage)

      $(".tagging-marker").css({"left": left, "top": top})
