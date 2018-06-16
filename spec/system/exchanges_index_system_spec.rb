require 'rails_helper'

RSpec.describe "Exchange Currency Process", type: :system, js: true do
  it "show exchanged value" do
    visit '/'
    within("#exchange_form") do
      select('EUR', from: 'source_currency')
      select('USD', from: 'target_currency')
      fill_in 'amount', with: '10'
    end
    click_button 'CONVERTER'

    expect(page).to have_content("source_currency")
    expect(page).to have_content("target_currency")
    expect(page).to have_content("money_value")
    expect(page).to have_content("bitcoin_value")
  end
end
