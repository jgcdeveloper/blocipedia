# This will define the model for our wikis
class Wiki < ActiveRecord::Base
  belongs_to :user
end
