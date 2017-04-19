DB = PG.connect({:dbname => "projectx_development"})

class User < ActiveRecord::Base
  has_many(:user1, :class_name => 'Friend', :foreign_key => 'user1_id')

  has_many(:user2, :class_name => 'Friend', :foreign_key => 'user2_id')

  has_many(:event_users, dependent: :destroy)
  has_many(:attendee, :class_name => 'EventUser', :foreign_key => 'attendee_id')
  has_many(:sender, :class_name => 'EventUser', :foreign_key => 'sender_id')
  has_many(:events, through: :event_users)

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

  def find_events()
    user2_list = DB.exec("SELECT friends.user2_id FROM friends WHERE user1_id = #{self.id}")
    user1_list = DB.exec("SELECT friends.user1_id FROM friends WHERE user2_id = #{self.id}")
    id2 = user2_list.map {|friend| friend['user2_id']}
    id1 = user1_list.map {|friend| friend['user1_id']}
    id2.concat(id1).map do |id|
      User.find(id)
    end
  end

end
