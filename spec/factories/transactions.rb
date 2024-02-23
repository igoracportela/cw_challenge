FactoryBot.define do
  factory :transaction do
    transaction_id { rand(1..10001) }
    merchant_id { rand(1..10001) }
    user_id { rand(1..10001) }
    card_number { Faker::Bank.account_number(digits: 16) }
    transaction_date { Time.current }
    transaction_amount { rand(1..10001) }
    device_id { rand(1..10001) }
  end
end
