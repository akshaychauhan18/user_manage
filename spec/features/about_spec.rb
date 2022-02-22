require "rails_helper"

feature "About" do
  let(:random_user) { create(:random_user) }

  def fill_in_signin_fields
    visit (new_user_session_path)
    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    click_button "Log in"
  end

  scenario "visiting the about page" do
    visit (home_about_path)
    expect(page).to have_content("About us")
  end

  context "log in before creating a friend" do
    scenario "when user is not logged in, signout not present" do
      visit (home_about_path)
      expect(page).not_to have_content("Sign Out")
    end
    scenario "when user is logged in, signout present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).to have_content("Sign Out")
    end
  end

  context "Edit Profile before creating a user" do
    scenario "when user is not log in Edit Profile not present" do
      visit (home_about_path)
      expect(page).not_to have_content("Edit Profile")
    end

    scenario "when user is log in Edit Profile present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).to have_content("Edit Profile")
    end
  end

  context "Add Friend before creating a user" do
    scenario "when user is not log in Add Friend not present" do
      visit (home_about_path)
      expect(page).not_to have_content("Add Friend")
    end

    scenario "when user is log in Add Friend present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).to have_content("Add Friend")
    end
  end

  context "Sign up after creating a user" do
    scenario "when user is log in Sign Up present" do
      visit (home_about_path)
      expect(page).to have_content("Sign Up")
    end

    scenario "when user is log in Sign Up not present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).not_to have_content("Sign Up")
    end
  end

  context "Sign up after creating a user" do
    scenario "when user is log in Sign Up present" do
      visit (home_about_path)
      expect(page).to have_content("Sign Up")
    end

    scenario "when user is log in Sign Up not present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).not_to have_content("Sign Up")
    end
  end

  context "Sign up after creating a user" do
    scenario "when user is log in Sign In present" do
      visit (home_about_path)
      expect(page).to have_content("Sign Up")
    end

    scenario "when user is log in Sign In not present" do
      fill_in_signin_fields
      visit (home_about_path)
      expect(page).not_to have_content("Sign In")
    end
  end
end
