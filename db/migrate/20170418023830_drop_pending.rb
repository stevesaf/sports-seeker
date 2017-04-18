class DropPending < ActiveRecord::Migration
  def change
    drop_table(:pendings)

    rename_table(:histories, :event_users)

    rename_column(:event_users, :user_id, :attendee_id)
    add_column(:event_users, :sender_id, :integer)
    add_column(:event_users, :accepted, :boolean)

  end
end
