DB = PG.connect({:dbname => "projectx_development"})

class User < ActiveRecord::Base
  has_many(:user1, :class_name => 'Friend', :foreign_key => 'user1_id')

  has_many(:user2, :class_name => 'Friend', :foreign_key => 'user2_id')

  has_many(:histories, dependent: :destroy)
  has_many(:events, through: :histories)

  has_many(:pendings, dependent: :destroy)
  has_many(:events, through: :pendings)

  has_many (:events)

  def find_friends()
    user2_list = DB.exec("SELECT friends.user2_id FROM friends WHERE user1_id = #{self.id}")
    user1_list = DB.exec("SELECT friends.user1_id FROM friends WHERE user2_id = #{self.id}")
    id2 = user2_list.map {|friend| friend['user2_id']}
    id1 = user1_list.map {|friend| friend['user1_id']}
    id2.concat(id1).map do |id|
      User.find(id)
    end
  end
end
