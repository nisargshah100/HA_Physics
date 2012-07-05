class Seeder
  def self.build_db
    build_users(10)
    build_seeded_users
  end

  def self.build_seeded_users
    user1 = User.create(:email => "jessica@gmail.com", :password => "hungry", :display_name => "jessica", :birthday => "1986-07-10" )
    user2 = User.create(:email => "edweng@gmail.com", :password => "hungry", :display_name => "edweng", :birthday => "1988-06-21" )
    Image.create(:user => user1, :image_url => "http://distilleryimage8.instagram.com/ce38c5c8c3ff11e1b9f1123138140926_6.jpg" )
    Image.create(:user => user1, :image_url => "http://distilleryimage10.instagram.com/bfd8c600c1dd11e188131231381b5c25_6.jpg" )
    Image.create(:user => user1, :image_url => "http://distilleryimage3.s3.amazonaws.com/ea207d8074e511e181bd12313817987b_6.jpg" )
    Image.create(:user => user2, :image_url => "http://distilleryimage4.s3.amazonaws.com/71cdb9bea45711e1a9f71231382044a1_6.jpg", :width => "306", :height => "306" )
    Image.create(:user => user2, :image_url => "http://distilleryimage7.s3.amazonaws.com/6000791ca38311e192e91231381b3d7a_6.jpg", :width => "306", :height => "306" )
    Image.create(:user => user2, :image_url => "http://distilleryimage8.s3.amazonaws.com/5a3217b4332811e19e4a12313813ffc0_6.jpg", :width => "306", :height => "306" )
    Seeder.create_user_detail(user1)
    Seeder.create_user_detail(user2)
    user1.user_detail.update_attributes({:gender => "female", race: 8,:gender_preference => "men", :height => "5\"7", :employment => "Computer Programmer", :image_url => "http://distilleryimage9.s3.amazonaws.com/bd5d306ec4d011e1bf341231380f8a12_6.jpg"})
    user2.user_detail.update_attributes({:gender => "male", race: 1, :gender_preference => "women", :height => "5\"8", :employment => "Bonobos Model", :image_url => "http://distilleryimage7.s3.amazonaws.com/2943b926be5d11e1b2fe1231380205bf_6.jpg"})
  end

  def self.instagram_photos
    { female: [ "http://distilleryimage8.s3.amazonaws.com/1b5287c2c0b311e181bd12313817987b_6.jpg",
               "http://distilleryimage5.s3.amazonaws.com/4eb243febb5a11e1af7612313813f8e8_6.jpg",
               "http://distilleryimage1.s3.amazonaws.com/887b4d52c53111e19ab222000a1e8819_6.jpg",
               "http://distilleryimage6.s3.amazonaws.com/d4b90364c0c511e1b10e123138105d6b_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/06/06/c3ae7a4e52da42e694095b29f6f83222_6.jpg",
               "http://distilleryimage9.s3.amazonaws.com/f4d2f7c8512f11e1b9f1123138140926_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/06/03/70734f3837be4170865d1901707383ff_6.jpg",
               "http://distilleryimage6.s3.amazonaws.com/452c3a784fa911e19896123138142014_6.jpg",
               "http://distilleryimage6.s3.amazonaws.com/edcb5d681e2a11e1abb01231381b65e3_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/08/25/fdd6e5e7a45a444bad5d5dd314ef60cb_6.jpg",
               "http://distilleryimage3.s3.amazonaws.com/1f8d743e4f1911e1abb01231381b65e3_6.jpg",
              ],
    male:   [ "http://distilleryimage5.s3.amazonaws.com/3cc79412370e11e180c9123138016265_6.jpg",
               "http://distilleryimage0.s3.amazonaws.com/59ec3ace3cb911e1abb01231381b65e3_6.jpg",
               "http://distilleryimage9.s3.amazonaws.com/6cdc84a239af11e1a87612313804ec91_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/05/20/151669130abe4393807b5472d506260c_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/05/15/cbfd513113f242059f0b1a359fd375c2_6.jpg",
               "http://distilleryimage2.s3.amazonaws.com/a3e119d4502211e19e4a12313813ffc0_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/04/15/f41a3a68535f4e4aacb7e74ad0dca4b6_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/10/11/903be7c361784b82bfa4a43dff1c3026_6.jpg",
               "http://distilleryimage9.s3.amazonaws.com/3d78be1e242011e19e4a12313813ffc0_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/09/21/9ba15b7472204ce39275b98d29eb3679_6.jpg",
              ],
    photos: [ "http://distilleryimage9.s3.amazonaws.com/9a3a143a130511e180c9123138016265_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/05/14/bfee7650e024454f8d9a55b3eef14df5_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/06/11/2e3d81b328a24dc0b41ccd3f6a54ca84_6.jpg",
               "http://distilleryimage11.s3.amazonaws.com/cb900b544aa811e1a87612313804ec91_6.jpg",
               "http://distilleryimage1.s3.amazonaws.com/0b1b4b8c165911e19896123138142014_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/05/28/39c727a71b494f64b28a3a5a9f31c694_6.jpg",
               "http://distilleryimage6.s3.amazonaws.com/dc2a4ce81af811e1abb01231381b65e3_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/02/12/73965915f81c4768a7b8a383b431d5bb_6.jpg",
               "http://distilleryimage10.s3.amazonaws.com/f4a6fe6a355b11e1abb01231381b65e3_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/07/06/325fec4624d1473b9d5d3cd5b35aff2c_6.jpg",
               "http://distilleryimage1.s3.amazonaws.com/9f0834b4509111e19896123138142014_6.jpg",
               "http://distilleryimage1.s3.amazonaws.com/36fe58ae509f11e19e4a12313813ffc0_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/09/08/b647173a46aa4767b87fec9844c00370_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/10/11/b0a8b80ba8b747f29be271a90190c4d4_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/07/06/6acde770272340d3b404b8a2fcfdca8e_6.jpg",
               "http://distillery.s3.amazonaws.com/media/2011/08/26/56943e81529442748ad8b37463f2c000_6.jpg"
              ] }
  end

  def self.random_int_between(min, max)
    rand(max - min + 1) + min
  end

  def self.generate_fake_user
    first_name = "#{Faker::Name.first_name}"
    last_name = "#{Faker::Name.first_name}"

    { name: "#{first_name} #{last_name}",
      display_name: "#{first_name[0].downcase}#{last_name.downcase}" }
  end

  def self.random_gender
    [ "male", "female" ].sample
  end

  def self.random_gender_preference
    [ "men", "women", "both" ].sample
  end

  def self.rand_time(from, to)
    Time.at(rand_in_range(from.to_f, to.to_f))
  end

  def self.rand_in_range(from, to)
    rand * (to - from) + from
  end

  def self.build_users(quantity)
    quantity.times do
      user_hash = generate_fake_user
      user = User.create( 
        email: "#{Faker::Internet.email}",
        password: 'hungry',
        display_name: user_hash[:display_name],
        birthday: rand_time(30.years.ago, 21.years.ago))
      Seeder.create_user_detail(user)
      Seeder.create_events(user, random_int_between(1,3))
    end
  end

  def self.create_user_detail(user)
    gender = random_gender
    photo = instagram_photos[gender.to_sym].sample

    user.create_user_detail(:gender => gender,
                            :gender_preference => random_gender_preference,
                            :zipcode => "20036",
                            :faith => random_int_between(1, 12),
                            :children_preference => random_int_between(1, 5),
                            :education => random_int_between(1, 9),
                            :political_affiliation => random_int_between(1, 11),
                            :race => random_int_between(1, 9),
                            :exercise_level => random_int_between(1, 5),
                            :drinking_level => random_int_between(1, 5),
                            :smoking_level => random_int_between(1, 5),
                            :image_url => instagram_photos[gender.to_sym].sample )
  end

  def self.create_events(user, number_of_events)
    number_of_events.times do
      Event.create(:deal => get_random_deal, :user => user, :description => Faker::Lorem.sentence(10) )
    end
  end

  def self.get_random_deal
    Deal.active.near("20036",10).offset(rand(Deal.active.near("20036",10).size)).limit(1).first
  end
end