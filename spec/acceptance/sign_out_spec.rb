feature 'User signs out', '
  In order to have ability finish session
As an user
I want have an ability to sign out
' do
  given(:user) { create(:user) }

  scenario 'Registered user trying to sign out' do
    sign_in(user)

    click_on 'Sign Out'

    expect(page).to(have_content('Signed out successfully.'))
    expect(page).to(have_current_path(root_path, ignore_query: true))
  end

  scenario 'Non-logged user trying to sign out' do
    visit '/questions'
    expect(page).not_to(have_link('Sign Out'))
  end
end
