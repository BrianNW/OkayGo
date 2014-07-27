namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    Rake::Task['db:reset'].invoke


    #LIFESTYLE TABLE CONTENT
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


    #FIRST DATE TABLE CONTENT
    first_date = []

    first_date_array = ['coffee',
    'drinks',
    'comedy show',
    'hiking',
    'lunch',
    'skydiving',
    'dinner',
    'choose for me'].each do |types|
      types = FirstDate.where(:types => types).first_or_create!({
        :types => types
        })
      if types.new_record?
        if !types.save
          raise "Could not save types"
        end
      end
      first_date << types
    end


    #RANDOM PROFESSIONS FOR USERS
    profession = ['doctor',
      'lawyer',
      'developer',
      'artist',
      'unemployed',
      'bartender',
      'server',
      'accountant']


    #FAKER MALE USERS
    200.times do |n|

      #BASIC INFO
      username = Faker::Internet.user_name
      password_digest = "password_digest"
      user = User.create!(:username => username,
        :img => ['assets/male1.jpg', 'assets/male2.jpg', 'assets/male3.jpg', 'assets/male4.jpg', 'assets/male5.jpg', 'assets/male6.jpg', 'assets/male7.jpg', 'assets/male8.jpg', 'assets/male9.jpg', 'assets/male10.jpg', 'assets/male11.jpg'].sample,
        :password_digest => 'password_digest',
        :age => 20 + rand(20),
        :gender => 'male'
      )

      #FAKER MALE USERS PREFERENCE
      Preference.create({
        :user_id => user.id,
        :gender_pref => ['female', 'male', 'both'].sample,
        :min_age => 20 + rand(10),
        :max_age => 65,
      })

      #FAKER MALE USERS DEETS
      Deet.create({
        :user_id => user.id,
        :about_me => Faker::Lorem.sentence,
        :lifestyle => lifestyle_array[rand(7)],
        :profession => profession[rand(8)]
      })

      #FAKER MALE USERS LIFESTYLE PREFS
      LifestylePref.create({
        :user_id => user.id,
        :lifestyle_id => [1,2,3,4,5,6,7].sample
      })
      LifestylePref.create({
        :user_id => user.id,
        :lifestyle_id => [1,2,3,4,5,6,7].sample
      })

      #FAKER MALE USERS DATE TYPE PREFS
      FirstDatePref.create({
        :user_id => user.id,
        :first_date_id => [1,2,3,4,5,6,7].sample
      })
      FirstDatePref.create({
        :user_id => user.id,
        :first_date_id => [1,2,3,4,5,6,7].sample
      })
    end


      #FAKER FEMALE USERS
    200.times do |n|

      #BASIC INFO
      username = Faker::Internet.user_name
      password_digest = "password_digest"
      user = User.create!(:username => username,
        :img => ['assets/female1.jpg', 'assets/female2.jpg', 'assets/female3.jpg', 'assets/female4.jpg', 'assets/female5.jpg', 'assets/female6.jpg', 'assets/female7.jpg', 'assets/female8.jpg', 'assets/female9.jpg', 'assets/female10.jpg'].sample,
        :password_digest => 'password_digest',
        :age => 20 + rand(20),
        :gender => 'female'
      )

      #FAKER FEMALE USER PREFERENCES
      Preference.create({
        :user_id => user.id,
        :gender_pref => ['female', 'male', 'both'].sample,
        :min_age => 20 + rand(10),
        :max_age => 65,
      })

      #FAKER FEMALE USER DEETS
      Deet.create({
        :user_id => user.id,
        :about_me => Faker::Lorem.sentence,
        :lifestyle => lifestyle_array[rand(7)],
        :profession => profession[rand(8)]
      })

      #FAKER FEMALE USER LIFESTYLE PREF
      LifestylePref.create({
        :user_id => user.id,
        :lifestyle_id => [1,2,3,4,5,6,7].sample
      })

      #FAKER FEMALE USER DATE TYPE PREF
      FirstDatePref.create({
        :user_id => user.id,
        :first_date_id => [1,2,3,4,5,6,7].sample
      })
      FirstDatePref.create({
        :user_id => user.id,
        :first_date_id => [1,2,3,4,5,6,7].sample
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
  #   user.password_digest = 'password_digest'
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
  #   LifestylePref.populate 1 do |p|
  #     p.user_id = 1..200
  #     p.lifestyle_id = 4
  #   end
  #   LifestylePref.populate 1 do |p|
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
  #     LifestylePref.populate 1 do |p|
  #       p.user_id = 1..100
  #       p.lifestyle_id = 4
  #     end
  #     LifestylePref.populate 1 do |p|
  #       p.user_id = 1..100
  #       p.lifestyle_id = 3
  #     end


  #  end #FOR 100.times do

   ##for rails c
   #User.create(id:203, username: "Matt", password: "password", img: "http://l.yimg.com/ea/img/-/130405/what_your_belly_...", age: 27, gender: "male")

 end
end
