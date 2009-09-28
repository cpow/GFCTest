class AddEmailToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :email, :text
  end

  def self.down
    remove_column :comments, :email
  end
end
