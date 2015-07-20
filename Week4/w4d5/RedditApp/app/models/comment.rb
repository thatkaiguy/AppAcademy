# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :child_comments,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id
  )

  belongs_to(
    :parent_comment,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    primary_key: :id
  )

  has_many :votes, as: :voteable

  belongs_to :post

  validates :content, presence: true
  validates :author, presence: true
  validates :post, presence: true
end
