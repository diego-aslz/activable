FactoryGirl.define do
  factory :user do
    email "user@nomail.com"
  end

  factory :another_user, class: User do
    email "another_user@nomail.com"
  end
end
