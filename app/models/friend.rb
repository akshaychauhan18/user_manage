class Friend < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :twitter, presence: true
  belongs_to :user

  scope :delete1, ->(id) {
          find(id).destroy
        }
end
