# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  belongs_to(
    :moderator,
    class_name: :User,
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many :post_subs

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

  validates :title, :description, presence: true
  validates :moderator, presence: true
end
