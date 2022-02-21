require "rails_helper"

RSpec.describe Friend, type: :model do
  let(:friend) { build(:friend) }

  describe "schema" do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:phone).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:twitter).of_type(:string) }
  end

  it "ensures name is present" do
    friend = build(:friend, first_name: nil)
    assert(friend.invalid?)
  end

  it "ensures first_name is present" do
    friend = build(:friend, first_name: nil)
    assert(friend.invalid?)
  end

  it "ensures last_name is present" do
    friend = build(:friend, last_name: nil)
    assert(friend.invalid?)
  end

  it "ensures email is present" do
    friend = build(:friend, email: nil)
    assert(friend.invalid?)
  end

  it "ensures phone is present" do
    friend = build(:friend, phone: nil)
    assert(friend.invalid?)
  end

  it "ensures twitter is present" do
    friend = build(:friend, twitter: nil)
    assert(friend.invalid?)
  end

  describe "validations" do
    it { expect(friend).to allow_value(Faker::Internet.email).for(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:twitter) }
    it { should validate_presence_of(:email) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end
