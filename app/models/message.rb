class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :content
  validates_length_of :content, maximum: 255

  def self.feed_for_user(user, page = nil)
    where(user_id: user.following_ids).page(page)
  end
end
