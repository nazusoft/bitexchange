require 'spec_helper'
require 'json'
require './app/services/exchange_bitcoin_service'

describe 'Currency' do

  it 'to_btc' do
    amount = rand(0..9999)
    res    = ExchangeBitcoinService.new("USD", amount).currency_to_btc

    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end

  it 'from_btc' do
    amount = rand(0..9999)
    res    = ExchangeBitcoinService.new("USD", amount).currency_from_btc

    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end

end
