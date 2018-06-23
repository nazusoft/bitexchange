require 'rest-client'
require 'json'

class ExchangeBitcoinService

  def initialize(source_currency, amount)
    @exchange_bitcoin_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_bitcoin_api_url]
    @source_currency          = source_currency
    @amount                   = amount.to_f
  end

  def currency_to_btc
    begin
      url = "#{@exchange_bitcoin_api_url}/tobtc?currency=#{@source_currency}&value=#{@amount}"
      res = RestClient.get(url)

      value = JSON.parse(res.body)

      value * @amount
    rescue RestClient::ExceptionWithResponse => e
      nil
    end
  end

  def currency_from_btc
    begin
      url   = "#{@exchange_bitcoin_api_url}/ticker"
      res   = RestClient.get(url)
      value = JSON.parse(res.body)[@source_currency]

      value ? (value['last'].to_f * @amount) : '-'
    rescue RestClient::ExceptionWithResponse => e
      nil
    end

  end

end
