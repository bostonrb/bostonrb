module ActiveRecord

  module ConnectionAdapters

    class MysqlAdapter

      def truncate_table(table_name)
        execute "TRUNCATE TABLE #{table_name}"
      end

    end

  end

end
