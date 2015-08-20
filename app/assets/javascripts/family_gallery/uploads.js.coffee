$ ->
  $('#fileupload').fileupload
    dataType: 'json',
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)

      $('#progress .bar').css({
        'width': progress + '%'
      })

      location.href = $('#fileupload').data('group-path') if progress == 100
