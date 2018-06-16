class ExchangesController < ApplicationController

  def index
  end

  def convert
    money_value    = ExchangeService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
    to_btc_value   = ExchangeBitcoinService.new(params[:source_currency], params[:amount]).currency_to_btc
    from_btc_value = ExchangeBitcoinService.new(params[:source_currency], params[:amount]).currency_from_btc

    render json: {
      source_currency: params[:source_currency],
      target_currency: params[:target_currency],
      money_value:     money_value,
      to_btc_value:    to_btc_value,
      from_btc_value:  from_btc_value
    }
  end

end
