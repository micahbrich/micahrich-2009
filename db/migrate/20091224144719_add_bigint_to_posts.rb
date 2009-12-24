class AddBigintToPosts < ActiveRecord::Migration
  def self.up
    change_column :posts, :flickr_id, :integer, :limit => 8
  end

  def self.down
    change_column :posts, :flickr_id, :integer, :limit => 4
  end
end
