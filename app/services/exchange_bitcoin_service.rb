require 'rest-client'
require 'json'

class ExchangeBitcoinService

  def initialize(source_currency, amount)
    @source_currency = source_currency
    @amount          = amount.to_f
  end

  def perform
    begin
      exchange_bitcoin_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_bitcoin_api_url]

      url = "#{exchange_bitcoin_api_url}?currency=#{@source_currency}&value=#{@amount}"
      res = RestClient.get(url)

      value = JSON.parse(res.body)
    rescue RestClient::ExceptionWithResponse => e
      e.response.body
    end
  end

end
