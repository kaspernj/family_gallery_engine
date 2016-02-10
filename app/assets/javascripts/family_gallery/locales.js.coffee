$ ->
  $("select#locale").change ->
    locale_select = $(this)

    $.ajax
      method: "POST",
      url: locale_select.data("url"),
      data: {locale: locale_select.val()},
      dataType: 'json',
      complete: (data) ->
        response = $.parseJSON(data.responseText)
        location.reload() if response.success
