require("bundler/setup")
  Bundler.require(:default)
  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
  also_reload("lib/*.rb")

get("/") do
  erb(:index)
end

get("/home") do
  erb(:home)
end

get("/admin") do
  erb(:admin)
end

get("/users") do
  erb(:users)
end

get("/user") do
  username = params.fetch('username')
  id = params.fetch('id').to_i
  redirect("/home/#{id}")
end

post("/user") do
  username = params.fetch('username')
  id = params.fetch('id').to_i
  redirect("/home/#{id}")
end

get("/home/:id") do
  @events = Event.all()
  erb(:home)
end
