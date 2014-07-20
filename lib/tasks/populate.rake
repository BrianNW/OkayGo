namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    Rake::Task['db:reset'].invoke

    date_types = ['coffee', 'drinks', 'show', 'active', 'dinner', 'I dunno!']
    profession = ['doctor', 'lawyer', 'developer', 'artist', 'unemployed', 'bartender', 'server', 'accountant']

    lifestyle = []

   lifestyle_array = ['adventurer',
    'athletic',
    'intellectual',
    'professional', 
    'traveller', 
    'party animal', 
    'chill'].each do |types|
      types = Lifestyle.where(:types => types).first_or_create!({
        :types => types
        })
      if types.new_record?
        if !types.save
          raise "Could not save types"
        end
      end
      lifestyle << types
    end

    50.times do |n|
      username = Faker::Internet.user_name
      password = "password"
      user = User.create!(:username => username,
        :img => ['http://photo.elsoar.com/wp-content/images/Joyful-man-face.jpg', 'http://cache3.asset-cache.net/xc/180525263.jpg?v=1&c=IWSAsset&k=2&d=B53F616F4B95E5538F86874878D58FC9F0CED0C3C0E8AFD3A01D3299CB6E2D99', 'http://blog.bonehealthnow.com/wp-content/uploads/2014/06/healthy-guy.jpg'].sample,
        :password => 'password',
        :age => 20 + rand(20),
        :gender => 'male'
        )
      preference = Preference.create({
      :user_id => user.id,
      :gender_pref => 'female',
      :min_age => 20 + rand(10),
      :max_age => 65,
      :date_type_pref => date_types[rand(4)]
      })
      deet = Deet.create({
        :user_id => user.id,
        :about_me => Faker::Lorem.sentence,
        :lifestyle => lifestyle_array[rand(7)],
        :profession => profession[rand(8)]
        })
      user_lifestyle_pref = UserLifestylePref.create({
        :user_id => user.id,
        :lifestyle_id => [1,2,3,4,5,6,7].sample
        })
    end

      50.times do |n|
      username = Faker::Internet.user_name
      password = "password"
      user = User.create!(:username => username,
        :img => ['http://4.bp.blogspot.com/-RDLJQzuB9JE/URDO8LGUyCI/AAAAAAAAAEU/YUxLKtcxKsI/s1600/girl%2B4.jpeg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdzO1sx1XUcnnA-M1ILmMSIdM6vO1oDM4RzcNiPkKB-Za8L6jSXQ',
          'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR00iA9UW4oVoD4arZ-Yx15iznEwFQXjHF8p3pnm3od73TwiIO_Sw'].sample,
        :password => 'password',
        :age => 20 + rand(20),
        :gender => 'female'
        )
      preference = Preference.create({
      :user_id => user.id,
      :gender_pref => 'male',
      :min_age => 20 + rand(10),
      :max_age => 65,
      :date_type_pref => date_types[rand(4)]
      })
      deet = Deet.create({
        :user_id => user.id,
        :about_me => Faker::Lorem.sentence,
        :lifestyle => lifestyle_array[rand(7)],
        :profession => profession[rand(8)]
        })
      user_lifestyle_pref = UserLifestylePref.create({
        :user_id => user.id,
        :lifestyle_id => [1,2,3,4,5,6,7].sample
        })
    end

    # image = File.open(Dir.glob(File.join(Rails.root, 'app/assets/images', '*')).sample),

  #   [User].each(&:delete_all)

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'adventurer'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'athletic'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'intellectual'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'professional'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'traveller'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'party animal'
  #   end

  #   Lifestyle.populate 1 do |p|
  #     p.types = 'chill'
  #   end


  # 100.times do
  #   User.populate 1 do |user|
  #   user.username = 'Sarah'
  #   user.gender ='female'
  #   user.password = 'password'
  #   user.img = 'http://www.labodabridal.com/wp-content/uploads/2014/05/woman.jpg'
  #   user.age = 19..24
  #   end
  #   Deet.populate 1 do |d|
  #     d.user_id = 1..200
  #     d.about_me = 'Looking for a great connection.'
  #     d.lifestyle = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
  #     d.profession = ['doctor', 'lawyer', 'developer', 'artist', 'unemployed', 'bartender', 'server', 'accountant']
  #   end
  #   Preference.populate 1 do |p|
  #     p.user_id = 1..200
  #     p.gender_pref = ['female', 'male']
  #     p.min_age = 26
  #     p.max_age = 30
  #     p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks']
  #   end
  #   UserLifestylePref.populate 1 do |p|
  #     p.user_id = 1..200
  #     p.lifestyle_id = 4
  #   end
  #   UserLifestylePref.populate 1 do |p|
  #     p.user_id = 1..200
  #     p.lifestyle_id = 3
  #   end

  #   User.populate 1 do |user|
  #     user.username = 'Matt'
  #     user.gender = 'male'
  #     user.password = 'password'
  #     user.img = 'http://l.yimg.com/ea/img/-/130405/what_your_belly_really_costs_your_wing_man_18lspfl-18lsphs.jpg?x=450&q=80&n=1&sig=tWkqdYLMzZWtrQabG17MAQ--'
  #     user.age = 26..30
  #     end
  #     Deet.populate 1 do |d|
  #       d.user_id = 1..100
  #       d.about_me = 'Looking for adventure.'
  #       d.lifestyle = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
  #       d.profession = ['doctor', 'lawyer', 'developer', 'artist', 'unemployed', 'bartender', 'server', 'accountant']
  #     end
  #     Preference.populate 1 do |p|
  #       p.user_id = 1..100
  #       p.gender_pref = ['female', 'male']
  #       p.min_age = 26
  #       p.max_age = 30
  #       p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks']
  #     end
  #     UserLifestylePref.populate 1 do |p|
  #       p.user_id = 1..100
  #       p.lifestyle_id = 4
  #     end
  #     UserLifestylePref.populate 1 do |p|
  #       p.user_id = 1..100
  #       p.lifestyle_id = 3
  #     end


  #  end #FOR 100.times do

   ##for rails c
   #User.create(id:203, username: "Matt", password: "password", img: "http://l.yimg.com/ea/img/-/130405/what_your_belly_...", age: 27, gender: "male")

 end
end
