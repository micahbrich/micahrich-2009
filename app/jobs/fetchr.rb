#!/usr/local/bin/ruby

require 'fleakr'
class Fetchr < ActiveRecord::Base
  # This script fetches flickr photos


     @flickr ||= Fleakr.api_key = 'fb5cf2883adb61c3978689f570542433'
     @user ||= Fleakr.user('info@micahrich.com')
     
     @photos ||= @user.sets.first
     @photos.each do |photo|
       @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
       unless @post.updated_at == photo.updated_at
         @post.update_attributes!(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
       end
     end
  
  # the first idea
  # @user.sets.each do |set|
  #   if set.title == FLICKR_CONFIG['photoset']
  #     set.photos.each do |photo|
  #       @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
  #        unless @post.updated_at == photo.updated_at
  #          @post.update_attributes!(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
  #        end
  #     end
  #   end
  # end
  
  logger.info 'Flickr photos fetched!'
end