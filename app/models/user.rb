class User < ActiveRecord::Base
  include BCrypt

  has_many :tweets

  validates_uniqueness_of :email
  validates_presence_of :name, :email, :password, :password_confirmation
  validates_confirmation_of :password, :message => 'passwords do not match'
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }# , :message => "Email is invalid."
  
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
