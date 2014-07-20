FactoryGirl.define do
  factory :user do
    username 'Sarah'
    gender  'female'
    password 'password'
    img 'http://www.labodabridal.com/wp-content/uploads/2014/05/woman.jpg'
    age 19..24
  end