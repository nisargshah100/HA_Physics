class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :omniauthable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider,
    :uid, :oauth_access_token, :display_name, :birthday

  attr_accessor :back

  has_one :user_detail, :dependent => :destroy, :autosave => true
  has_many :events, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :messages, :foreign_key => :recipient_id
  has_many :authentications
  
  before_save :ensure_authentication_token
  before_save :ensure_slug

  validates_uniqueness_of :display_name
  validates :display_name, :format => { :with => /^[a-z0-9]+$/i, :message => "can only contain numbers and letters" }
  validate :uniqueness_of_slug 

  extend Forwardable

  def_delegators :user_detail, :orientation, :image, :zipcode,
    :gender, :gender_preference, :age_range_lower, :age_range_upper,
    :employment, :education, :faith, :faith_level, :political_affiliation,
    :political_affiliation_level, :race, :children_preference, :exercise_level, 
    :drinking_level, :smoking_level, :location, :complete?, :height, 
    :objective_pronoun, :latitude, :longitude, :city, :state, :country,
    :compatible_user_details, :nearby_compatible_user_details

  def self.create_user_with_detail(user_params, user_detail_params)
    User.create(user_params).tap do |user|
      user.create_user_detail(user_detail_params)
    end
  end

  def nearby_compatible_users(radius=10)
    User.where{ id.in my{ nearby_compatible_user_details(radius).pluck(:user_id) } }
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def ensure_slug
    self.slug = display_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def unread_messages_count
    messages.where(:status => "unread").count
  end

  def uniqueness_of_slug
    if User.find_by_slug(slug)
      errors.add(:display_name, "That display name is already taken.")
    end
  end

  def instagram_account
    authentications.where(provider: "instagram").first
  end

  def all_messages
    Message.where{ (sender_id.eq my{ id }) | (recipient_id.eq my{ id }) }
  end

  def messages_with_sender(sender)
      all_messages.where{ 
        (sender_id.eq my{ sender.id }) & (recipient_id.eq my{ id }) | 
        (recipient_id.eq my{ sender.id }) & (sender_id.eq my{ id })
      }
  end
end