class RemoveUnserIdFromComment < ActiveRecord::Migration
  def self.up
    remove_column :comments, :unser_id
  end

  def self.down
    add_column :comments, :unser_id, :integer
  end
end
