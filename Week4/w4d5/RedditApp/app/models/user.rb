# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :subs
  has_many :posts
  has_many(
    :comments,
    class_name: :Comment,
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )

  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_creds(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
    # don't need to save because you don't save until the user is saved
    # self.save!
  end
end
