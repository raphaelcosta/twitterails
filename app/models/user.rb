class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :username, :email, :password

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :username, format: { with: /\A[a-z0-9_-]{3,25}\z/i }

  has_many :messages

  # Follows
  has_many :follow_relationships,   class_name: 'Follow', foreign_key: 'follower_id',
                                                          dependent: :destroy
  has_many :followed_relationships, class_name: 'Follow', foreign_key: 'follower_id',
                                                          dependent: :destroy
  has_many :followers, through: :followed_relationships 
  has_many :following, through: :follow_relationships, source: :followed

  # Blocks
  has_many :requested_blocks, class_name: 'Block', foreign_key: 'requester_id',
                                                          dependent: :destroy
  has_many :active_blocks,    class_name: 'Block', foreign_key: 'blocked_id',
                                                          dependent: :destroy

  has_many :blocked_by_users, through: :active_blocks, source: :requester
  has_many :blocked_users, through: :requested_blocks, source: :blocked

  scope :excluding_user, ->(user) { where.not(id: user.id) }

  def blocked?(user)
    blocked_users.include? user
  end

  def blocked_by?(user)
    blocked_by_users.include? user
  end

  def block(user)
    return false if self == user
    user.unfollow self
    requested_blocks.find_or_create_by(blocked_id: user.id)
  end

  def unblock(user)
    relation = requested_blocks.find_by(blocked_id: user.id)
    relation ? relation.destroy : false
  end

  def feed(page = nil)
    Message.feed_for_user(self, page)
  end

  def following?(user)
    following.include? user
  end

  def follow(user)
    return false if self == user || blocked_by?(user)
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
