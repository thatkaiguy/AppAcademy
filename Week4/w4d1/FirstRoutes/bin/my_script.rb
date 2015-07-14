require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: {name: "Gizmo2"} }
  )
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json'
  ).to_s

  puts RestClient.put(
    url,
    { user: { name: "Gizmo2", email: "gizmo2@gizmo2.gizmo2" } }
  )
end

def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/1"
  ).to_s

  puts RestClient.delete(url)
end

destroy_user

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users'
# ).to_s
#
# puts RestClient.get(url)
