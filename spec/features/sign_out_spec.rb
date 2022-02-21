require "rails_helper"

feature "sign out" do
  let(:random_user) { FactoryBot.create(:random_user) }

  scenario "visiting the site to sign in" do
    visit (destroy_user_session_path)
    # click_link "Sign Out"
    expect(page).to have_content("Signed out successfully.")
  end
end
