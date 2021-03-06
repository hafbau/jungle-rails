class User < ActiveRecord::Base

  has_many :reviews
  
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email.gsub!(" ","")
    user = self.find_by(email: email.downcase) if email
    user if user && user.authenticate(password)
  end

end
