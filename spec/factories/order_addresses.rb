FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    state_id { Faker::Number.between(from: 2, to: 47) }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
