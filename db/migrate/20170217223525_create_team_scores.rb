class CreateTeamScores < ActiveRecord::Migration
  def change
    create_table :team_scores do |t|
      t.string :map
      t.integer :mode
      t.bigint :player_ids, array: true
      t.integer :time
      t.integer :api_id

      t.timestamps null: false
    end
  end
end
