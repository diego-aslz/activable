require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class ActivableGenerator < ActiveRecord::Generators::Base
      argument :tname, :type => :string, :default => "users", :banner => "users"
      source_root File.expand_path("../../templates", __FILE__)

      desc "Adds activable fields to an existing model."

      def create_migration
        raise Dir.pwd
        migration_template "migration.rb", "db/migrate/add_activable_to_#{tname}"
      end
    end
  end
end
