require 'spec_helper'
require 'generators/activable/install_generator'

describe Activable::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates a default initializer" do
    assert_file "config/initializers/activable.rb"
  end
end
