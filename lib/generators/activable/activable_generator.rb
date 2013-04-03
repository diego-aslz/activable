require 'rails/generators/active_record'

module Activable
  module Generators
    class ActivableGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      argument :model_name, :type => :string, default: 'users', :banner => "a"

      desc "Adds activable fields to an existing model."
      def create_migration_file
        klass = model_class
        raise "The model #{model_name.camelize} does not exists!" unless klass && klass.table_name
        @table_name = klass.table_name
        migration_template "migration.rb", "#{migration_path}/add_activable_to_#{@table_name}.rb"
      end

      def inject_activable_content
        content = <<CONTENT
  is_activable
CONTENT
        inject_into_class(model_path, model_class, content) #if model_exists?
      end

      protected

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        File.join("app", "models", "#{model_name.downcase.singularize}.rb")
      end

      def model_class
        Object::const_get(model_name.singularize.camelize)
      end

      def migration_path
        File.join("db", "migrate")
      end
    end
  end
end
