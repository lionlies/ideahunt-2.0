class Idea < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :votes, dependent: :destroy



  def editable_by?(user)
    user && user == owner
  end
end
