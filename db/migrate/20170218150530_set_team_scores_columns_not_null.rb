class SetTeamScoresColumnsNotNull < ActiveRecord::Migration
  def change
    change_column_null :team_scores, :map, false
    change_column_null :team_scores, :mode, false
    change_column_null :team_scores, :player_ids, false
    change_column_null :team_scores, :time, false
  end
end
