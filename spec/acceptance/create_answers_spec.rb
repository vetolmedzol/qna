require 'rails_helper'

feature 'User answer', '
In order to exchange my knowledge
As an authenticated  User
I  want to be able to create answers
' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(page).to(have_current_path(question_path(question), ignore_query: true))
    within '.answers' do
      expect(page).to(have_content('My answer'))
    end
  end
end