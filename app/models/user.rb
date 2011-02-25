require 'digest/sha1'
class User < ActiveRecord::Base
  validates :username, :presence => true,
                       :length => { :minimum => 4 },
                       :uniqueness => true,
                       :format => { :with => /[A-Za-z0-9_-]+/ }
  validates :hashed_password, :presence => true
  validates :email_address, :presence => true
  validates :password, :presence => true
  has_many :problem_attempts
  has_many :problems, :through => :problem_attempts

  attr_accessor :password
  attr_protected :id, :salt

  def self.authenticate(login, pass)
    user = User.where(["username = ?", login]).first
    return nil if user.nil?
    return user if User.encrypt(pass, user.salt) == user.hashed_password
    nil
  end

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) unless self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  protected

  def self.encrypt(pass,salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end


end
