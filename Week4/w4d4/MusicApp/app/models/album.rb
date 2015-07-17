# == Schema Information
#
# Table name: albums
#
#  id                 :integer          not null, primary key
#  band_id            :integer          not null
#  title              :string(255)      not null
#  recording_location :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Album < ActiveRecord::Base
  validates :band_id, :title, :recording_location, presence: true

  belongs_to :band,
    foreign_key: :band_id,
    class_name: :Band

  has_many :tracks,
    foreign_key: :album_id,
    class_name: :Track,
    dependent: :destroy

end
