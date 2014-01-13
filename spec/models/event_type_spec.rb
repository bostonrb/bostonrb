require 'spec_helper'

describe EventType do
  it { should validate_presence_of :name }
  it { should have_many :events }
end
