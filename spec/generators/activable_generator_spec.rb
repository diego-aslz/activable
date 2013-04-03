require 'spec_helper'
require 'generators/activable/activable_generator'

describe Activable::Generators::ActivableGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../../tmp", __FILE__)
  arguments %w(product)

  before do
    Activable.setup do |config|
      config.set(has_responsible: true)
      config.set(responsible: "Responsible")
    end
    prepare_destination
    copy_model
    run_generator
  end

  it "adds is_activable to the model" do
    assert_file 'app/models/product.rb', model_content
  end

  it "creates a migration file" do
    assert_migration "db/migrate/add_activable_to_products.rb", migration_content
  end

  protected

  def copy_model
    dest = File.join('tmp','app','models')
    FileUtils.mkdir_p dest
    FileUtils.cp(File.join('spec','test_app','app','models','product.rb'),
        File.join(dest,'product.rb'))
  end

  def migration_content
<<RUBY
class AddActivableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :activated_at, :datetime
    add_column :products, :deactivated_at, :datetime
    add_column :products, :activated_by_id, :integer
    add_column :products, :deactivated_by_id, :integer
  end
end
RUBY
  end

  def model_content
<<RUBY
class Product < ActiveRecord::Base
  is_activable
  attr_accessible :name
end
RUBY
  end
end
