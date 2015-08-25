# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  has_many :lists,
  foreign_key: :board_id,
  class_name: :List,
  dependent: :destroy

  has_many :cards,
  through: :lists,
  source: :cards

  validates :title, presence: true
  validates :author, presence: true


end
