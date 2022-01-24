require_relative '../acceptance_helper'

feature 'User answer', '
In order to exchange my knowledge
As an authenticated User and as author of answer
I  want to be able to delete answers
' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author, title: 'My answer') }

  describe 'Authenticated user' do
    scenario 'author delete answer', js: true do
      sign_in(author)
      visit question_path(question)

      expect(page).to(have_content('My answer'))
      within '.answers' do
        click_on 'Delete'
      end

      expect(page).to(have_current_path(question_path(question), ignore_query: true))
      within '.answers' do
        expect(page).to(have_no_content('My answer'))
      end
    end

    scenario 'not author try to delete answer', js: true do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        expect(page).to(have_no_content('Delete'))
      end
    end
  end
end
