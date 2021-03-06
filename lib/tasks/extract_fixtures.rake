desc 'Create YAML test fixtures from data in an existing database.'

require 'yaml/encoding'

class String
  alias :old_to_yaml :to_yaml

  def to_yaml(opts = {})
    YAML.escape(self).old_to_yaml(opts)
  end
end

task :extract_fixtures => :environment do
   sql = "Select * from %s"
   skip_tables = ["schema_migrations"]

   ActiveRecord::Base.establish_connection
   (ActiveRecord::Base.connection.tables - skip_tables).each do |table_name|
       i = "00"
       File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", "wb") do |file|
         data = ActiveRecord::Base.connection.select_all(sql % table_name)
	 file.write data.inject({}) { |hash, record|
	   hash["#{table_name}_#{i.succ!}"] = record
	   hash
	 }.to_yaml
       end
   end
end