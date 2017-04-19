class RemoveRatingFromUsers < ActiveRecord::Migration
  def change
    remove_column(:users, :rating)
    add_column(:event_users, :rating, :integer)
  end
end
