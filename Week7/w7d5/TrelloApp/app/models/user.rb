# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  email         :string
#  pw_digest     :string
#  session_token :string
#  gravatar_url  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :email, :pw_digest, presence: true
  validates :password, length: { minimum: 6}, allow_nil: true

  has_many :created_boards,
  foreign_key: :user_id,
  class_name: :Board

  # has_many :board_memberships,
  # foreign_key: :user_id,
  # class_name: :BoardMember
  #
  # has_many :membership_boards,
  # through: :board_memberships,
  # source: :boards

  attr_reader :password

  def self.find_by_credentials(email, pw)
    user = User.find_by email: email
    user && user.is_password?(pw) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save
  end

  def password=(pw)
    @password = pw
    self.pw_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.pw_digest).is_password?(pw)
  end

end
