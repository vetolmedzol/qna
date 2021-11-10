FactoryBot.define do
  factory :answer do
    question { create(:question) }
    title { 'MyString' }
  end

  factory :invalid_answer, class: 'Answer' do
    question { create(:question) }
  end
end
