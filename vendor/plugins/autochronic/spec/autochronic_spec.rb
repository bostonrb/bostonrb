require File.dirname(__FILE__) + '/spec_helper'
require 'autochronic'
require 'activerecord'

setup_rails_database

class SpaceCowboy < ActiveRecord::Base
end

describe SpaceCowboy do
  before :each do
    @toker = SpaceCowboy.new
  end
  
  describe "'some_date' date field" do
    it 'should accept a date object' do
      date = Date.civil(2008, 2, 7)
      date_input = date
      @toker.some_date = date_input
      @toker.some_date.should == date
    end
    
    it 'should accept a date string' do
      date = Date.civil(2008, 2, 7)
      date_input = date.to_s
      @toker.some_date = date_input
      @toker.some_date.should == date
    end
    
    # WTF: this is presently giving me the next day
    it 'should accept a natural language date string' do
      date = Date.today
      date_input = 'today'
      @toker.some_date = date_input
      @toker.some_date.should == date
    end
    
    it 'should be nil on unusable input' do
      date_input = 'jozxyqk'
      @toker.some_date = date_input
      @toker.some_date.should be_nil
    end
  end
  
  describe "'some_time' datetime field" do
    it 'should accept a time object' do
      time = Time.local(2008, 2, 7, 23, 42, 0)
      time_input = time
      @toker.some_time = time_input
      @toker.some_time.should == time
    end
    
    it 'should accept a time string' do
      time = Time.local(2008, 2, 7, 23, 42, 0)
      time_input = time.to_s
      @toker.some_time = time_input
      @toker.some_time.should == time
    end
    
    it 'should accept a natural language time string' do
      date = Date.today
      time = Time.local(date.year, date.month, date.day, 5, 0, 0)
      time_input = 'today at 5 am'
      @toker.some_time = time_input
      @toker.some_time.should == time
    end
    
    it 'should be nil on unusable input' do
      time_input = 'jozxyqk'
      @toker.some_time = time_input
      @toker.some_time.should be_nil
    end
  end
  
  describe "'other_time' timestamp field" do
    it 'should accept a time object' do
      time = Time.local(2008, 2, 7, 23, 42, 0)
      time_input = time
      @toker.other_time = time_input
      @toker.other_time.should == time
    end
    
    it 'should accept a time string' do
      time = Time.local(2008, 2, 7, 23, 42, 0)
      time_input = time.to_s
      @toker.other_time = time_input
      @toker.other_time.should == time
    end
    
    it 'should accept a natural language time string' do
      date = Date.today
      time = Time.local(date.year, date.month, date.day, 5, 0, 0)
      time_input = 'today at 5 am'
      @toker.other_time = time_input
      @toker.other_time.should == time
    end
    
    it 'should be nil on unusable input' do
      time_input = 'jozxyqk'
      @toker.other_time = time_input
      @toker.other_time.should be_nil
    end
  end
  
  describe "'name' string field" do
    it 'should still accept strings normally' do
      name_input = 'Maurice'
      @toker.name = name_input
      @toker.name.should == name_input
    end
  end
  
  describe "'trees_shaken' integer field" do
    it 'should still accept strings normally' do
      integer = 5
      integer_input = '5'
      @toker.trees_shaken = integer_input
      @toker.trees_shaken.should == integer
    end
    
    it 'should still accept integers normally' do
      integer = 5
      integer_input = 5
      @toker.trees_shaken = integer_input
      @toker.trees_shaken.should == integer
    end
  end
end
