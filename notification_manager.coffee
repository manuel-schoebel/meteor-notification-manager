class @NotificationManager

  @setError : (msg) ->
    NotificationManager.render(msg, 'danger')
  @setSuccess : (msg) ->
    NotificationManager.render(msg, 'success')
  @setWarning: (msg) ->
    NotificationManager.render(msg, '')

  @render: (msg, type) ->
    Meteor.clearTimeout(Session.get('currentTimeout')) if Session.get('currentTimeout')
    $('#notification-top').remove()
    $('body').append(new Handlebars.SafeString(Template['notificationTop']({message: msg, type: type})).string)
    $('#notification-top').fadeIn()
    timeoutId = Meteor.setTimeout(
      () ->
        $('#notification-top').fadeOut(500, () -> $('#notification-top').remove())
      3000
    )
    Session.set('currentTimeout', timeoutId)