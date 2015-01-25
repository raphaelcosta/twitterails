class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :username, :email, :password

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :username, format: { with: /\A[a-z0-9_-]{3,20}\z/i }

  has_many :relationships, class_name: 'Follow', foreign_key: 'follower_id',
                                                 dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  def following?(user)
    following.include?(user)
  end

  def follow(user)
    relationships.find_or_create_by(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end
end
