class CreateProblemAttempts < ActiveRecord::Migration
  def self.up
    create_table :problem_attempts do |t|
      t.string :status
      t.string :file_hash
      t.references :problem
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_attempts
  end
end
