# This will define the model for our wikis. Wikis will belong to a user.
class Wiki < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :collaborators
  has_many :users, ->{distinct}, through: :collaborators

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates_inclusion_of :private, in: [true, false]



end
