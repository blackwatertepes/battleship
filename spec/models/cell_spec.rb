require 'spec_helper'

describe Cell do
  let(:cell) { build(:cell) }
  
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :ship }
  
  it { should belong_to :ship }
  
  it "should be valid" do
    cell.should be_valid
  end
end
