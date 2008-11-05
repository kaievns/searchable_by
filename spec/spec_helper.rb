require 'rubygems'
require 'spec'
require 'active_record'

unless defined? SortableBy
  require File.dirname(__FILE__)+"/../lib/searchable_by"
  require File.dirname(__FILE__)+"/../init.rb"
end

RAILS_ROOT = '' unless defined? RAILS_ROOT

# configuration of the test database environoment
$db_file = File.dirname(__FILE__)+"/db/test.sqlite3"
FileUtils.rm_rf($db_file)
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => $db_file)


# run mibrations
require File.dirname(__FILE__)+"/db/migrate/create_test_records.rb"

ActiveRecord::Migration.verbose = false

CreateTestRecordsTable.migrate(:up)

