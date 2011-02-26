class AddFilenameToProblemAttempt < ActiveRecord::Migration
  def self.up
    change_table :problem_attempts do |t|
      t.string :filename
    end
  end

  def self.down
    remove_column :problem_attempts, :filename
  end
end
