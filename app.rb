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

get("/users") do
  erb(:users)
end

get("/user") do
  username = params.fetch('username')
  id = params.fetch('id').to_i
  redirect("/home/#{id}")
end

get("/home/:id") do
  @events = Event.all()
  erb(:home)
end
