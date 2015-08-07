# == Schema Information
#
# Table name: board_members
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  board_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BoardMember < ActiveRecord::Base
end
