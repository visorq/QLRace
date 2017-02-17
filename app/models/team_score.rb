# == Schema Information
#
# Table name: team_scores
#
#  id         :integer          not null, primary key
#  map        :string
#  mode       :integer
#  player_ids :bigint           is an Array
#  time       :integer
#  api_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeamScore < ActiveRecord::Base
end
