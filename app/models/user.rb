class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :username, :email, :password

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :username, format: { with: /\A[a-z0-9_-]{3,20}\z/i }

  has_many :messages
  has_many :follow_relationships,   class_name: 'Follow', foreign_key: 'follower_id',
                                                          dependent: :destroy
  has_many :followed_relationships, class_name: 'Follow', foreign_key: 'follower_id',
                                                          dependent: :destroy
  has_many :followers, through: :followed_relationships 
  has_many :following, through: :follow_relationships, source: :followed

  scope :excluding_user, ->(user) { where.not(id: user.id) }

  def following?(user)
    following.include?(user)
  end

  def follow(user)
    return false if self == user
    follow_relationships.find_or_create_by(followed_id: user.id)
  end

  def unfollow(user)
    relation = followed_relationships.find_by(followed_id: user.id)
    relation ? relation.destroy : false
  end

  def to_param
    username
  end
end
