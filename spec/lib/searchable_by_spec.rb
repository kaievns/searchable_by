require File.dirname(__FILE__) + "/../spec_helper"

class TestRecord < ActiveRecord::Base
  searchable_by :title
end

describe TestRecord do 
  before :all do
    TestRecord.delete_all
    @r1 = TestRecord.create :title => 'first record'
    @r2 = TestRecord.create :title => 'second record'
  end
  
  
end
