FactoryGirl.define do
  factory :wiki do
    # Define a basic wiki
    title "MyString"
    body "MyText"
    private false
    user nil
  end
end
