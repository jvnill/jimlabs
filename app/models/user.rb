class User < ActiveRecord::Base
  validates_presence_of :email, :crypted_password, :salt
  attr_accessible :email, :password
  attr_accessor :password

  before_validation :encrypt_password

  def self.authenticate(email, pass)
    return nil if email.blank? || pass.blank?
    u = find_by_email(email)
    (u and u.crypted_password == encrypted_password(pass, u.salt)) ? u : nil
  end

  def encrypt_password
    if password
      self.salt = self.object_id.to_s + rand.to_s
      self.crypted_password = User.encrypted_password(password, salt)
    end
  end

  def self.encrypted_password(pass, salt)
    Digest::SHA1.hexdigest(pass + 'jim--labs' + salt)
  end
end
