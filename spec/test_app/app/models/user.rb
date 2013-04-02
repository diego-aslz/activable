class User < ActiveRecord::Base
  is_activable
  attr_accessible :email
end
