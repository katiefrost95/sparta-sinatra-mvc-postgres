require 'sinatra'
require 'sinatra/reloader' if development?
#gem that allowed postrgres to run
require 'pg'
require_relative './models/post.rb'
require_relative './controllers/posts_controller.rb'

#Need to put this middlewear to enable us to put two methods in forms for edit/put and new/post
use Rack::MethodOverride
#gonna look for _method in the form and at method will swap to the put one

run PostsController
