class Idea < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :votes, dependent: :destroy
  has_many :upvoted_users, through: :votes, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 200, too_long: "Only 200 characters allowed."}

  def editable_by?(user)
    user && user == owner
  end
end
