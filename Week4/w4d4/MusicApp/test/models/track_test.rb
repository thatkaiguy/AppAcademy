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

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
