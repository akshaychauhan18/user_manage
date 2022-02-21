require "rails_helper"

RSpec.feature "Friends", type: :feature do
  let(:friends) { build(:friend) }
  let(:random_user) { FactoryBot.create(:random_user) }

  def fill_in_signin_fields
    visit (new_user_session_path)

    fill_in "Email", with: random_user.email
    fill_in "Password", with: random_user.password
    click_button "Log in"
  end

  context "log in before creating a friend" do
    let(:friends) { build(:friend) }
    scenario "creating a friend before login" do
      visit new_friend_path
      expect(page).to have_content("Log in")
    end
  end
  context "without login lookin for a friend" do
    let(:friends) { build(:friend) }
    scenario "checking for friends before login" do
      visit friends_path
      expect(page).to have_content("Hello World")
    end
  end

  context "create new friend" do
    let(:friends) { build(:friend) }
    let(:random_user) { FactoryBot.create(:random_user) }

    def fill_in_signin_fields
      visit (new_user_session_path)

      fill_in "Email", with: random_user.email
      fill_in "Password", with: random_user.password
      click_button "Log in"
    end

    before(:each) do
      fill_in_signin_fields
    end
    scenario "Creating a new friend" do
      visit new_friend_path
      within("form") do
        fill_in "First Name", with: friends.first_name
        fill_in "Last Name", with: friends.last_name
        fill_in "Email", with: friends.email
        fill_in "Phone", with: friends.phone
        fill_in "Twitter", with: friends.twitter
      end
      click_button "Create Friend"
      expect(page).to have_content(friends.first_name)
    end
  end

  context "checking for all friends" do
    let(:random_user) { FactoryBot.create(:random_user) }

    # def fill_in_signin_fields
    #   visit (new_user_session_path)

    #   fill_in "Email", with: random_user.email
    #   fill_in "Password", with: random_user.password
    #   click_button "Log in"
    # end

    before(:each) do
      fill_in_signin_fields
    end
    scenario "Checking for friends" do
      visit friends_path
      expect(page).to have_content("Name")
    end
  end

  context "Destroy a friend" do
    let(:friend) { build(:friend) }
    before(:each) do
      fill_in_signin_fields
    end
    scenario "friend deleted" do
      puts friend.first_name
      visit new_friend_path
      within("form") do
        fill_in "First Name", with: friend.first_name
        fill_in "Last Name", with: friend.last_name
        fill_in "Email", with: friend.email
        fill_in "Phone", with: friend.phone
        fill_in "Twitter", with: friend.twitter
      end
      click_button "Create Friend"
      expect(page).to have_content(friend.first_name)

      click_button "Destroy this friend"
      expect(page).to have_content("Friend was successfully destroyed.")
    end
  end
end
