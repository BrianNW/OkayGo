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
    500.times do |n|

      #BASIC INFO
      username = Faker::Internet.user_name
      password_digest = "pass"
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
        :address => ['San Francisco, US', 'Gastown, Vancouver, BC'].sample
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
      #MALE LIKES
      3.times do |n|
       Like.create({
        :user_id => user.id,
        :target_id => (1..200).to_a.sample
      })
     end
    end


      #FAKER FEMALE USERS
    500.times do |n|

      #BASIC INFO
      username = Faker::Internet.user_name
      password_digest = "password_digest"
      user = User.create!(:username => username,
        :img => ['assets/female1.jpg', 'assets/female2.jpg', 'assets/female3.jpg', 'assets/female4.jpg', 'assets/female5.jpg', 'assets/female6.jpg', 'assets/female7.jpg', 'assets/female8.jpg', 'assets/female9.jpg', 'assets/female10.jpg'].sample,
        :password_digest => 'pass',
        :age => 20 + rand(20),
        :gender => 'female'
      )

      #FAKER FEMALE USER PREFERENCES
      Preference.create({
        :user_id => user.id,
        :gender_pref => ['female', 'male', 'both'].sample,
        :min_age => 20 + rand(10),
        :max_age => 65,
        :address => ['San Francisco, US', 'Gastown, Vancouver, BC'].sample
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
      #FEMALE LIKES
      3.times do |n|
       Like.create({
        :user_id => user.id,
        :target_id => (1..200).to_a.sample
      })
     end
    end

 end
end
