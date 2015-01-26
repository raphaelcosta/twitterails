class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :content
  validates_length_of :content, maximum: 255

  def self.feed_for_user(user, page = nil)
    messages = arel_table
    following = messages[:user_id].in(user.following_ids)
    self_messages = messages[:user_id].eq(user.id)
    where(following.or(self_messages)).page(page)
  end
end
