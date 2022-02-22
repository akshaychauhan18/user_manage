class Friend < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :phone, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :twitter, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  belongs_to :user

  def friend_delete()
    if self.present?
      self.destroy
    else
      return false
    end
    true
  end

  def friend_update(params)
    self.update(params)
  end

  def friend_create
    self.save
  end
end
