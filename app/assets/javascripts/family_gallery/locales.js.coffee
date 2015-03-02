$ ->
  $("select#locale").change ->
    locale_select = $(this)

    $.ajax method: "POST", url: locale_select.data("url"), data: {locale: locale_select.val()}, cache: false, async: false, complete: (data) ->
      response = $.parseJSON(data.responseText)
      location.reload() if response.success
