# frozen_string_literal: true
# == Schema Information
#
# Table name: world_records
#
#  id         :integer          not null, primary key
#  map        :string           not null
#  mode       :integer          not null
#  player_id  :bigint           not null
#  time       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_guid :uuid             not null
#  api_id     :integer
#

class WorldRecord < ActiveRecord::Base
  belongs_to :player
  validates :map, :mode, :player_id, :time, :player, presence: true
  validates :mode, inclusion: { in: 0..3 }
  validates :mode, uniqueness: { scope: :map,
                                 message: 'One record per mode for each map.' }
  validates :time, numericality: { only_integer: true,
                                   greater_than: 0 }

  def self.check(score)
    wr = world_record(score[:map], score[:mode])
    update_world_record(wr, score) if wr.time.nil? || score[:time] < wr.time
  end

  def self.map_scores
    map_scores = Hash.new { |hash, key| hash[key] = Array.new(4) }
    WorldRecord.order(:map).includes(:player).each do |world_record|
      map_scores[world_record.map][world_record.mode] = world_record
    end
    map_scores
  end

  def self.world_record(map, mode)
    WorldRecord.find_or_initialize_by(map: map, mode: mode)
  end

  def self.most_world_records(mode)
    where_mode = mode.to_i != -1 ? " AND mode = #{mode.to_i}" : ''
    query = <<-SQL
    SELECT wr.player_id, p.name, COUNT(wr.player_id) AS num_wrs
    FROM world_records wr, players p
    WHERE wr.player_id = p.id#{where_mode}
    GROUP BY p.name, wr.player_id
    ORDER BY num_wrs DESC
    SQL
    Score.find_by_sql [query]
  end

  def self.update_world_record(world_record, score)
    world_record.time = score[:time]
    world_record.player_id = score[:player_id]
    world_record.match_guid = score[:match_guid]
    world_record.api_id = score[:api_id]
    world_record.updated_at = score[:date] if score[:date]
    world_record.save!
  end

  private_class_method :update_world_record
end
