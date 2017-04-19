class Category < ActiveRecord::Base
  has_many(:category_events, dependent: :destroy)
  has_many(:events, through: :category_events)

  has_many(:category_suppliers, dependent: :destroy)
  has_many(:suppliers, through: :category_suppliers)

  def self.search_event(categories,name_events)
    category_events = categories.map {|category| category.events}
    name_events = name_events.map{|event| [event]}
    result = name_events.concat(category_events)
    result.delete([])
    result.uniq{|obj| obj.first.id}
  end
end
