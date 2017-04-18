require("bundler/setup")
  Bundler.require(:default)
  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
  also_reload("lib/*.rb")

get("/") do
  erb(:index)
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

get("/home") do
  erb(:home)
end

get("/admin") do
  erb(:admin)
end

get("/users") do
  @users = User.all()
  erb(:users)
end

get("/user") do
  username = params.fetch('username')
  current_user = User.find_by username: username
  id = current_user.id
  redirect("/home/#{id}")
end

get("/home/:id") do
  @events = Event.all()
  erb(:home)
end
