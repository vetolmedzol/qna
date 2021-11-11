FactoryBot.define do
  sequence :email do |n|
    "test#{n}@test.test"
  end
  factory :user do
    email
    password { 'best_password_ever' }
    password_confirmation { 'best_password_ever' }
  end
end
