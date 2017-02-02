FactoryGirl.define do
  # Define a basic devise user.
  factory :user do
    name "Example User"
    email "example@example.com"
    password "example"
    password_confirmation "example"
    confirmed_at Date.today
    role 0
  end
end
