class AddVotesCountToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :votes_count, :integer, default: 0
  end
end
