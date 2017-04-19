class Event < ActiveRecord::Base
  has_many(:category_events, dependent: :destroy)
  has_many(:categories, through: :category_events)

  has_many(:event_suppliers, dependent: :destroy)
  has_many(:suppliers, through: :event_suppliers)

  has_many(:event_users, dependent: :destroy)
  has_many(:users, through: :event_users)

  belongs_to(:user)

  def add_category(category_ids)
    category_ids.each do |id|
      category = Category.find(id)
      CategoryEvent.where(:event => self, :category => category).first_or_create({:event => self, :category => category})
    end
  end
end
