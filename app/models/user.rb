require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt
  
  validates_presence_of :name, :email, :password, :password_confirmation
  validates_confirmation_of :password, :message => 'passwords do not match'
  # Remember to create a migration!
  
  # Remember to create a migration!
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by_email(params[:email])
    if user
      user.password == params[:password]
    else
      false
    end
  end
end
