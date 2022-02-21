require "rails_helper"

feature "sign out" do
  scenario "visiting the site to sign in" do
    visit (home_about_path)
    expect(page).to have_content("About us")
  end
end
