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
  validates :map, :mode, :player_id, :time, presence: true
  validates_inclusion_of :mode, in: 0..3
  validates :player, presence: true
  validates :mode, uniqueness: { scope: :map,
                                 message: 'One record per mode for each map.' }

  def self.check(score)
    wr = WorldRecord.where(map: score[:map], mode: score[:mode]).first_or_initialize
    if wr.time.nil? || score[:time] < wr.time
      wr.time = score[:time]
      wr.player_id = score[:player_id]
      wr.match_guid = score[:match_guid]
      wr.api_id = score[:api_id]
      wr.updated_at = score[:date] if score[:date]
      wr.save
    end
  end

  def self.map_scores
    wrs = []
    (0..3).each do |mode|
      wrs << WorldRecord.where(mode: mode).order(:map).includes(:player)
    end
    map_scores = {}
    WorldRecord.distinct(:map).order(:map).pluck(:map).each do |map|
      scores = Array.new(3, {})
      (0..3).each do |mode|
        wr = wrs[mode].find_by(map: map)
        scores[mode] = { player_id: wr.player_id, name: wr.player.name,
                        time: wr.time } if wr
      end
      map_scores[map] = scores
    end
    map_scores
  end
end
