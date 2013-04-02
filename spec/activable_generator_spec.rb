require 'spec_helper'
require 'generators/activable/activable_generator'

describe Activable::Generators::ActivableGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(users)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a migration file" do
    assert_file "db/migrate/*add_activable_to_users.rb"
  end
end
