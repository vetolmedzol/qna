FactoryBot.define do
  factory :rating_answer do
    question
    title { 'My rating answer title' }
    user
  end
end
