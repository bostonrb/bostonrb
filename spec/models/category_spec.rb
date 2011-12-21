require 'spec_helper'

describe Category do
  it { should_not have_valid(:name).when(nil, '') }

  describe '.find_or_create_many' do
    let!(:ruby) { Factory(:category, :name => 'Ruby') }
    describe 'with some categories' do
      before do
        Category.find_or_create_many_by_name(['Boston', 'Ruby', 'Rails'])
      end
      subject { Category.all.map(&:name) }
      its(:size) { should == 3 }
      it { should include 'Boston' }
      it { should include 'Ruby' }
      it { should include 'Rails' }
    end
    describe 'with nil categories' do
      before do
        Category.find_or_create_many_by_name(nil)
      end
      subject { Category.all.map(&:name) }
      its(:size) { should == 1 }
      it { should include 'Ruby' }
    end
  end
end
