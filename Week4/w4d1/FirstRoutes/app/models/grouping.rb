class Grouping < ActiveRecord::Base
  validates :group_id, :contact_id, presence: true
  validates :group_id, uniqueness: { scope: :contact_id }

  belongs_to(
    :group,
    foreign_key: :group_id,
    primary_key: :id,
    class_name: :Group
  )

  belongs_to(
    :contact,
    foreign_key: :contact_id,
    primary_key: :id,
    class_name: :Contact
  )
end
