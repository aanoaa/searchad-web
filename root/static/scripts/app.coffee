$ ->
  $('.btn-delete').click (e) ->
    e.preventDefault()
    $.ajax location.href,
      type: 'DELETE'
      success: (data, textStatus, jqXHR) ->
        path = location.pathname.split('/')
        path.pop()
        location.href = path.join('/')
      error: (jqXHR, textStatus, err) ->
        alert("something wrong: #{textStatus}")
