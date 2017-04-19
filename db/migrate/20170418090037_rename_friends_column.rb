class RenameFriendsColumn < ActiveRecord::Migration
  def change
    rename_column(:friends, :user1, :user1_id)
    rename_column(:friends, :user2, :user2_id)
  end
end
