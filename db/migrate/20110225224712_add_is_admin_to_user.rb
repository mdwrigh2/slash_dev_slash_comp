class AddIsAdminToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :is_admin, :default => false
    end
    User.update_all ["is_admin = ?", false]
  end

  def self.down
    remove_column :users, :is_admin
  end
end
