class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name

      t.timestamps null: false
    end

    Score.pluck(:map).uniq.each do |map|
      score = Score.order(:created_at).find_by(map: map)
      Map.create!(name: score.map, created_at: score.created_at,
                  updated_at: score.updated_at)
    end
  end
end
