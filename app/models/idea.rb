class Idea < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :description, length: {maximum: 140, too_long: "Only 140 characters allowed."}

  def editable_by?(user)
    user && user == owner
  end
end
