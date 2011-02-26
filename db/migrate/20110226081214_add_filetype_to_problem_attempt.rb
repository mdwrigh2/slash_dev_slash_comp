class AddFiletypeToProblemAttempt < ActiveRecord::Migration
  def self.up
    change_table :problem_attempts do |t|
      t.string :filetype
    end
  end

  def self.down
    remove_column :problem_attempts, :filetype
  end
end
