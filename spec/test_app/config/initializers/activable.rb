# Use this hook to configure Activable gem.
Activable.setup do |config|

  # Load the methods for ActiveRecord
  require 'activable/active_record'

  # Set here if your models have a responsible when they are either activated or
  # deactivated.
  config.set(has_responsible: true)

  # Configure here who is the responsible for activating or deactivating your
  # models. It has to be a class that extends ActiveRecord::Base.
  config.set(responsible: "User")
end
