class ProblemAttempt < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  validates :status, :presence => true
  validates :file_hash, :presence => true

  def source_files=(source_data)
    if source_data.nil?
      return "No file attached"
    end
    if source_data.file_size > 20.megabytes
      return "File size too large"
    end

    self.file_hash = Digest::SHA1.hexdigest(source_data)
  end

      
end
