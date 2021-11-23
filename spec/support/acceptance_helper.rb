module AcceptanceHelper
  def sign_in(user)
    visit(new_user_session_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')
  end

  def sign_up(email, password, password_conf)
    visit(new_user_registration_path)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('user_password_confirmation', with: password_conf)
    click_on('Sign up')
  end
end
