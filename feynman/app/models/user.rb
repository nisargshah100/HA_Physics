class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider,
    :uid, :oauth_access_token, :display_name, :birthday

  has_one :user_detail, :dependent => :destroy, :autosave => true
  has_many :events, :dependent => :destroy
  has_many :messages, :foreign_key => :recipient_id

  before_save :ensure_authentication_token
  before_save :ensure_slug

  validates_uniqueness_of :display_name
  validates :display_name, :format => { :with => /^[a-z0-9]+$/i, :message => "can only contain numbers and letters" }
  validate :uniqueness_of_slug 

  extend Forwardable

  def_delegators :user_detail, :orientation, :image, :zipcode,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :height_feet,
    :height_inches, :exercise_level, :drinking_level, :smoking_level, :location,
    :complete?, :height, :objective_pronoun

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    unless user = User.where(:provider => auth.provider, :uid => auth.uid).first
      user = User.create_user_with_detail_for_facebook(auth)
    end
    user
  end

  def self.create_user_with_detail_for_facebook(auth)
    User.create(create_user_hash_from_facebook_auth(auth)).tap do |user|
      if user.provider == "facebook"
        user.create_user_detail(create_user_detail_hash_from_facebook_auth(auth))
      end
    end
  end

  def self.create_user_with_detail(user_params, user_detail_params)
    User.create(user_params).tap do |user|
      user.create_user_detail(user_detail_params)
    end
  end

  def self.create_user_hash_from_facebook_auth(auth)
    { provider: auth.provider,
    uid: auth.uid,
    email: auth.info.email,
    password: Devise.friendly_token[0,20],
    oauth_access_token: auth.credentials.token }
  end

  def self.create_user_detail_hash_from_facebook_auth(auth)
    { image: auth.info.image.gsub("=square", "=large"),
    gender: auth.extra.raw_info.gender.capitalize,
    birthday: Date.strptime(auth.extra.raw_info.birthday, "%m/%d/%Y") }
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def ensure_slug
    self.slug = display_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def uniqueness_of_slug
    if User.find_by_slug(slug)
      errors.add(:display_name, "That display name is already taken.")
    end
  end
end