class Block < ActiveRecord::Base
  belongs_to :requester, class_name: 'User'
  belongs_to :blocked, class_name: 'User'
end
