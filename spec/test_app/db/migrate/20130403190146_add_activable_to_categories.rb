class AddActivableToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :activated_at, :datetime
    add_column :categories, :deactivated_at, :datetime
    add_column :categories, :activated_by_id, :integer
    add_column :categories, :deactivated_by_id, :integer
  end
end
