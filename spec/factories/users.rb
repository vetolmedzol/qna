FactoryBot.define do
  sequence :email do |n|
    "test#{n}@test.test"
  end
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email
    password { 'best_password_ever' }
    password_confirmation { 'best_password_ever' }
  end
end
