$ ->
  smoothScroll.init()

  $('#new_enquiry').on 'submit', (e) ->
    e.preventDefault()

    $.ajax
      url: '/enquiries'
      type: 'POST'
      data: $(this).serialize()

      success: ->
        $('form').replaceWith($('<div data-alert class="alert-box success radius">Thanks! I\'ll get back to you shortly.</div>'))

      error: (response) ->
        $('.has-error span').each ->
          $(this).text($.trim($(this).text()).split(' - ')[0]).parent().removeClass('has-error')

        $.each response.responseJSON, (attr, error) ->
          label = $("#enquiry_#{attr}").closest('label').addClass('has-error')
          span = label.find('span')

          span.text("#{span.text()} - #{error}")
