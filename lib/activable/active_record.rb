class ActiveRecord::Base
  def self.is_activable
    include Activable::Methods
  end
end
