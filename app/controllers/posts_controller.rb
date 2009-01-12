class PostsController < ApplicationController
  layout "application", :except => [:feed]
  
  def index
    @post = Post.find_desc.first
    @comment = @post.comments.new
    
    @next = Post.next(@post)
    @prev = Post.prev(@post)
  end

  def about
  end
  
  def gettr
    Fleakr.api_key = FLICKR_CONFIG['api_key']
    @user = Fleakr.user(FLICKR_CONFIG['user_email'])
    @user.sets.each do |set|
      if set.title == FLICKR_CONFIG['photoset']
        set.photos.each do |photo|
          @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
        end
      end
    end
    redirect_to archive_path
  end
  
  def archive
    @posts = Post.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def feed
    @posts = Post.find_desc(:limit => 10)
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    
    @next = Post.next(@post)
    @prev = Post.prev(@post)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  

end
