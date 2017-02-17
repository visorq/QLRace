class AddIndexToTeamScore < ActiveRecord::Migration
  def change
    add_index :team_scores, [:map, :mode]
  end
end
