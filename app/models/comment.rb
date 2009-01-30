class Comment < ActiveRecord::Base
  belongs_to :post

                    
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :body

  def self.post
    Comment.find_by_post_id(self.post_id)
  end

  
end
