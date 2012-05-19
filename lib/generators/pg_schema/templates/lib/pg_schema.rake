# https://github.com/rails/rails/blob/6c2a0675f11a9b5b8e88ed7dbccd65cb51be8029/activerecord/lib/active_record/railties/databases.rake
#
namespace :db do

  desc 'Create the database defined in config/database.yml for the current Rails.env - also makes test database if in development mode'
  task :create_with_schema => :load_config do
    # Make the test database at the same time as the development one, if it exists
    if Rails.env.development? && ActiveRecord::Base.configurations['test']
      create_database('test', ActiveRecord::Base.configurations['test'])
    end
    create_database(Rails.env, ActiveRecord::Base.configurations[Rails.env])
  end
  
  def create_database(env, config)
    if valid_connection?(config)
      $stderr.puts "#{config['database']} already exists in #{env}"
    else
      case config['adapter']
      when 'postgresql'
        encoding = config[:encoding] || ENV['CHARSET'] || 'utf8'
        schema_search_path = config.delete('schema_search_path') || 'public'
        default_schema = schema_search_path.split(',').first.strip

        begin
          unless valid_connection?(config)
            ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
            ActiveRecord::Base.connection.create_database(config['database'], config.merge('encoding' => encoding))
            ActiveRecord::Base.establish_connection(config)
            $stderr.puts "Database #{config['database']} has been created in #{env}."
          end
          ActiveRecord::Base.connection.create_schema(default_schema, config['username'])
          $stderr.puts "Schema #{default_schema} has been created in #{env}."
        rescue
          $stderr.puts $!, *($!.backtrace)
          $stderr.puts "Couldn't create database #{config.inspect} in #{env}"
        end
      else
        $stderr.puts "Only PostgreSQL is supported!"
      end
    end
  end


  def valid_connection?(config)
    ActiveRecord::Base.establish_connection(config)
    ActiveRecord::Base.connection && true
  rescue 
    false
  end

end
