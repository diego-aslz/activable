require 'spec_helper'

describe Category do
  it 'should have activable fields' do
    Category.methods.include?(:is_activable).should be_true
    c = Category.new
    c.attributes.include?("activated_at").should be_true
    c.attributes.include?("deactivated_at").should be_true
    c.methods.include?(:activated_by).should_not be_true
    c.methods.include?(:deactivated_by).should_not be_true
  end

  it 'can be saved with no responsible' do
    u = FactoryGirl.build(:category)
    u.save.should be_true
  end

  it 'can be activated with no responsible' do
    c = FactoryGirl.build(:category)

    c.activate!.should be_true, "Activated category with no responsible should be saved. " +
        c.errors.full_messages.to_s
    c.active?.should be_true
    c.activated_by_id.should be_nil
    c.activated_at.should_not be_nil
    c.deactivated_by_id.should be_nil
    c.deactivated_at.should be_nil
    Category.active.include?(c).should be_true
    Category.inactive.include?(c).should_not be_true
  end

  it 'can be deactivated with no responsible' do
    c = FactoryGirl.build(:category)

    c.deactivate!.should be_true, "Deactivated category with no responsible should be saved. " +
        c.errors.full_messages.to_s
    c.active?.should_not be_true
    c.deactivated_by_id.should be_nil
    c.deactivated_at.should_not be_nil
    Category.active.include?(c).should_not be_true
    Category.inactive.include?(c).should be_true
  end
end
