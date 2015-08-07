# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  card_id    :integer
#  done?      :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
