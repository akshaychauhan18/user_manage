require "rails_helper"

RSpec.feature "Friends", type: :feature do
  let(:friends) { create(:friend) }
  let(:friend1) { build(:friend, email: "akshay@gmail.com", twitter: "akshay@tweet", phone: "9503466104") }

  let(:random_user) { create(:random_user) }

  def fill_in_signin_fields
    visit (new_user_session_path)
    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    click_button "Log in"
  end

  def fill_in_friend_fields
    fill_in "First Name", with: friends.first_name
    fill_in "Last Name", with: friends.last_name
    fill_in "Email", with: friends.email
    fill_in "Phone", with: friends.phone
    fill_in "Twitter", with: friends.twitter
  end

  context "log in before creating a friend" do
    scenario "creating a friend before login" do
      visit new_friend_path
      expect(page).to have_content("Log in")
    end
  end

  context "going to the friends page before login" do
    scenario "checking for friends before login" do
      visit friends_path
      expect(page).to have_content("Please Sign Up and Log In First")
    end
  end

  context "create new friend" do
    before(:each) do
      fill_in_signin_fields
    end

    scenario "Creating a new friend" do
      visit new_friend_path
      within("form") do
        fill_in "First Name", with: friend1.first_name
        fill_in "Last Name", with: friend1.last_name
        fill_in "Email", with: friend1.email
        fill_in "Phone", with: friend1.phone
        fill_in "Twitter", with: friend1.twitter
      end

      click_button "Create Friend"
      expect(page).to have_content(friend1.first_name)
    end
  end

  context "checking for all friends" do
    before(:each) do
      fill_in_signin_fields
    end

    scenario "Checking for friends" do
      visit friends_path
      expect(page).to have_current_path(friends_path)
    end
  end

  context "Destroy a friend" do
    before(:each) do
      fill_in_signin_fields
    end

    scenario "friend deleted" do
      visit new_friend_path
      within("form") do
        fill_in "First Name", with: friend1.first_name
        fill_in "Last Name", with: friend1.last_name
        fill_in "Email", with: friend1.email
        fill_in "Phone", with: friend1.phone
        fill_in "Twitter", with: friend1.twitter
      end

      click_button "Create Friend"
      expect(page).to have_content(friend1.first_name)

      click_button "Destroy this friend"
      expect(page).to have_content("Friend was successfully destroyed.")
    end
  end
end
