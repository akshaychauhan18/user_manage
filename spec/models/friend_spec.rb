require "rails_helper"

RSpec.describe Friend, type: :model do
  let(:friend) { create(:friend) }

  describe "schema" do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:phone).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:twitter).of_type(:string) }
  end

  describe "validations" do
    it { expect(friend).to allow_value(Faker::Internet.email).for(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:twitter) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).scoped_to(:user_id).case_insensitive }
    it { should validate_uniqueness_of(:phone).scoped_to(:user_id).case_insensitive }
    it { should validate_uniqueness_of(:twitter).scoped_to(:user_id).case_insensitive }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "database column created" do
    it "checks the count of friends" do
      expect { friend.friend_create }.to change { Friend.count }.by(1)
    end

    it "fails to save friends when nil" do
      friend = build(:friend, :no_twitter)
      expect { friend.friend_create }.to change { Friend.count }.by(0)
    end
  end

  describe "database column updates " do
    it "checks the value is updating" do
      expect(friend.friend_update({ first_name: "changed" })).to eq(true)
    end

    it "checks the value if not updating" do
      expect(friend.friend_update({ first_name: nil })).to eq(false)
    end
  end

  describe "database column destroyed " do
    it "checks the value is deleted" do
      expect { friend.friend_delete }.to change { Friend.count }.by(0)
    end
  end

  describe "checking for database whether values are same " do
    it "checks the value is present" do
      expect(friend).to have_attributes(:first_name => friend.first_name, :last_name => friend.last_name, :email => friend.email, :phone => friend.phone, :twitter => friend.twitter)
    end

    it "checks for the different values" do
      expect(friend).not_to have_attributes(:twitter => "twitter")
    end
  end
end
