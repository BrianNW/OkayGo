namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [User].each(&:delete_all)

    Lifestyle.populate 1 do |p|
      p.types = 'adventurer'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'athletic'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'intellectual'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'professional'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'traveller'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'party animal'
    end

    Lifestyle.populate 1 do |p|
      p.types = 'chill'
    end


  100.times do
    User.populate 1 do |user|
    user.username = 'Sarah'
    user.gender ='female'
    user.password = 'password'
    user.img = 'http://www.labodabridal.com/wp-content/uploads/2014/05/woman.jpg'
    user.age = 19..24
    end
    Deet.populate 1 do |d|
      d.user_id = 1..200
      d.about_me = 'Looking for a great connection.'
      d.lifestyle = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
      d.profession = ['doctor', 'lawyer', 'developer', 'artist', 'unemployed', 'bartender', 'server', 'accountant']
    end
    Preference.populate 1 do |p|
      p.user_id = 1..200
      p.gender_pref = ['female', 'male']
      p.min_age = 26
      p.max_age = 30
      p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks']
    end
    UserLifestylePref.populate 1 do |p|
      p.user_id = 1..200
      p.lifestyle_id = 4
    end
    UserLifestylePref.populate 1 do |p|
      p.user_id = 1..200
      p.lifestyle_id = 3
    end

    User.populate 1 do |user|
      user.username = 'Matt'
      user.gender = 'male'
      user.password = 'password'
      user.img = 'http://l.yimg.com/ea/img/-/130405/what_your_belly_really_costs_your_wing_man_18lspfl-18lsphs.jpg?x=450&q=80&n=1&sig=tWkqdYLMzZWtrQabG17MAQ--'
      user.age = 26..30
      end
      Deet.populate 1 do |d|
        d.user_id = 1..100
        d.about_me = 'Looking for adventure.'
        d.lifestyle = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
        d.profession = ['doctor', 'lawyer', 'developer', 'artist', 'unemployed', 'bartender', 'server', 'accountant']
      end
      Preference.populate 1 do |p|
        p.user_id = 1..100
        p.gender_pref = ['female', 'male']
        p.min_age = 26
        p.max_age = 30
        p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks']
      end
      UserLifestylePref.populate 1 do |p|
        p.user_id = 1..100
        p.lifestyle_id = 4
      end
      UserLifestylePref.populate 1 do |p|
        p.user_id = 1..100
        p.lifestyle_id = 3
      end


   end #FOR 100.times do

   ##for rails c
   #User.create(id:203, username: "Matt", password: "password", img: "http://l.yimg.com/ea/img/-/130405/what_your_belly_...", age: 27, gender: "male")

 end
end
