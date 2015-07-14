class Group < ActiveRecord::Base
  validates :user_id, :group_name, presence: true

  belongs_to(
    :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
  )

  has_many(
    :groupings,
    foreign_key: :group_id,
    primary_key: :id,
    class_name: :Grouping
  )

  has_many(
    :contacts,
    through: :groupings,
    source: :contact
  )
end
