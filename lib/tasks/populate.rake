namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User].each(&:delete_all)
    
    User.populate(100) do |user|
      user.username = 'Sarah'
      user.gender ='female'
      user.password = 'password'
      user.img = 'http://www.labodabridal.com/wp-content/uploads/2014/05/woman.jpg', 
      user.age = 19..24, 
      user.bio = 'Looking for a great connection.'
      Preference.populate(100) do |p|
        p.user_id = user.id,
        p.gender_pref = ['female', 'male'],
        p.min_age = 26,
        p.max_age = 30,
        p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks'],
        p.lifestyle_pref = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
      end
    end

    User.populate(100) do |user|
      user.username = 'Matt'
      user.gender = 'male'
      user.password = 'password'
      user.img = 'http://www.headshotsla.com/wp-content/uploads/2013/06/81_Headshot-Los-Angeles1-1000x799.jpg', 
      user.age = 26..30, 
      user.bio = 'Looking for a great connection.'
      Preference.populate(100) do |p|
        p.user_id = user.id,
        p.gender_pref = ['female', 'male'],
        p.min_age = 19,
        p.max_age = 24,
        p.date_type_pref = ['coffee', 'dinner', 'show', 'drinks'],
        p.lifestyle_pref = ['adventurer', 'athletic', 'intellectual', 'professional', 'traveller', 'party animal', 'chill']
      end
    end

  end
end