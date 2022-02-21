require "rails_helper"
require "devise"
RSpec.describe "Friends", type: :request do
  let (:friends) { build(:friend) }
  let(:current_user) { build(:random_user) }

  before :each do
    login_as current_user
  end

  context "checking friends controller" do
    it "check index controller" do
      get friends_path
      expect(response).to be_successful
    end

    it "check new friend" do
      get new_friend_path
      expect(response).to be_successful
    end

    it "check edit" do
      puts friends.inspect

      get edit_friend_path(friends)

      # expect(response).to be_successful
      expect(response).to have_http_status(302)
    end

    it "checks for the friend" do
      get friend_path(friends)
      expect(response).to be_successful
      # expect(response).to have_http_status(:success)
    end
  end
  describe "friend /destroy" do
    context "success" do
      it "deletes the user" do
        delete "/friends/#{friends.id}"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(friends_path)
      end
    end
  end
  describe "friend /update" do
    context "success" do
      it "updates the user" do
        friends.twitter = "akshay@hsd"
        patch "/friends/#{friends.id}"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(friends_path)
      end
    end
  end
end
