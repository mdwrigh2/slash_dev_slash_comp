class Problem < ActiveRecord::Base
  validates :title, :presence => true,
                    :length   => {:minimum => 4},
                    :uniqueness => true
  validates :description, :presence => true
  validates :example, :presence => true
  has_many :problem_attempts
  has_many :users, :through => :problem_attempts
end
