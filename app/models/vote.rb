class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea, counter_cache: true
  validates_uniqueness_of :idea_id, scope: :user_id

end
