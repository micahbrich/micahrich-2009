class Comment < ActiveRecord::Base
  belongs_to :post

                    
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :body
  before_save :clean_url

  def self.post
    Comment.find_by_post_id(self.post_id)
  end

  def clean_url
    unless self.website.blank?
      unless self.website =~ /https?:\/\/.*/
         write_attribute :website, "http://" + self.website.to_s
      else
         write_attribute :website, self.website
      end
    end
  end
  
end
