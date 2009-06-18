module ActiveRecord

  module ConnectionAdapters

    class AbstractAdapter

      def truncate_table(table_name)
        execute "DELETE FROM #{table_name}"
      end

    end

  end

end
