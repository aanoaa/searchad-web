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

  $('.btn-stop,.btn-resume').click (e) ->
    e.preventDefault()
    active = if $(@).hasClass('btn-stop') then 0 else 1
    $.ajax location.href,
      type: 'PUT'
      data: { active: active }
      success: (data, textStatus, jqXHR) ->
        location.reload()
      error: (jqXHR, textStatus, err) ->
        alert("something wrong: #{textStatus}")

  $('#bundle-info tr').on 'click', 'th.active-on', (e) ->
    e.preventDefault();
    day  = $(@).text()
    type = if $(@).hasClass('success') then 'DELETE' else 'POST'
    $.ajax "#{location.href}/days/#{day}",
      type: type
      success: (data, textStatus, jqXHR) ->
        location.reload()
      error: (jqXHR, textStatus, err) ->
        alert("something wrong: #{textStatus}")
