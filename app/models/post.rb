class Post < ActiveRecord::Base
  named_scope :blog_find, :order => 'created_at DESC'
  named_scope :prev, lambda { |p| {:conditions => ["id < ?", p.id], :limit => 1, :order => "id DESC"} }
  named_scope :next, lambda { |p| {:conditions => ["id > ?", p.id], :limit => 1, :order => "id"} }
  

  attr_accessible :id, :title, :description, :url, :image, :thumb, :created_at, :updated_at, :flickr_id
  
  
end
