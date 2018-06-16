$(document).ready ->
  $('#amount').mask('0.000.000.000,00', {reverse: true});

  $('#amount').keypress (e) ->
    if(e.keyCode == 13)
      return false

  $('#amount').keyup (e) ->
    if(e.key.match(/[0-9]/) and $('#amount').val() != '')
      exchange(this.value)

    if($('#amount').val() == '')
      clearResult('result')

  $('.btn-invert-currency').click ->
    source_currency = $("#source_currency").val()
    target_currency = $("#target_currency").val()
    $("#source_currency").val(target_currency)
    $("#target_currency").val(source_currency)

    if($('#amount').val() != '')
      exchange($('#amount').val())

exchange = (amount) ->
  loading('result')

  amount = amount.split('.').join('').split(',').join('.')

  if $("#source_currency").val() == $("#target_currency").val()
    $('.modal-body').html("<h6 class='text-center'>Você escolheu a mesma moeda para conversão.</h6><h6 class='text-center'>Por favor escolha moedas diferentes.</h6>")
    $('#main-modal').modal('toggle')
    clearResult('result')
    return false;

  $.ajax '/convert',
      type: 'GET'
      dataType: 'json'
      data: {
              source_currency: $("#source_currency").val(),
              target_currency: $("#target_currency").val(),
              amount:          amount
            }
      error: (jqXHR, textStatus, errorThrown) ->
        alert textStatus
      success: (data, text, jqXHR) ->
        $('#result').html(data.value)
    return false;

loading = (element) ->
  $('#' + element).html "<i class='fa fa-spinner fa-spin'></i>"

clearResult = (element)->
  $('#' + element).html('Resultado ...')
