$(document).ready ->
  $('#amount').mask('0.000.000.000,00', {reverse: true})

  setTargetCurrency()

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

    exchange($('#amount').val())

  $('#source_currency, #target_currency').change () ->
    exchange($('#amount').val())

exchange = (amount) ->
  setTargetCurrency()

  if($('#amount').val() != '')
    loading()

    amount = amount.split('.').join('').split(',').join('.')

    #$('#money_result').html(amount);
    #$('#bicoin_result').html(amount);

    if $("#source_currency").val() == $("#target_currency").val()
      $('#source_currency').val('BRL')
      $('#target_currency').val('EUR')

      $('.modal-body').html("<h6 class='text-center'>Você escolheu a mesma moeda para conversão.</h6><h6 class='text-center'>Por favor escolha moedas diferentes.</h6>")
      $('#main-modal').modal('toggle')
      clearResult()
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
          $('#money_result').html("#{data.money_value}".substring(0,10))
          $('#to_bitcoin_result').html("#{data.to_btc_value}".substring(0,10))
          $('#from_bitcoin_result').html("#{data.from_btc_value}".substring(0,10))
      return false;

loading = () ->
  $('#money_result,#to_bitcoin_result,#from_bitcoin_result').html "<i class='fa fa-spinner fa-spin'></i>"

clearResult = ()->
  $('#money_result,#to_bitcoin_result,#from_bitcoin_result').html('Resultado ...')

setTargetCurrency = () ->
  $('#money_result_title').html($('#target_currency').val())
  $('#to_bitcoin_result_title').html($('#source_currency').val())
  $('#from_bitcoin_result_title').html($('#source_currency').val())
