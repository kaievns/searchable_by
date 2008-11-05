require 'active_record'

class CreateTestRecordsTable < ActiveRecord::Migration
  def self.up
    create_table "test_records_table", :force => true do |t|
      t.string :title
      t.string :hash
      t.string :hash_i
      t.string :path
      t.string :format
    end
  end
  
  def self.down
    drop_table "test_records_table"
  end
end
