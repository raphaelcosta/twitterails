class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :username, :email, :password
end
