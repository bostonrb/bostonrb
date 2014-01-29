require 'spec_helper'

describe Location do
  it { should validate_presence_of :name }
  it { should validate_presence_of :street }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zipcode }

  it { should have_many :events }
end
