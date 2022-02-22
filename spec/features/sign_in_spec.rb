require "rails_helper"

feature "sign in" do
  let(:random_user) { create(:random_user) }

  def fill_in_signin_fields
    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    click_button "Log in"
  end

  scenario "visiting the site to sign in" do
    visit (new_user_session_path)
    click_button "Log in"
    fill_in_signin_fields
    expect(page).to have_content("Signed in successfully")
  end

  scenario "invalid with unregistered account" do
    visit (new_user_session_path)

    fill_in "Email", with: random_user.email
    fill_in "Password", with: "FakePassword123"
    click_button "Log in"
    expect(page).to have_no_text "Welcome back"
  end

  scenario "click to sign up link" do
    visit (new_user_session_path)
    click_link "Sign up"
    expect(page).to have_button("Sign up")
  end

  scenario "click to forget password link" do
    visit (new_user_session_path)
    click_link "Forgot your password?"
    expect(page).to have_content "Forgot your password?"
  end
end
