class Bootstrapper
  class_inheritable_accessor :tasks
  write_inheritable_attribute :tasks, HashWithIndifferentAccess.new

  def self.for(key, &block)
    tasks[key] = block
  end

  def self.run(key)
    puts ">> Started executing bootstrap for #{key}"
    tasks[key].call(self)
    puts ">> Finished executing bootstrap for #{key}"
  end

  def self.truncate_tables(*tables)
    options = tables.last.is_a?(Hash) ? tables.pop : {}
    if tables == [:all]
      except = options[:except] || []
      except = except.is_a?(Array) ? except.collect { |x| x.to_s } : [except.to_s]

      tables = ActiveRecord::Base.connection.tables.select do |table|
        table !~ /schema_(info|migrations)/ && !except.include?(table)
      end
    end

    tables.each do |table|
      ActiveRecord::Base.connection.truncate_table(table)
    end
  end

  def self.fixtures(*fixtures)
    Fixtures.create_fixtures(File.join(RAILS_ROOT, 'db', 'populate'), fixtures)

  end

  def self.sql(sql)
    ActiveRecord::Base.connection.execute(sql)
  end
end
