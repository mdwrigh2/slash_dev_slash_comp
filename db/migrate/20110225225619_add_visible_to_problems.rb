class AddVisibleToProblems < ActiveRecord::Migration
  def self.up
    change_table :problems do |t|
      t.boolean :visible, :default => false
    end
    Problem.update_all ["visible = ?", false]
  end

  def self.down
  end
end
