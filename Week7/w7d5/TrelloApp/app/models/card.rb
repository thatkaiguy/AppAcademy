# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  title       :string
#  list_id     :integer
#  ord         :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Card < ActiveRecord::Base
end
