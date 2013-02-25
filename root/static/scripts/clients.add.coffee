$ ->
  $(':submit').click (e) ->
    password = $('input[name=password]').val()
    hashed_password = salogin.digest(password)
    console.log hashed_password
    $('input[name=password]').val(hashed_password)
