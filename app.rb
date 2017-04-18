
require("bundler/setup")
  Bundler.require(:default)
  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
  also_reload("lib/*.rb")
  require('pry')

get("/") do
  erb(:index)
end

get("/user") do
  username = params.fetch('username')
  user = User.find_by username: username
  session[:user_id] = user.id
  redirect("/home/#{user.id}")
end

post("/signup") do
  username = params.fetch('username')
  name = params.fetch('name')
  gender = params.fetch('gender')
  image_url = params.fetch('image_url')
  dob = params.fetch('dob')
  new_user = User.create({:username => username, :name => name, :gender => gender, :image_url => image_url, :dob => dob})
  id = new_user.id
  redirect("/home/#{id}")
end

get("/home/:id") do
  session[:user_id]
  @user = User.find(params.fetch('id').to_i)
  @events = Event.all()
  erb(:home)
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
  erb(:event)
end

get('/search') do
  keyword = params.fetch('keyword')
  @possible_users = User.where("name LIKE ? OR username LIKE?", "%#{keyword}%", "%#{keyword}%")
  @possible_events = Event.where("name LIKE ?", "%#{keyword}%")
  erb(:search_result)
end

get('/user/:id') do
  id = Integer(params.fetch('id'))
  @user = User.find(id)
  erb(:user)
end

post('/add_friend/:id') do
  friend_id = Integer(params.fetch('id'))
  my_id = Integer(params.fetch('user_id'))
  me = User.find(my_id)
  friend = User.find(friend_id)
  Friend.create(:user1 => me, :user2 => friend)
  redirect to ("/home/#{my_id}")
end


get("/admin") do
  @suppliers = Supplier.all()
  @categories = Category.all()
  erb(:admin)
end

post("/category") do
  name = params.fetch("name")
  Category.create({:name => name})
  redirect('/admin')
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

post("/category_suppliers") do
  supplier_id = params.fetch('id').to_i
  category_id = params.fetch('category_id').to_i
  CategorySupplier.create(:supplier_id => supplier_id,:category_id => category_id)
  redirect("/supplier/#{supplier_id}")
end

get("/users") do
  erb(:users)
end
