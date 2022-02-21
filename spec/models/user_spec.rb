require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build(:random_user) }
  describe "schema" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
  end

  describe "validations" do
    it { expect(user).to allow_value(Faker::Internet.email).for(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it "should not take invalid emails" do
      expect(user).to_not allow_value("something").for(:email)
      expect(user.errors.full_messages.to_sentence).to eq("Email is invalid")
      expect(user.errors.count).to eq(1)
    end
  end

  it "is database authenticable" do
    user = User.create(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123",
    )
    expect(user.valid_password?("password123")).to be_truthy
  end

  describe "user registration" do
    it "name, email, password and password_You can register if confirmation exists" do
      user = build(:random_user)
      expect(user).to be_valid
    end
  end

  describe "associations" do
    it { should have_many(:friends) }
  end
end
