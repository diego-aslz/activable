require 'spec_helper'

describe User do
  it 'should have activable fields' do
    User.methods.include?(:is_activable).should be_true
    u = User.new
    u.attributes.include?("activated_at").should be_true
    u.attributes.include?("deactivated_at").should be_true
    u.activated_by.should be_nil
    u.deactivated_by.should be_nil
  end

  it 'cannot be saved without a responsible' do
    u = FactoryGirl.build(:user)
    u.save.should_not be_true
    u.errors[:activated_by_id].should_not be_empty
  end

  it 'is active by default' do
    u = FactoryGirl.build(:user)
    u.active?.should be_true
    u.activated_at.should_not be_nil
  end

  it 'can be activated' do
    admin = FactoryGirl.build(:user)
    admin.save(validate: false)

    u = FactoryGirl.build(:another_user)

    u.activate(responsible: admin)
    u.save.should be_true, "Activated user should be saved. " +
        u.errors.full_messages.to_s
    u.active?.should be_true
    u.activated_by.should be_equal admin
    u.activated_at.should_not be_nil
    u.deactivated_by.should be_nil
    u.deactivated_at.should be_nil
    User.active.include?(u).should be_true
  end

  it 'can be deactivated' do
    another_user = FactoryGirl.build(:another_user)
    another_user.save(validate: false)

    u = FactoryGirl.build(:another_user)

    u.deactivate(responsible: another_user)
    u.save.should be_true, "Deactivated user should be saved. " +
        u.errors.full_messages.to_s
    u.active?.should_not be_true
    u.deactivated_by.should be_equal another_user
    u.deactivated_at.should_not be_nil
    User.active.include?(u).should_not be_true
  end
end
