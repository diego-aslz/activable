module Activable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a Activable initializer."

      def copy_initializer
        template "activable.rb", "config/initializers/activable.rb"
      end
    end
  end
end
