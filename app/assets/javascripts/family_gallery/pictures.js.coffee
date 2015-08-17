$ ->
  return if $("body.controller_pictures").length == 0

  if $("body.action_show").length > 0
    if $("body.mobile").length > 0
      update_picture_width = ->
        window_width = $(window).width()
        window_height = $(window).height()

        orig_width = $('.picture-container').data('picture-width')
        orig_height = $('.picture-container').data('picture-height')
        sizes = $('.picture-container').data('picture-sizes')

        max_width = window_width - 60
        max_height = window_height - 110

        picture_width = max_width
        picture_height = orig_height / (orig_width / picture_width)

        if picture_height > max_height
          picture_height = max_height
          picture_width = orig_width / (orig_height / picture_height)

        picture_width = parseInt(picture_width)
        picture_height = parseInt(picture_height)

        if picture_width > picture_height
          smartsize = picture_width
        else
          smartsize = picture_height

        if smartsize >= parseInt($('.picture-container').data('sizes-small-smartsize'))
          picture_url = $('.picture-container').data('sizes-big-url')
        else
          picture_url = $('.picture-container').data('sizes-small-url')

        $('.picture-container').css({
          "width": picture_width + "px",
          "height": picture_height + "px",
          "background-size": picture_width + "px " + picture_height + "px",
          "background-image": "url('" + picture_url + "')"
        })

      $(window).resize ->
        update_picture_width()

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

        google_map = new google.maps.Map(document.getElementById('map-canvas'), map_options)

        marker = new google.maps.Marker(
          position: position_latlng,
          map: google_map
        )

      google.maps.event.addDomListener(window, "load", init_map)
