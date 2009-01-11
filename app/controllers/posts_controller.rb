class PostsController < ApplicationController
  layout "application", :except => [:feed]
  
  def index
    @post = Post.blog_find.first
    @next = Post.next(@post)
    @prev = Post.prev(@post)
  end

  def about
  end
  
  def archive
    @posts = Post.blog_find
  end
  
  def feed
    @posts = Post.blog_find(:limit => 10)
  end
  
  def show
    @post = Post.find(params[:id])
    @next = Post.next(@post)
    @prev = Post.prev(@post)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

end
