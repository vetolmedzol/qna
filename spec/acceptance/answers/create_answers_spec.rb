require_relative '../acceptance_helper'

feature 'User answer', '
In order to exchange my knowledge
As an authenticated  User
I  want to be able to create answers
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(page).to(have_current_path(question_path(question), ignore_query: true))
    within '.answers' do
      expect(page).to(have_content('My answer'))
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Create'

    expect(page).to(have_content("Title can't be blank. You should add your answer here!"))
  end

  context 'multiple  sessions', :faye_normal do
    scenario 'all users see new answer in real-time', js: true do
      Capybara.using_session('author') do
        sign_in(user)
        visit question_path(question)
      end
      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('author') do
        fill_in 'Your answer', with: 'My answer'
        click_on 'Create'

        expect(page).to(have_current_path(question_path(question), ignore_query: true))
        within '.answers' do
          expect(page).to(have_content('My answer'))
        end
        Capybara.using_session('guest') do
          visit question_path(question)
          within '.answers' do
            expect(page).to(have_content('My answer'))
          end
        end
      end
    end
  end
end
