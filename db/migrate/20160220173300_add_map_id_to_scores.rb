class AddMapIdToScores < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    add_column :scores, :map_id, :integer
    add_column :world_records, :map_id, :integer

    Score.transaction do
      Score.all.each do |score|
        map_id = Map.find_by(name: score.map).id
        score.update_column('map_id', map_id)
      end
    end

    WorldRecord.transaction do
      WorldRecord.all.each do |wr|
        map_id = Map.find_by(name: wr.map).id
        wr.update_column('map_id', map_id)
      end
    end
  ensure
    ActiveRecord::Base.record_timestamps = true
  end
end
