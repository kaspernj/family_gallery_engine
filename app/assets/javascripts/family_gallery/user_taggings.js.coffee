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

      left = parseInt(picture.data("pos-left"))
      top = parseInt(picture.data("pos-top"))

      left_percentage = (left / width) * 100
      top_percentage = (top / height) * 100

      $("#user_tagging_position_left").val(left_percentage)
      $("#user_tagging_position_top").val(top_percentage)

      marker = $(".tagging-marker")
      marker_left = left - 50
      marker_top = top - 50
      marker.css({left: marker_left, top: marker_top})
