class Comment < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :commentable, polymorphic: true
end
