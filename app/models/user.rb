class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :trackers
  has_many :wish_lists

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    auth_info = auth.info
	  email_is_verified = auth_info.email && (auth_info.verified || auth_info.verified_email)
	  email = auth_info.email if email_is_verified
	  user = User.where(:email => email).first if email

    if user.nil?
      user = User.new(
        name: auth.extra.raw_info.name,
        email: email,
        password: Devise.friendly_token[0,20]
      )
      user.save!
    end
    user
  end

end