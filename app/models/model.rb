class Model < ActiveRecord::Base

  # Relationships to other Entities
  has_many :products

  validates_presence_of :name
  validates_length_of   :name, :within => 2..32
  
  validates_uniqueness_of   :name
end
