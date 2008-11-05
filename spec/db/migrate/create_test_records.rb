require 'active_record'

class CreateTestRecordsTable < ActiveRecord::Migration
  def self.up
    create_table "test_records", :force => true do |t|
      t.string :title
      t.string :code
      t.string :code_i
      t.string :path
      t.string :host
    end
  end
  
  def self.down
    drop_table "test_records_table"
  end
end
