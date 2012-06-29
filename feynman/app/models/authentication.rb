class Authentication < ActiveRecord::Base
  attr_accessible :user, :token, :provider, :last_status_id, :nickname, :uid, :secret
  belongs_to :user

  def self.create_instagram_auth(user, data)
    user.authentications.create(provider: data["provider"],
                                token: data["credentials"]["token"],
                                uid: data["uid"],
                                nickname: data["info"]["nickname"],
                                image: data["info"]["image"],
                                last_status_id: DateTime.now.to_s)
  end
end
