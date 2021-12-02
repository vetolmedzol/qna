require_relative '../acceptance_helper'

feature 'User show question', '
  In order to show answers
  As an user
  I want to show question page
' do
  given!(:question) { create(:question) }

  scenario 'User look through question' do
    visit questions_path
    click_on question.title

    expect(page).to(have_content(question.title))
    expect(page).to(have_content(question.body))
    expect(page).to(have_current_path(question_path(question), ignore_query: true))
  end
end
