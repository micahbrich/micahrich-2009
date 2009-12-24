task :cron => :environment do
  puts "About to fetch from Flickr!"
  if Post.fetch!
    puts "Flickr fetched!"
  else
    puts "Didn't fetch! Flickr fetching error!"
  end
end