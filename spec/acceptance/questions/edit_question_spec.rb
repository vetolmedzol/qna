require_relative '../acceptance_helper'

feature 'User edit question', '
  In order to fix mistake
  As an author of question
  I want to be able edit my question
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:new_user) { create(:user) }

  describe 'Authenticated user' do
    context 'as an author' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'sees link to Edit' do
        expect(page).to(have_css('.edit-question-link'))
      end

      scenario 'try to edit his question', js: true do
        click_on 'Edit'

        fill_in 'Title', with: 'Edited question'
        fill_in 'Body', with: 'Edited question'
        click_on 'Save'

        expect(page).not_to(have_content(question.body))
        expect(page).to(have_content('Edited question'))
      end
    end

    scenario 'try to edit other user`s question' do
      sign_in(new_user)
      visit questions_path

      expect(page).not_to(have_css('.edit-question-link'))
    end
  end

  scenario 'Non-authenticated user try edit question' do
    visit questions_path

    expect(page).not_to(have_css('.edit-question-link'))
  end
end
