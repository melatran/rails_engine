FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 10) }
    credit_card_expiration_date { Faker::Date.in_date_period}
    result {'success'}
    invoice
  end
end
