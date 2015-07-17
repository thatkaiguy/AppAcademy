# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  is_bonus   :boolean          default(FALSE), not null
#  name       :string(255)      not null
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  validates :album_id, :is_bonus, :name, presence: true

  belongs_to :album,
    foreign_key: :album_id,
    class_name: :Album

  has_many :notes,
    foreign_key: :track_id,
    class_name: :Note
end
