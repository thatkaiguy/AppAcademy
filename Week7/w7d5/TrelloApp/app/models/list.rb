# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  title      :string
#  board_id   :integer
#  ord        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class List < ActiveRecord::Base
  belongs_to :board,
  foreign_key: :board_id,
  class_name: :Board
  
  validates :title, :ord, presence: true
  validates :board, presence: true


end
