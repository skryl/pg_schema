require 'rails/generators'

module PgSchema
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "pg_schema:install"
      desc "Copy schema support files"
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_config
         template('config/pg_schema.rb', "config/initializers/pg_schema.rb")
      end

      def copy_rake_tasks
         template('lib/pg_schema.rake', "lib/tasks/pg_schema.rake")
      end
      
    end
  end
end
