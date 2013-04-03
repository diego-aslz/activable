class Category < ActiveRecord::Base
  is_activable has_responsible: false
  attr_accessible :name
end
