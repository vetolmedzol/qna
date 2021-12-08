require_relative '../acceptance_helper'

feature 'Add file to question', '
    In order to illustrate my question
    As an questions author
    I want to be able to attach file to question
' do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end
  it 'User adds file when asks question' do
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'test question body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to(have_link('spec_helper.rb'), href: 'uploads/attachment/file/1')
  end
end
