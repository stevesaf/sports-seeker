class CreateTables < ActiveRecord::Migration
  def change

    create_table(:categories) do |t|
      t.column(:name,:string)
      t.timestamps()
    end

    create_table(:events) do |t|
      t.column(:name,:string)
      t.column(:date,:datetime)
      t.column(:location,:string)
      t.column(:capacity,:integer)
      t.column(:description,:string)
      t.column(:image_url,:string)
      t.column(:video_url,:string)
      t.timestamps()
    end

    create_table(:suppliers) do |t|
      t.column(:name,:string)
      t.column(:expertise,:string)
      t.column(:rating,:integer)
      t.column(:cost_per_person,:integer)
      t.column(:description,:string)
      t.column(:logo_url,:string)
      t.timestamps()
    end

    create_table(:users) do |t|
      t.column(:name,:string)
      t.column(:username,:string)
      t.column(:rating,:integer)
      t.column(:gender,:string)
      t.column(:image_url,:string)
      t.column(:dob,:date)
      t.timestamps()

    end

    create_table(:event_suppliers) do |t|
      t.column(:event_id,:integer)
      t.column(:supplier_id,:integer)
      t.timestamps()
    end

    create_table(:category_suppliers) do |t|
      t.column(:category_id,:integer)
      t.column(:supplier_id,:integer)
      t.timestamps()
    end

    create_table(:category_events) do |t|
      t.column(:category_id,:integer)
      t.column(:event_id,:integer)
      t.timestamps()
    end

    create_table(:pendings) do |t|
      t.column(:event_id,:integer)
      t.column(:user_id,:integer)
      t.timestamps()
    end

    create_table(:histories) do |t|
      t.column(:event_id,:integer)
      t.column(:user_id,:integer)
      t.timestamps()
    end

    create_table(:friends) do |t|
      t.column(:user1,:integer)
      t.column(:user2,:integer)
      t.timestamps()
    end

  end
end
