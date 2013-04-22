require 'spec_helper'

describe Cell do
  let(:cell) { build(:cell) }
  
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
end
