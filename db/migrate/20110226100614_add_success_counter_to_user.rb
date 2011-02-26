class AddSuccessCounterToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :successes, :default => 0
    end
    User.update_all ["successes = ?", 0]
  end

  def self.down
  end
end
