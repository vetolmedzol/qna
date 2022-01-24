require_relative '../acceptance_helper'

feature 'Answer editing', "
In order to fix mistake
As an author of answer
I'd like to be able to edit my answer
" do
  given(:author) { create(:user, email: 'author@author.author') }
  given(:user) { create(:user, email: 'just@fucking.user') }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)
    expect(page).not_to(have_content('Edit'))
  end

  describe 'Authenticated user' do
    scenario 'sees link to edit answer' do
      sign_in(author)
      visit question_path(question)
      within '.answers' do
        expect(page).to(have_content('Edit'))
      end
    end

    scenario 'author try to edit his answer', js: true do
      sign_in(author)
      visit question_path(question)
      within '.answers' do
        click_on 'Edit'
        fill_in 'rating_answer_title', with: 'edited answer'
        click_on 'Save'

        expect(page).not_to(have_content(answer.title))
        expect(page).to(have_content('edited answer'))
      end
    end

    scenario "Authenticated user try to edit other user's answer" do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        expect(page).not_to(have_link('Edit'))
      end
    end
  end
end
