$ ->
  $('#new_contact, .edit_contact').validate rules:
    'contact[emails_attributes]': email: true
    'contact[phones_attributes]': phone: true

  setTimeout (->
    $('#flash_notice, #flash_alert, #errors').hide('slow')
  ), 3000


jQuery.validator.addMethod 'phone', ((phone_number, element) ->
  @optional(element) or phone_number.length > 9 and phone_number.match(/(?:\+\d+)?\s*(?:\(\d+\)\s*(?:[/--]\s*)?)?\d+(?:\s*(?:[\s/–-]\s*)?\d+)*/)
), 'Please specify a valid phone number'
