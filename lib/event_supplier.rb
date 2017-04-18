class EventSupplier < ActiveRecord::Base
  belongs_to(:event)
  belongs_to(:supplier)

end
