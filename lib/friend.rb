class Friend < ActiveRecord::Base
  belongs_to(:user1, :class_name => 'User')
  belongs_to(:user2, :class_name => 'User')

  def self.add_friend(me, friend)
    scenario1 = Friend.where(:user1 => me, :user2 => friend)
    scenario2 = Friend.where(:user2 => me, :user1 => friend)
    if scenario1 == [] and scenario2 == []
      Friend.create({:user1 => me, :user2 => friend})
    end
  end
end
