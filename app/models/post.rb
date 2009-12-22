class Post < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  
  named_scope :sort_by_created_at, :order => 'created_at DESC'
  named_scope :prev, lambda { |p| {:conditions => ["id < ?", p.id], :limit => 1, :order => "id DESC"} }
  named_scope :next, lambda { |p| {:conditions => ["id > ?", p.id], :limit => 1, :order => "id"} }
  
  
  named_scope :prev_date, lambda { |p| {:conditions => ["created_at < ?", p.created_at], :limit => 1, :order => "created_at DESC"} }
  named_scope :next_date, lambda { |p| {:conditions => ["created_at > ?", p.created_at], :limit => 1, :order => "created_at"} }

  attr_accessible :id, :title, :description, :url, :image, :thumb, :created_at, :updated_at, :flickr_id
  
  def self.per_page
    30
  end
  
  def chars
    self.description.length
  end
  
  def full_url
    "http://www.micahrich.com/blog/posts/#{self.id}"
  end
  
  def fetch
       @flickr ||= Fleakr.api_key = 'fb5cf2883adb61c3978689f570542433'
        @user ||= Fleakr.user('info@micahrich.com')
        @photos ||= @user.sets.last.photos

        @photos.each do |photo|
          @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
          unless @post.updated_at == photo.updated_at
            @post.update_attributes!(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
          end
        end

    logger.info 'Flickr photos fetched!'
  end

end
