FactoryBot.define do
  factory :answer do
    question
    title { 'MyString' }
    user
  end

  factory :invalid_answer, class: 'Answer' do
    question { create(:question) }
  end
end
