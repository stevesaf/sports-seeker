require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload("lib/*.rb")
require('pry')

configure do
  enable :sessions
end

before do
  if params[:username] == nil
   if session[:user_id] === nil && url != "http://localhost:4567/"
     redirect("/")
    end
    if @user != nil then @user = User.find(session[:user_id])
    end
  end
end

get("/") do
  erb(:index)
end

get('/logout') do
  session.clear
  redirect to ('/')
end

get('/profile') do
  @user = User.find(session[:user_id])
  erb(:profile)
end

post("/user") do
  username = params.fetch('username')
  user = User.find_by username: username
  if user == nil
    flash[:error] = "User does not exist."
  else
    session[:user_id] = user.id
    session[:username] = user.username
    redirect("/home")
  end
end

post("/signup") do
  username = params.fetch('username')
  name = params.fetch('name')
  gender = params.fetch('gender')
  image_url = params.fetch('image_url')
  dob = params.fetch('dob')
  new_user = User.create({:username => username, :name => name, :gender => gender, :image_url => image_url, :dob => dob})
  session[:user_id] = new_user.id
  session[:username] = user.username
  redirect("/home")
end

get("/home") do
  @session = session[:user_id]
  @user = User.find(session[:user_id])
  @friends = @user.find_friends()
  @events = Event.all()
  @invitations = EventUser.where(:attendee => @user, :accepted => nil)
  erb(:home)
end

patch("/accept/:id") do
  event_user_id = params.fetch('id')
  event_user = EventUser.find(event_user_id)
  event_user.update({:accepted => true})
  redirect("/home")
end

patch("/reject/:id") do
  event_user_id = params.fetch('id')
  event_user = EventUser.find(event_user_id)
  event_user.update({:accepted => false})
  redirect("/home")
end

post("/event") do
  user_id = params.fetch('user_id')
  name = params.fetch("name")
  date = params.fetch("date")
  location = params.fetch("location")
  capacity = params.fetch("capacity")
  description = params.fetch("description")
  image_url = params.fetch("image_url")
  video_url = params.fetch("video_url")
  event = Event.create({:name => name, :date => date , :location => location, :capacity => capacity, :description=>description, :image_url=>image_url, :video_url=>video_url, :user_id=>user_id})
  redirect("/event/#{event.id}")
end

get("/event/:id") do
  @event = Event.find(params.fetch("id").to_i)
  @categories = Category.all()
  @pending = EventUser.where(:event => @event, :accepted => nil)
  @declined = EventUser.where(:event => @event, :accepted => false)
  @accepted = EventUser.where(:event => @event, :accepted => true)
  t = @event.date
  @date = t.strftime("%d-%b-%Y")
  @user = User.find(session[:user_id])
  @friends = @user.find_friends()
  erb(:event)
end

  post('/join') do
    me = User.find(session[:user_id])
    event = Event.find(Integer(params.fetch('event_id')))
    EventUser.where(:attendee_id => session[:user_id], :event_id => event.id).first_or_create(:event => event, :attendee => me, :accepted => true)
    redirect("/event/#{event.id}")
  end

post("/event_user/:id") do
  me = User.find(session[:user_id])
  friend = User.find(Integer(params.fetch('friend_id')))
  event = Event.find(Integer(params.fetch('id')))
  EventUser.create({:event => event, :attendee => friend, :sender => me})
  redirect("/event/#{event.id}")
end

patch("/event/:id") do
  event_id = params.fetch('id').to_i
  name = params.fetch("name")
  date = params.fetch("date")
  location = params.fetch("location")
  capacity = params.fetch("capacity")
  description = params.fetch("description")
  image_url = params.fetch("image_url")
  video_url = params.fetch("video_url")
  @event = Event.find(params.fetch("id").to_i())
  @event.update({:name => name, :date => date, :location => location, :capacity => capacity, :description => description, :image_url => image_url, :video_url => video_url})
  redirect("/event/#{event_id}")
end

delete("/event/:id") do
  @event = Event.find(params.fetch("id").to_i())
  @event.destroy()
  redirect("/home")
end

patch ("/add_categories/:id") do
  event = Event.find(params.fetch("id").to_i())
  category_ids = params.fetch('category_ids')
  event.add_category(category_ids)
  redirect("/event/#{event.id}")
end

get('/search') do
  @user = User.find(session[:user_id])
  @keyword = params.fetch('keyword').downcase
  @possible_users = User.where("lower(name) LIKE ? OR lower(username) LIKE?", "%#{@keyword}%", "%#{@keyword}%")
  @possible_events = Event.where("lower(name) LIKE ?", "%#{@keyword}%")
  @possible_categories = Category.where("lower(name) LIKE ?", "%#{@keyword}%")
  @event_results = Category.search_event(@possible_categories,@possible_events)
  erb(:search_result)
end

get('/user/:id') do
  id = Integer(params.fetch('id'))
  @user = User.find(id)
  erb(:user)
end

post('/add_friend/:id') do
  friend_id = Integer(params.fetch('id'))
  my_id = session[:user_id]
  me = User.find(my_id)
  friend = User.find(friend_id)
  Friend.add_friend(me, friend)
  redirect to ("/home")
end


get("/admin") do
  if session[:user_id] != 1
    redirect("/home")
  end
  @suppliers = Supplier.all()
  @categories = Category.all()
  erb(:admin)
end

post("/category") do
  name = params.fetch("name")
  Category.create({:name => name})
  redirect('/admin')
end

patch("/category/:id") do
  category_id = params.fetch('id').to_i
  name = params.fetch("name")
  @category = Category.find(params.fetch("id").to_i())
  @category.update({:name => name})
  redirect("/admin")
end

delete("/category/:id") do
  id = params.fetch('id').to_i
  @category = Category.find(params.fetch("id").to_i())
  @category.delete()
  redirect("/admin")
end

post("/supplier") do
  name = params.fetch("name")
  expertise = params.fetch("expertise")
  cost_per_person = params.fetch("cost_per_person")
  description = params.fetch("description")
  logo_url = params.fetch("logo_url")
  Supplier.create({:name => name, :expertise => expertise, :cost_per_person => cost_per_person, :description => description, :logo_url => logo_url})
  redirect('/admin')
end

get("/supplier/:id") do
  id = params.fetch('id').to_i
  @supplier = Supplier.find(id)
  @categories = Category.all()
  erb(:supplier)
end

patch("/suppliers/:id") do
  supplier_id = params.fetch('id').to_i
  name = params.fetch("name")
  expertise = params.fetch("expertise")
  cost_per_person = params.fetch("cost_per_person")
  description = params.fetch("description")
  logo_url = params.fetch("logo_url")
  @supplier = Supplier.find(params.fetch("id").to_i())
  @supplier.update({:name => name, :expertise => expertise, :cost_per_person => cost_per_person, :description => description, :logo_url => logo_url})
  redirect("/supplier/#{supplier_id}")
end

delete("/suppliers/:id") do
  @supplier = Supplier.find(params.fetch("id").to_i())
  @supplier.delete()
  redirect("/admin")
end

post("/category_suppliers") do
  supplier_id = params.fetch('id').to_i
  category_id = params.fetch('category_id').to_i
  CategorySupplier.create(:supplier_id => supplier_id,:category_id => category_id)
  redirect("/supplier/#{supplier_id}")
end

get("/users") do
  erb(:users)
end
