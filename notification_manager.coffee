class @NotificationManager

  @setError : (msg, options) ->
    NotificationManager.render(msg, 'danger', options)
  @setSuccess : (msg, options) ->
    NotificationManager.render(msg, 'success', options)
  @setWarning: (msg, options) ->
    NotificationManager.render(msg, '', options)

  @render: (msg, type, options) ->

    if options.sticky
      @renderSticky(msg, type, options)
    else
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

  @renderSticky: (msg, type, options) ->
    $('body').append(new Handlebars.SafeString(Template['notificationTop']( {
      message: msg,
      type: type,
      html: options.html,
      sticky: options.sticky
    } )))

    $('#notification-top').alert()