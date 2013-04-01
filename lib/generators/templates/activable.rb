# Use this hook to configure Activable gem.
Activable.setup do |config|
  # Set here if your models have a responsible when they are either activated or
  # deactivated.
  config.has_responsible = true

  # Configure here who is the responsible for activating or deactivating your
  # models. It has to be a class that extends ActiveRecord::Base.
  config.responsible = "User"
end
