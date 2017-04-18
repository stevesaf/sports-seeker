class DropRating < ActiveRecord::Migration
  def change
    remove_column(:suppliers, :rating)
    add_column(:event_suppliers, :rating, :integer)
    add_column(:event_suppliers, :review, :string)
  end
end
