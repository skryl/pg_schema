require 'pg_schema/postgresql_adapter'

module PgSchema
  module Loader
    extend ActiveSupport::Concern
    
    module ClassMethods

      # Let ActiveRecord do its magic and then include our overrides once a
      # model inherits from ActiveRecord::Base
      #
      def inherited(base)
        base.send(:include, PgSchema::Base)
        super
      end
    end
  end

  module Base
    extend ActiveSupport::Concern

    included do
       self.table_name = "#{schema_name}.#{table_name}"
    end

    module ClassMethods
      def schema_name
        @schema_name ||= ActiveRecord::Base.connection.schema_search_path.split.first
      end
    end

  end
end

class ActiveRecord::Base
  include PgSchema::Loader
end
