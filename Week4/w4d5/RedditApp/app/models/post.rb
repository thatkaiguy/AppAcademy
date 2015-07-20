# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable

  validates :subs, presence: true, length: { minimum: 1 }
  validates :author, presence: true
  validates :title, presence: true

  def has_sub?(other_sub)
    self.subs.any? { |sub| sub.id == other_sub.id }
  end

  def comments_by_parent_id
    hash = Hash.new{ |h, k| h[k] = [] }
    comments.each do |comment|
      hash[comment.parent_comment_id] << comment
    end
    hash
  end

end
