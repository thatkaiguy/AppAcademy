class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many(
    :contacts,
    dependent: :destroy,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Contact
  )

  has_many(
    :contact_shares,
    dependent: :destroy,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :ContactShare
  )

  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

  has_many(
    :groups,
    dependent: :destroy,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Group
  )

  has_many :comments, as: :commentable

  def favorite_contacts
    contacts.where(is_favorite: true) + contact_shares.where(is_favorite: true)
  end
end
