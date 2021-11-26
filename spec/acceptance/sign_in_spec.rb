require_relative 'acceptance_helper'

feature 'User sign in', '
  Inorder to be able to ask question
  As an User
  I want to be able to sign in
' do
  given(:user) { create(:user) }

  it 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to(have_content('Signed in successfully.'))
    expect(page).to(have_current_path(root_path, ignore_query: true))
  end

  it 'Non registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@tet.test'
    fill_in 'Password', with: 'incorrect_password'
    click_on 'Log in'

    expect(page).to(have_content('Invalid Email or password.'))
    expect(page).to(have_current_path(new_user_session_path, ignore_query: true))
  end
end
