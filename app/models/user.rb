class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email, :username

  has_many :ideas

  has_many :votes, dependent: :destroy
  has_many :upvoted_ideas, through: :votes, source: :idea

  def admin?
    is_admin
  end



end
