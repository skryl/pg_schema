# Features

* Automatically sets fully qualified table_name for all models
* Adds a schema aware db:create_with_schema rake task 

# Installation

Add the gem to your gemfile

    gem 'pg_schema'

Run install generator

    rails g pg_schema:install

Add a schema search path to your database.yml

    ...
    host: localhost
    database: my_project_dev
    schema_search_path: my_schema
    ...

Create db and schema

    rake db:create_with_schema

Test in console

    >> Model.table_name
    >> "my_schema.models"

# Issues

* Running the pg_schema:install with the schema_search_path set may break if the
  database already exists but the specified schema doesn't. Remove the
  schema_search_path from your database.yml, run pg_schema:install, then add the
  search path back before running db:create_with_schema.
