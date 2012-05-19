class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter < ActiveRecord::ConnectionAdapters::AbstractAdapter
    # Example:
    #   create_schema('products', 'postgres')
    def create_schema(schema_name, pg_username)
      execute("CREATE SCHEMA \"#{schema_name}\" AUTHORIZATION \"#{pg_username}\"")
    end

    # Drops a schema
    #
    # Example:
    #   drop_schema('products', 'postgres')
    def drop_schema(schema_name)
      execute("DROP SCHEMA \"#{schema_name}\"")
    end

    # Returns an array of all schemas in the database
    def all_schemas
      query('SELECT schema_name FROM information_schema.schemata').flatten
    end
end
