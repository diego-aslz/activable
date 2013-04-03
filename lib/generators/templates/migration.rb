class AddActivableTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :activated_at, :datetime
    add_column :<%= table_name %>, :deactivated_at, :datetime
    add_column :<%= table_name %>, :activated_by_id, :integer
    add_column :<%= table_name %>, :deactivated_by_id, :integer
  end
end
