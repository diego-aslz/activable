require 'spec_helper'

describe Activable do
  it "can be configured" do
    Activable.setup do |config|
      config.has_responsible = false
      config.responsible = "Atest"
    end
    Activable.has_responsible.should eql(false)
    Activable.responsible.should eql("Atest")
  end
end
