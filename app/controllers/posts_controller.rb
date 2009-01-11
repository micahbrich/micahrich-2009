class PostsController < ApplicationController
  def index
    @post = Post.blog_find.first
    @next = Post.next(@post)
    @prev = Post.prev(@post)
  end

  def archive
    @posts = Post.blog_find
  end
  
  def fetchr
    @set.photos.each do |photo|
      @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
    end
    redirect_to posts_path
  end
  
  def gettr
    @photos = @set.photos.reverse
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
