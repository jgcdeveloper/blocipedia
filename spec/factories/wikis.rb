FactoryGirl.define do
  factory :wiki do
    # Define a basic wiki
    title "A Test Wikipedia Title"
    body "This is a basic wikipedia entry"
    private false
    creator_id 1
  end
end
