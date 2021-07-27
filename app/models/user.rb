class User < ActiveRecord::Base
  has_secure_password
  before_validation { self.email = self&.email&.downcase }
  validates :password, :password_confirmation, presence: true, length: { minimum: 8 }
  validates :email, uniqueness: true, case_sensitive: false
  validates :name, presence: true
  validates :email, presence: true


  def self.authenticate_with_credentials email, password
    if User.find_by(email: email.downcase.strip) && User.find_by(email: email.downcase.strip).authenticate(password)
      User.find_by(email: email.downcase.strip)
    else
      nil
    end
  end

end
