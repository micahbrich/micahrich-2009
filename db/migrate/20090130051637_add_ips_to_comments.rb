class AddIpsToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :email_address, :string
  
  end

  def self.down
    remove_column :comments, :email_address
  end
end
