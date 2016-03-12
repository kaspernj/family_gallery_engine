$ ->
  return if $("body.controller_pictures").length == 0

  if $("body.action_show").length > 0
    body = $("body")
    panel = $(".picture-panel")
    container = $(".picture-container")
    tagged_users = $(".tagged-users-list")
    img = $(".picture-container img")

    sizes = container.data("picture-sizes")

    image_width = parseInt(img.data("width"))
    image_height = parseInt(img.data("height"))

    big_smartsize = parseInt(container.data('sizes-small-smartsize'))

    if image_width >= image_height
      panel.addClass("picture-horizontal")
    else
      panel.addClass("picture-vertical")

    update_picture_width = ->
      window_width = $(window).width()
      window_height = $(window).height()

      if big_smartsize <= window_width
        picture_url = $(container).data("sizes-big-url")
      else
        picture_url = $(container).data("sizes-small-url")

      img.attr("src", picture_url) unless img.attr("src") == picture_url

      max_height = window_height - 70
      min_height = 250

      width = tagged_users.width() - 35
      height = height_from_width(width)

      if height > max_height
        height = max_height
        height = min_height if height < min_height
        width = width_from_height(height)

      img.css({
        "width": width,
        "height": height
      })

    height_from_width = (width) ->
      parseInt(image_height / (image_width / width))

    width_from_height = (height) ->
      parseInt(image_width / (image_height / height))

    $(window).resize -> update_picture_width()
    update_picture_width()

    # Makes the markers of the tagged users appear / disappear.
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

    # Inits the Google Map for the location.
    map_container = $("#map-canvas")

    if map_container.length > 0
      init_map = ->
        latitude = parseFloat(map_container.data("latitude"))
        longitude = parseFloat(map_container.data("longitude"))

        position_latlng = new google.maps.LatLng(latitude, longitude)

        map_options = {
          zoom: 10,
          center: position_latlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }

        map_canvas = document.getElementById('map-canvas')
        google_map = new google.maps.Map(map_canvas, map_options)

        marker = new google.maps.Marker(
          position: position_latlng,
          map: google_map
        )

      google.maps.event.addDomListener(window, "load", init_map)
