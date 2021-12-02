require_relative '../acceptance_helper'

feature 'User delete question', '
  In order to destroy question
  As an author
  I want destroy only my questions
' do
  given(:me)   { create(:user) }
  given(:user) { create(:user) }

  before { sign_in(me) }

  context 'Author question index page' do
    given!(:my_question) { create(:question, user: me) }

    scenario 'delete own question' do
      visit questions_path
      click_on 'Delete'

      expect(page).to(have_current_path(questions_path, ignore_query: true))
      expect(all('.question').count).to(eq(0))
    end
  end

  context 'Author question show page' do
    given!(:my_question) { create(:question, user: me) }

    scenario 'delete own question' do
      visit question_path(my_question)
      click_on 'Delete'

      expect(page).to(have_current_path(questions_path, ignore_query: true))
      expect(all('.question').count).to(eq(0))
    end
  end

  context 'User' do
    given!(:question) { create(:question, user: user, title: 'Delete') }

    scenario 'try delete foreign question' do
      visit questions_path
      expect(page).not_to(have_css('.delete-question-link'))
    end
  end
end
