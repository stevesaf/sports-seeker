class EventUser < ActiveRecord::Base
  belongs_to(:event)
  belongs_to(:attendee, :class_name => 'User')
  belongs_to(:sender, :class_name => 'User')
end
