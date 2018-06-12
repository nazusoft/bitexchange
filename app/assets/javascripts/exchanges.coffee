$(document).ready ->
  $('#exchange_form').submit ->
    if $('#exchange_form').attr('action') == '/convert'
      loading('result')
      if $("#source_currency").val() == $("#target_currency").val()
        $('.modal-body').html "<h6 class='text-center'>Você escolheu a mesma moeda para conversão.</h6><h6 class='text-center'>Por favor escolha moedas diferentes.</h6>"
        $('#main-modal').modal 'toggle'
        cleanElement 'result', 'Resultado ...'
        return false;

      $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount:          $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
          success: (data, text, jqXHR) ->
            $('#result').html(data.value)
        return false;

loading = (element) ->
  $('#' + element).html "<i class='fa fa-spinner fa-spin'></i>"

cleanElement = (element,txt) ->
  $('#' + element).html txt
