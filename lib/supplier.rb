class Supplier < ActiveRecord::Base
  has_many(:category_suppliers, dependent: :destroy)
  has_many(:categories, through: :category_suppliers)

  has_many(:event_suppliers, dependent: :destroy)
  has_many(:events, through: :event_suppliers)
end
