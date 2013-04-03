require 'rails/generators/active_record'

module Activable
  module Generators
    class ActivableGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a migration to add the activable fields."
      def copy_migration
        klass = model_class
        raise "The model #{class_name.camelize} does not exists!" unless klass && klass.table_name
        migration_template "migration.rb", "#{migration_path}/add_activable_to_#{table_name}.rb"
      end

      desc "Adds activable fields to an existing model."
      def inject_activable_content
        content = <<CONTENT
  is_activable
CONTENT
        inject_into_class(model_path, model_class, content) if model_exists?
      end

      protected

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        File.join("app", "models", "#{class_name.downcase.singularize}.rb")
      end

      def model_class
        Object::const_get(class_name.singularize.camelize)
      end

      def migration_path
        File.join("db", "migrate")
      end
    end
  end
end
