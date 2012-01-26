require 'spec_helper'

describe Setting do
  describe 'Validations' do
    it { should_not have_valid(:key).when(nil, '') }
    it { should have_valid(:key).when('some_key') }
    it { should_not have_valid(:value).when(nil, '') }
    it { should have_valid(:value).when('some_value') }

    it 'prevents duplicate keys' do
      setting1 = Factory(:setting)
      setting2 = Setting.new(:key => setting1.key, :value => 'another value')

      setting1.should be_valid
      setting2.should_not have_valid(:key)
    end

    describe '[key]' do
      it 'returns the setting\'s value by key' do
        setting = Factory(:setting)
        Setting[setting.key].should eq(setting.value)
      end

      it 'returns nil if there is no existing setting for the given key' do
        setting = Factory.build(:setting)
        Setting.find_by_key(setting.key).should be_nil
        Setting[setting.key].should be_nil
      end

    end

    describe '[key]=' do
      it 'adds a new setting if the it doesn\'t exist' do
        setting = Factory.build(:setting)
        Setting.find_by_key(setting.key).should be_nil
        Setting[setting.key] = setting.value
        retrieved_setting = Setting.find_by_key(setting.key)
        retrieved_setting.value.should eq(setting.value)
      end

      it 'changes the value of the setting if it exists' do
        setting = Factory(:setting)
        Setting[setting.key] = 'a new value'
        retrieved_setting = Setting.find_by_key(setting.key)
        retrieved_setting.value.should eq('a new value')
      end
    end
  end
end
