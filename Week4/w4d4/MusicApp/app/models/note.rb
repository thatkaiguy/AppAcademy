# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Note < ActiveRecord::Base
  validates :user_id, :track_id, :body, presence: true
  validates :user_id, uniqueness: { scope: :track_id }

  belongs_to :user
  belongs_to :track
end
