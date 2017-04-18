class Category < ActiveRecord::Base
  has_many(:category_events, dependent: :destroy)
  has_many(:events, through: :category_events)

  has_many(:category_suppliers, dependent: :destroy)
  has_many(:suppliers, through: :category_suppliers)

end
