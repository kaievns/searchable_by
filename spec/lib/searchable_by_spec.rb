require File.dirname(__FILE__) + "/../spec_helper"

class TestRecord < ActiveRecord::Base
  searchable_by :title
  
  searchable_by :code => :exact,
                :code_i => :exact_i,
                :method_name => :exact_like
  
  searchable_by :path => :begin,
                :method_name => :which_begins_like
  
  searchable_by :format => :end,
                :method_name => :which_ends_like
end

describe TestRecord do 
  before :all do 
    TestRecord.delete_all
  end
  
  describe "simple 'like' search" do
    before :all do
      @r1 = TestRecord.create :title => 'first record'
      @r2 = TestRecord.create :title => 'second record'
    end
   
    it "should find both records by 'record' string" do 
      TestRecord.like('recor').should == [@r1, @r2]
    end
    
    it "should find the first record only by 'first' string" do 
      TestRecord.like('firs').should == [@r1]
    end
    
    it "should find the second recod only by 'second' string" do 
      TestRecord.like('sec').should == [@r2]
    end
  end
  
  describe "exact search" do 
    before :all do 
      @r1 = TestRecord.create :code => 'ASDF', :code_i => 'zxcv'
      @r2 = TestRecord.create :code => 'asdf', :code_i => 'ZXCV'
    end
    
    it "should find both record by case insensitive code" do 
      TestRecord.exact_like('zXcV').should == [@r1, @r2]
    end
    
    it "should find only the first record by upcased case-sensetive code" do 
      TestRecord.exact_like("ASDF").should == [@r1]
    end
    
    it "should find only the second record by downcased case-sensitive code" do 
      TestRecord.exact_like("asdf").should == [@r2]
    end
    
    it "should find nothing by mixed cased string" do 
      TestRecord.exact_like('aSDf').should be_empty
    end
    
    it "should find nothing by part of an exact string" do 
      TestRecord.exact_like('zx').should be_empty
    end
  end
end
