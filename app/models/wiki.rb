# This will define the model for our wikis. Wikis will belong to a user.
class Wiki < ActiveRecord::Base
  belongs_to :user
end
