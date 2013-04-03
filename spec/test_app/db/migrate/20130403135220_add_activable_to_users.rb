class AddActivableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, :default => true
    add_column :users, :activated_at, :datetime
    add_column :users, :deactivated_at, :datetime
    add_column :users, :activated_by_id, :integer
    add_column :users, :deactivated_by_id, :integer
  end
end
