class Authentication < ActiveRecord::Base
  attr_accessible :user, :token, :provider, :last_status_id, :nickname, :uid, :secret, :image
  belongs_to :user

  def self.create_instagram(user, data)
    Authentication.create(get_params_hash(user, data))
  end

  def self.get_params_hash(user, data)
    if data["provider"] == "instagram"
      params_hash_from_instagram(data).merge({ user: user })
    end
  end

  def self.params_hash_from_instagram(data)
    { provider: data["provider"],
      token: data["credentials"]["token"],
      uid: data["uid"],
      nickname: data["info"]["nickname"],
      image: data["info"]["image"],
      last_status_id: DateTime.now.to_s }
  end
end
