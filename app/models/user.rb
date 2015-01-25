class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :username, :email, :password

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :username, format: { with: /\A[a-z0-9_-]{3,15}\z/i }
end
