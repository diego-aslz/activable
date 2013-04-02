class AddActivableTo<%= tname.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= tname %>, :active, :boolean, :default => true
    add_column :<%= tname %>, :activated_at, :datetime
    add_column :<%= tname %>, :deactivated_at, :datetime
    <% if Activable.has_responsible %>
      add_column :<%= tname %>, :activated_by_id, :integer
      add_column :<%= tname %>, :deactivated_by_id, :integer
    <% end %>
  end
end
