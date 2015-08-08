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
  
  validates :title, presence: true
  validates :author, presence: true



end
