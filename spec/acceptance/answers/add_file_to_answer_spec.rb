require_relative '../acceptance_helper'

feature 'Add file to answer', '
    In order to illustrate my answer
    As an answer author
    I want to be able to attach file to answer
' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  it 'User adds file when asks question', js: true do
    fill_in 'answer[title]', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to(have_link('spec_helper.rb'), href: 'uploads/attachment/file/1')
    end
  end
end
