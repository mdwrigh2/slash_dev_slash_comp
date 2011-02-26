require 'digest/sha1'
class ProblemAttempt < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  validates :status, :presence => true
  validates :file_hash, :presence => true
  validates :user_id, :presence => true
  validates :problem_id, :presence => true

  def create_files(source_data,filename)
    if source_data.nil?
      return "No file attached"
    end
    if source_data.size > 20.megabytes
      return "File size too large"
    end

    self.filename = filename
    file_location = "#{RAILS_ROOT}/public/upload/#{filename}"
    output = File.new(file_location, "wb")
    output.write(source_data.read)
    output.close
    self.file_hash = Digest::SHA1.hexdigest(source_data.read)
    self.status = "Waiting"
    return nil
  end

      
end
