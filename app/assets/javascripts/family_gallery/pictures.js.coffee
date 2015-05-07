$ ->
  return if $("body.controller_pictures").length == 0

  if $("body.action_show").length > 0
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
