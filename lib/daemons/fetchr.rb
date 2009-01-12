#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment.rb"
APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/app_info.yml")
FLICKR_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/flickr.yml")
require 'fleakr'

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do  
  
  Fleakr.api_key = FLICKR_CONFIG['api_key']
  @user = Fleakr.user('info@micahrich.com')
  @user.sets.each do |set|
    if set.title == FLICKR_CONFIG['photoset']
      set.photos.each do |photo|
        @post = Post.find_or_create_by_url(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
         unless @post.updated_at == photo.updated_at
           @post.update_attributes!(:url => photo.url, :title => photo.title, :description => photo.description, :created_at => photo.posted_at, :updated_at => photo.updated_at, :image => photo.large.url, :thumb => photo.small.url, :flickr_id => photo.id )
         end
      end
    end
  end
 
  sleep 7200
end