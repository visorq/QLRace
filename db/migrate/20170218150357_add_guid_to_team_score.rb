class AddGuidToTeamScore < ActiveRecord::Migration
  def change
    add_column :team_scores, :match_guid, :uuid, null: false
  end
end
