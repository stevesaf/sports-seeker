class User < ActiveRecord::Base
list = [
    [ "Admin", "Admin", "Female", "https://avatars2.githubusercontent.com/u/25296117?v=3&s=460", "04/04/1990"  ],
    [ "Julie", "Jooolie", "Female", "https://avatars2.githubusercontent.com/u/25296117?v=3&s=460", "04/04/1990"  ],
    [ "David", "dxsfung", "Male", "https://avatars2.githubusercontent.com/u/25076720?v=3&s=460", "04/04/1990"  ],
    [ "Brian", "brianlaw033", "Male", "https://avatars0.githubusercontent.com/u/25007087?v=3&s=460", "04/04/1990"  ],
    [ "Ken", "ken.ng1", "Male", "https://avatars0.githubusercontent.com/u/25297786?v=3&s=460", "04/04/1990"  ],
    [ "Kevin", "kevinch0", "Male", "https://avatars3.githubusercontent.com/u/25047528?v=3&s=460", "04/04/1990"  ],
    [ "Steve", "stevesaf", "Male", "https://avatars3.githubusercontent.com/u/25411585?v=3&s=460", "04/04/1990"  ]
  ]

  list.each do |name, username, gender, image_url, dob|
    User.create( name: name, username: username, gender: gender, image_url: image_url, dob: dob )
  end
end

class Event < ActiveRecord::Base
list = [
    [ "David's baby shower", "2017-04-18 00:00:00", "Central", "300", "New baby", "http://images.parents.mdpcdn.com/sites/parents.com/files/styles/width_300/public/images/p_101528432.jpg","" , "2"],
    [ "AHK Cohort 1 Graduation", "2017-05-27 00:00:00", "Wan Chai", "200", "Exciting event for everybody", "https://media.giphy.com/media/qLHzYjlA2FW8g/giphy.gif","https://www.youtube.com/embed/CVpdBCM6VjU" , "1"]
  ]

  list.each do |name, date, location, capacity, description, image_url, video_url, user_id|
    Event.create( name: name, date: date, location: location, capacity: capacity, description: description, image_url:image_url, video_url:video_url , user_id:user_id )
  end
end

class Supplier < ActiveRecord::Base
list = [
    [ "Partymania", "Entertainment", "100", "Catering for all kinds of parties", "https://s-media-cache-ak0.pinimg.com/736x/46/b4/fd/46b4fdb492e14eaf59c99fce682373b0.jpg" ]
  ]

  list.each do |name, expertise, cost_per_person, description, logo_url|
    Supplier.create( name: name, expertise: expertise, cost_per_person: cost_per_person, description: description, logo_url: logo_url )
  end
end

class Category < ActiveRecord::Base
list = [
    "Sports" , "Birthday" , "Music" , "Wedding", "Business" , "BBQ" , "Outdoor Adventure"
  ]

  list.each do |name|
    Category.create( name: name )
  end
end

class EventUser < ActiveRecord::Base
list = [
  [ "1", "4", "5", ],
  [ "1", "2", "5", "true" ],
  [ "1", "3", "5", "false" ]
]

  list.each do |event_id, attendee_id, sender_id, accepted|
    EventUser.create( event_id: event_id, attendee_id: attendee_id, sender_id: sender_id, accepted: accepted )
  end
end
