require_relative 'acceptance_helper'

feature 'Create qestions', '
    In order to get answer fromm community
    As an authenticated user
    I want to be able toask question
' do
  given(:user) { create(:user) }

  it 'Authenticated user creates questions' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'test question body'
    click_on 'Create'

    expect(page).to(have_content('Your question successfully created!'))
    expect(page).to(have_content('test question'))
    expect(page).to(have_content('test question body'))
  end

  it 'Non-authenticated user tries to create questions' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to(have_content('You need to sign in or sign up before continuing.'))
  end
end
