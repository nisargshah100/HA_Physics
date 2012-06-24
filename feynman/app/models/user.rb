class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider,
    :uid, :oauth_access_token

  has_many :events
  has_one :user_detail
  before_save :ensure_authentication_token

  extend Forwardable

  def_delegators :user_detail, :age, :orientation, :image, :zipcode, :display_name,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create( provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20],
                          oauth_access_token: auth.credentials.token)

      user.create_user_detail( image: auth.info.image.gsub("=square", "=large"),
                               gender: auth.extra.raw_info.gender,
                               birthday: Date.strptime(auth.extra.raw_info.birthday, "%m/%d/%Y"))
    end
    user
  end
end