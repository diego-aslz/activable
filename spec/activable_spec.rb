require 'spec_helper'

describe Activable do
  it "can be configured" do
    Activable.setup do |config|
      config.set has_responsible: false
      config.set responsible: "Atest"
    end
    Activable.configuration[:has_responsible].should eql(false)
    Activable.configuration[:responsible].should eql("Atest")
  end
end
