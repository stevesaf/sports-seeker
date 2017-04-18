class User < ActiveRecord::Base
  has_many(:user1, :class_name => 'Friend', :foreign_key => 'user1_id')

  has_many(:user2, :class_name => 'Friend', :foreign_key => 'user2_id')

  has_many(:histories, dependent: :destroy)
  has_many(:events, through: :histories)

  has_many(:pendings, dependent: :destroy)
  has_many(:events, through: :pendings)

end
