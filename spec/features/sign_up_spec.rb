require "rails_helper"

feature "sign up" do
  let(:random_user) { build(:random_user) }

  scenario "invalid with invalid password" do
    visit (new_user_registration_path)

    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    fill_in "Password Confirmation", with: "FakePassword13"
    click_button "Sign up"

    expect(page).to have_text "Password confirmation doesn't match Password"
  end

  scenario "If user already exits" do
    existing_user = create(:random_user, :duplicate_email)
    visit (new_user_registration_path)

    fill_in "Email", with: "a@gmail.com"
    fill_in "Password", with: random_user.password
    fill_in "Password Confirmation", with: random_user.password
    click_button "Sign up"

    expect(page).to have_text "Email has already been taken"
  end

  scenario "Signed up successfully" do
    visit (new_user_registration_path)

    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    fill_in "Password Confirmation", with: random_user.password
    click_button "Sign up"

    expect(page).to have_text "Welcome! You have signed up successfully"
  end

  scenario "click to log in link" do
    visit (new_user_registration_path)
    click_link "Log in"

    expect(page).to have_button("Log in")
  end
end
