class PostsController < ApplicationController
  layout "application", :except => [:feed]
  
  def index
    @post = Post.sort_by_created_at.first
    @comment = @post.comments.new
    
    @next = Post.next_date(@post)
    @prev = Post.prev_date(@post)
  end

  def about
  end
  
  def gettr
    if admin?
       @flickr ||= Fleakr.api_key = 'fb5cf2883adb61c3978689f570542433'
       @user ||= Fleakr.user('info@micahrich.com')
       @photos ||= @user.sets.last.photos

       @photos.each do |photo|
         @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
         unless @post.updated_at == photo.updated_at
           @post.update_attributes!(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
         end
       end
      redirect_to blog_root_path
    else
      redirect_to login_path
    end
  end
  
  def archive
    # @posts = Post.paginate :page => params[:page], :order => 'created_at DESC'
    @posts = Post.find :all, :order => 'created_at DESC'
  end
  
  def feed
    @posts = Post.find_desc(:limit => 10)
  end
  
  def image_feed
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
