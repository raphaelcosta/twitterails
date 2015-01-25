FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.user_name(nil,['_']) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
