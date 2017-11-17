class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
      register Sinatra::Reloader
  end

  $posts = [{
      id: 0,
      title: "Post 0",
      body: "This is the first post"
  },
  {
      id: 1,
      title: "Post 1",
      body: "This is the second post"
  },
  {
      id: 2,
      title: "Post 2",
      body: "This is the third post"
  }];

  get '/' do

    @title = "Blog posts"

    # @posts = $posts commenting this out as have connected database in post.rb
    @posts = Post.all

    erb :'posts/index'

  end

  get '/new'  do

    @post = Post.new
    erb :'posts/new'

  end

  get '/:id' do

    # get the ID and turn it in to an integer
    id = params[:id].to_i

    # make a single post object available in the template
    # @post = $posts[id]
    @post = Post.find(id)

    erb :'posts/show'

  end

  post '/' do

    post = Post.new
    post.title = params[:title]
    post.body = params[:body]
    post.save
    # new_post = { ------dont need this anymore
    #   id: $posts.length,
    #   title: params[:title],
    #   body: params[:body]
    # }
    # $posts.push(new_post)
    redirect "/"

  end

#edit put
  put '/:id'  do
    id = params[:id].to_i
    #making var of current post info before user changes it
    # post = $posts[id]
    post = Post.find(id)
    #manipulate the var to be the new data
    post.title = params[:title]
    post.body = params[:body]
    # change the original data to be the new data
    # $posts[id] = post
    post.save
    redirect '/'
  end

  delete '/:id'  do
    id = params[:id].to_i
    Post.destroy(id)
    redirect "/"
  end

  get '/:id/edit'  do

    id = params[:id].to_i
    # @post = $posts[id]
    @post = Post.find(id)

    erb :'posts/edit'

  end

end
