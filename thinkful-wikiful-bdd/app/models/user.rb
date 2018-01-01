class User < ActiveRecord::Base
  has_secure_password

  validates_length_of :name, minimum: 4, maximum: 32

  validates_length_of :user_name, minimum: 4, maximum: 16
  validates_uniqueness_of :user_name

  validates_length_of :email, minimum: 3, maximum: 254
  validates_uniqueness_of :email
  validates_format_of :email, with: /@/

  validates_length_of :password, minimum: 6, maximum: 16

  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W]).{6,16}\z/, 
    message: 'Password must contain at least one upper and lowercase letter, one digit, and one special character' 

  has_many :articles

  def self.account_exists?(user)
    User.where('user_name = ? OR email = ?', user.user_name, user.email).count > 0
  end
end
