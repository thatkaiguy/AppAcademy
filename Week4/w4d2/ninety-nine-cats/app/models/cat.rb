# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  VALID_COLORS = ["white", "black", "orange", "calico", "gray"]
  VALID_GENDERS = ['M','F']

  validates :name, :birth_date, presence: true
  validates :sex, presence: true, inclusion: { in: VALID_GENDERS }
  validates :color, inclusion: { in: VALID_COLORS }

  has_many(
    :rental_requests,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
  )

  def self.show_columns
    ["color", "birth_date", "sex", "description"]
  end

  def color_selected(other_color)
    color == other_color ? "selected" : ""
  end

  def gender_selected(gender)
    sex == gender ? "checked=\"checked\"" : ""
  end
end
